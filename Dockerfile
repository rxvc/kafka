FROM rxvc/kafka-base:1.0.0

MAINTAINER Rodrigo Vallejo  <rxvallejocj@gmail.com>

ENV COMPONENT=kafka
ENV KAFKA_VERSION=2.1.0
ENV SCALA_VERSION=2.12

RUN wget http://www-eu.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && tar -xvzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && rm -rf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /usr/lib/${COMPONENT} \
    && echo "===> Setting up ${COMPONENT} dirs..." \
    && mkdir -p /var/lib/${COMPONENT}/data /etc/${COMPONENT}/secrets \
    && chmod -R ag+w /etc/${COMPONENT} /var/lib/${COMPONENT}/data /etc/${COMPONENT}/secrets

ENV KAFKA_HOME=/usr/lib/${COMPONENT}
ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY docker/config_templates /etc/${COMPONENT}/docker/config
COPY docker/scripts /usr/lib/${COMPONENT}/docker/bin/

EXPOSE 9092

CMD ["/usr/lib/kafka/docker/bin/run"]
