FROM quay.io/jupyter/minimal-notebook:latest

ARG PBP_VERSION
WORKDIR /opt/pbp

USER root
RUN apt-get update && apt-get install -y libsox-fmt-all libsox-dev
RUN pip install mbari-pbp==$PBP_VERSION
COPY . /opt/pbp

RUN chown -R jovyan /opt/pbp
USER jovyan

ENV PYTHONPATH=/opt/pbp:/opt/pbp/pbp
EXPOSE 8888

CMD ["/opt/conda/bin/jupyter", "notebook", "--notebook-dir=/opt/pbp", "--ip='*'","--port=8888","--no-browser", "--allow-root"]
