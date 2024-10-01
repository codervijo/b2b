FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV KAFKA_VERSION=3.8.0
ENV SCALA_VERSION=2.13

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    openjdk-17-jre \
    wget \
    netcat && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for Kafka
RUN mkdir /kafka

# Download and install Kafka
RUN wget -q "https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz" && \
    tar -xzf "kafka_2.13-${KAFKA_VERSION}.tgz" --strip-components=1 -C /kafka && \
    rm "kafka_2.13-${KAFKA_VERSION}.tgz"

# Expose the Kafka ports
EXPOSE 9092

# Copy the start script
COPY start-kafka.sh /usr/local/bin/start-kafka.sh
RUN chmod +x /usr/local/bin/start-kafka.sh

# Start Zookeeper and Kafka
CMD ["/usr/local/bin/start-kafka.sh"]
