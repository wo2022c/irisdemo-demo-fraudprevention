#!/bin/bash

superset db upgrade

superset fab create-admin \
            --username admin \
            --firstname Superset \
            --lastname Admin \
            --email admin@superset.com \
            --password ${ADMIN_PASSWORD:-admin}

superset init

# if [[ "${SUPERSET_SQLALCHEMY_EXAMPLES_URI}" =~ ^iris:// ]]; then
#     superset load-examples &
# fi

#superset import-databases --path /app/databases --username admin
superset import-dashboards --path /app/dashboard.zip --username admin >> /tmp/superset_dashboard.log  2>&1 &


/usr/bin/run-server.sh