FROM quay.io/jupyter/minimal-notebook:2024-08-01

ARG PBP_VERSION
ARG USERNAME=jovyan
ARG USER_UID=1000
ARG USER_GID=100

WORKDIR /opt/pbp

USER root
RUN apt-get update && apt-get install -y libsox-fmt-all libsox-dev
RUN pip install ipywidgets
RUN pip install mbari-pbp==$PBP_VERSION
COPY . /opt/pbp

# Modify the jovyan user to have the specified UID and GID
RUN usermod -u ${USER_UID} -g ${USER_GID} ${USERNAME} \
    && chown -R ${USER_UID}:${USER_GID} /home/${USERNAME}

# If wanting to disable need for authentication:
# ==== IMPORTANT: This is a security risk, and should only be used for local development ====
RUN jupyter notebook --generate-config \
 && echo "c.ServerApp.token    = ''"  >> /home/${USERNAME}/.jupyter/jupyter_notebook_config.py \
 && echo "c.ServerApp.password = ''"  >> /home/${USERNAME}/.jupyter/jupyter_notebook_config.py \
 && chown -R ${USER_UID}:${USER_GID}     /home/${USERNAME}/.jupyter

RUN chown -R ${USER_UID}:${USER_GID} /opt/pbp

USER ${USERNAME}

ENV PYTHONPATH=/opt/pbp
EXPOSE 8888

CMD ["/opt/conda/bin/jupyter", "notebook", "--notebook-dir=/opt/pbp", "--ip='*'","--port=8888","--no-browser", "--allow-root"]