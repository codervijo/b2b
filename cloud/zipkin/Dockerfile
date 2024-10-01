# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    openjdk-17-jre \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Download and install Zipkin
RUN wget -O zipkin.jar https://repo1.maven.org/maven2/io/zipkin/zipkin-server/3.4.0/zipkin-server-3.4.0-exec.jar
# Expose the port that Zipkin uses
EXPOSE 9411

# Command to run Zipkin
CMD ["java", "-jar", "zipkin.jar"]