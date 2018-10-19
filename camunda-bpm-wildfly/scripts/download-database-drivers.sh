#!/bin/sh

set -x
POSTGRESQL_VERSION=9.3-1102-jdbc4
#curl -L "${NEXUS}?r=public&g=org.postgresql&a=postgresql&v=${POSTGRESQL_VERSION}&p=jar" -o ${LIB_DIR}/postgresql-${POSTGRESQL_VERSION}.jar