#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Load uint128 into $POSTGRES_DB
echo "Updating uint128 extension in '$POSTGRES_DB' to $UINT128_VERSION"
psql --dbname="$DB" -c "
    CREATE EXTENSION IF NOT EXISTS uint128 VERSION '$UINT128_VERSION';
    ALTER EXTENSION uint128 UPDATE TO '$UINT128_VERSION';
"
