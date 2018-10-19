FROM camunda/camunda-bpm-platform:wildfly11
# inherit shell scripts from Community Edition image

ENV LIB_DIR /camunda/lib
ENV NEXUS https://app.camunda.com/nexus/service/local/artifact/maven/redirect
ENV VERSION 7.9.0

ARG MANAGEMENT_USERNAME
ARG MANAGEMENT_PASSWORD

# remove H2
RUN if [ "$DB_DRIVER" != "h2" ]; then rm /camunda/standalone/deployments/camunda-h2-webapp-${CAMUNDA_VERSION}.war; fi

# re-add database drivers
USER root
RUN apk add --no-cache curl
USER camunda
COPY scripts/download-database-drivers.sh /usr/local/bin/
RUN /usr/local/bin/download-database-drivers.sh "${NEXUS}?r=public&g=org.camunda.bpm&a=camunda-database-settings&v=${VERSION}&p=pom"

# disable automatic DB schema creation/updates
RUN sed -i 's#<property name="isAutoSchemaUpdate">true</property>#<property name="isAutoSchemaUpdate">false</property>#' /camunda/standalone/configuration/standalone.xml

# Add management user to access Management Web Console and to allow deployment with wilfly-maven-plugin

RUN if [ "$MANAGEMENT_USERNAME" != "" ]; then ./bin/add-user.sh $MANAGEMENT_USERNAME $MANAGEMENT_PASSWORD; fi

# add script to wait for database startup
COPY scripts/wait-for-connection.sh /usr/local/bin/
COPY scripts/configure-and-run.sh /usr/local/bin/

CMD /usr/local/bin/wait-for-connection.sh && /usr/local/bin/configure-and-run.sh
