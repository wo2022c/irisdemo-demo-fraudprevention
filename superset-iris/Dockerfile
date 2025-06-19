FROM apache/superset:4.0.1

USER root
# install unzip
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

USER superset
# install iris plugin
COPY superset-iris/superset_iris /app/superset-iris
#RUN pip install -e /app/superset-iris

# copy dashboards and entrypoint
COPY superset-iris/database_iris.zip /app/database_iris.zip
COPY superset-iris/dashboard_iris.zip /app/dashboard_iris.zip
COPY superset-iris/docker-entrypoint.sh /app/docker-entrypoint.sh
USER root
RUN chmod +x /app/docker-entrypoint.sh

# connection to IRIS via env vars
ENV SQLALCHEMY_DATABASE_URI="iris://_system:sys@datalake:1972/APP"

CMD ["/app/docker-entrypoint.sh"]
