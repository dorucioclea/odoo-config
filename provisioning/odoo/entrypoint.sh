#!/bin/bash

set -e

# Set necessary variables
ODOO_DATABASE=${ODOO_DB}
ODOO_ADMIN_PASSWORD=${ADMIN_PASSWORD}
ODOO_EMAIL=${ODOO_EMAIL}
ODOO_USER=${USER}

# Set PostgreSQL connection parameters
export PGHOST=${DB_HOST}
export PGPORT=6432
export PGUSER=$ODOO_USER
export PGPASSWORD=${ODOO_ADMIN_PASSWORD}


if [[ "$1" == "odoo" ]]; then
    shift
    envsubst < /etc/odoo/odoo.conf.template > /etc/odoo/odoo.conf
fi

# Install required modules
MODULES_TO_INSTALL="hr,account,timesheet_holiday"

# Wait for Odoo to become available
TRIES=0
MAX_TRIES=30
while ! pg_isready -h "$PGHOST" -p "$PGPORT" -U "$ODOO_USER" && [ $TRIES -lt $MAX_TRIES ]
do
  echo "Waiting for Odoo database to become available... (attempt $((TRIES+1))/$MAX_TRIES)"
  sleep 2
  TRIES=$((TRIES+1))
done

if [ $TRIES -eq $MAX_TRIES ]; then
  echo "Failed to connect to the Odoo database after $MAX_TRIES attempts. Exiting."
  exit 1
fi

# Initialize Odoo database with specified modules
odoo -d "$ODOO_DATABASE" -i "$MODULES_TO_INSTALL" --stop-after-init --db_user="$ODOO_USER" --db_password="$ODOO_ADMIN_PASSWORD"

# Start Odoo
exec odoo -d "$ODOO_DATABASE" --db_user="$ODOO_USER" --db_password="$ODOO_ADMIN_PASSWORD"