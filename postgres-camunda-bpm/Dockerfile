FROM postgres:9.6-alpine
# Camunda BPM 7.7.x is supported on PostgreSQL 9.6.
# See also: https://docs.camunda.org/manual/latest/introduction/supported-environments/

# install a wget version that supports SSL and login
RUN apk --no-cache add \
    ca-certificates \
    wget \
    && update-ca-certificates

# no suffix '-ee' in CAMUNDA_VERSION!
ENV CAMUNDA_VERSION 7.9.0
ENV DISTRO wildfly11

# download SQL scripts for Camunda BPM
RUN wget -O - "https://camunda.org/release/camunda-bpm/${DISTRO}/$(echo $CAMUNDA_VERSION | cut -c 1-3)/camunda-bpm-${DISTRO}-${CAMUNDA_VERSION}.tar.gz" | \
    tar xzf - --directory /docker-entrypoint-initdb.d/ "sql/create/postgres_engine_${CAMUNDA_VERSION}.sql" "sql/create/postgres_identity_${CAMUNDA_VERSION}.sql" --strip 2