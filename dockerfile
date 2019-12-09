FROM alpine

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 1.1.0

COPY kafka_2.11-1.1.0.tgz /tmp

RUN apk add --no-cache sed openjdk7-jre netcat-openbsd && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    mv /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION" /opt/kafka && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz 

COPY entrypoint.sh /usr/local

EXPOSE 2181 9092

ENTRYPOINT ["/usr/local/entrypoint.sh"]
