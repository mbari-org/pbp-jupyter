FROM quay.io/jupyter/minimal-notebook:latest

WORKDIR /opt/pbp

RUN pip install mbari-pbp==1.0.8

USER root
RUN apt-get update && apt-get install -y libsox-fmt-all libsox-dev
COPY . /opt/pbp
RUN chown -R jovyan /opt/pbp
USER jovyan

ENV PYTHONPATH=/opt/pbp:/opt/pbp/pbp
EXPOSE 8888

CMD ["/opt/conda/bin/jupyter", "notebook", "--notebook-dir=/opt/pbp", "--ip='*'","--port=8888","--no-browser", "--allow-root"]
