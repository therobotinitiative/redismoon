#!/bin/bash
REDIS_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$REDIS_DIR/../forestbash/forest.functions.sh"

# Load gradle.properties into associative array
declare -A properties
forest_load_properties properties "$REDIS_DIR/gradle.properties"

forestnetwork=$(forest_resolve_network_name "$REDIS_DIR/../gradle.properties")

# Run the docker container for Redis
log_lgreen "Starting Redis Moon Container"
docker run -d --name redis-moon \
                -p "${properties[redismoon.port]}":6379 \
                --network="${forestnetwork}" \
                "${properties[redismoon.image.name]}":"${properties[redismoon.image.version]}"
log_lgreen "Redis Moon Container started"
log_nc ""
