FROM quay.io/jupyter/minimal-notebook:python-3.11

ARG PBP_VERSION
ARG USERNAME=jovyan
ARG USER_UID=1000
ARG USER_GID=100

WORKDIR /opt/pbp

# For system installations
USER root

RUN apt-get update && apt-get install -y \
    libsox-fmt-all \
    libsox-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    ipywidgets==8.1.5 \
    mbari-pbp==$PBP_VERSION

COPY . /opt/pbp

# Modify the jovyan user to have the specified UID and GID
RUN usermod -u ${USER_UID} -g ${USER_GID} ${USERNAME} \
    && chown -R ${USER_UID}:${USER_GID} /home/${USERNAME}

RUN chown -R ${USER_UID}:${USER_GID} /opt/pbp

# Switch back to jovyan user
USER ${USERNAME}

ENV PYTHONPATH=/opt/pbp
EXPOSE 8888

# Use the standard Jupyter start script
CMD ["start-notebook.py", "--notebook-dir=/opt/pbp"]
