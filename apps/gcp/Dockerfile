FROM google/cloud-sdk:alpine
RUN apk --update add openjdk7-jre
RUN gcloud components install app-engine-java kubectl

# Alternative to this Dockerfile is here:
# https://cloud.google.com/sdk/docs/

# To run gcloud program
# sudo docker run -ti gcp1 gcloud version
# bash also works
# sudo docker run -ti gcp1 /bin/bash
