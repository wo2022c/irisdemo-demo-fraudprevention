FROM apache/superset:4.0.1

RUN --mount=type=bind,src=superset,dst=/tmp/dist/superset-iris \
    mkdir -p ~/superset-iris/ && \
    cp -fR /tmp/dist/superset-iris/* ~/superset-iris/; \
    pip install -e ~/superset-iris

COPY superset/docker-entrypoint.sh /app/

COPY superset/superset_config.py /app/pythonpath/superset_config.py
COPY superset/dashboard_iris.zip /app/dashboard_iris.zip

CMD [ "/app/docker-entrypoint.sh" ]