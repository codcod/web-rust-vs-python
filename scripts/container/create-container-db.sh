#!/usr/bin/env sh
#
# create-container-db.sh:
# Create a Podman container for PostgreSQL database filled with initial data.
#
# Other options to `podman` command:
#   --rm \
#   --userns keep-id:uid=999,gid=999 \
#   --log-level=debug \

if [[ ! "$OSTYPE" == "darwin"* ]]; then
    echo "Script tested only in MacOS. Exiting..."
    exit 1
fi

POSTGRES_MAX_CONNECTIONS=500    # default is 100
DATA_DIR="./container-data"     # add to `.gitignore`

pg_data_dir=$DATA_DIR/pg_data

echo "Emptying data directory..."
rm -rf $DATA_DIR && mkdir -p $pg_data_dir
cp ./scripts/container/psql_history $DATA_DIR

echo "Creating the container..."
podman run -d \
    --name postgres-web-rust-vs-python \
    --userns keep-id:uid=$(id -ur),gid=999 \
    --security-opt label=disable \
    --log-level=debug \
    -p 15432:5432 \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e POSTGRES_DB=postgres \
    -v "$pg_data_dir:/var/lib/postgresql/data" \
    -v "./scripts/sql/create.sql:/docker-entrypoint-initdb.d/create.sql" \
    -v "./scripts/sql/seed.sql:/docker-entrypoint-initdb.d/seed.sql" \
    -v "$DATA_DIR/psql_history:/.psql_history" \
    postgres -N $POSTGRES_MAX_CONNECTIONS

# vim: sw=4:et:ai
