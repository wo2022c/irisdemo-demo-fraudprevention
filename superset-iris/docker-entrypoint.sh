#!/bin/bash
set -e

# migrate metadata
superset db upgrade

# create admin if missing
superset fab create-admin \
  --username "${ADMIN_USER:-admin}" \
  --firstname Admin \
  --lastname User \
  --email "${ADMIN_EMAIL:-admin@example.com}" \
  --password "${ADMIN_PASSWORD:-admin}" || true

# init roles & default data
superset init

# # unpack dashboards
# IMPORT_DIR=/tmp/iris_dash
# mkdir -p $IMPORT_DIR
# unzip -o /app/iris_dashboard.zip -d $IMPORT_DIR

# # import in order
# superset import-datasources --path $IMPORT_DIR --username "${ADMIN_USER:-admin}" || echo "no datasources"
# superset import-charts      --path $IMPORT_DIR --username "${ADMIN_USER:-admin}" || echo "no charts"
# superset import-dashboards  --path $IMPORT_DIR --username "${ADMIN_USER:-admin}" || echo "no dashboards"

superset import_datasources -p /app/database_iris.zip --username admin >> /tmp/superset_datasources.log 2>&1 &
superset import-dashboards --path /app/dashboard_iris.zip --username admin >> /tmp/superset_dashboard.log  2>&1 &

# start server
exec superset run --host 0.0.0.0 --port 8088
