FROM balenalib/raspberrypi4-64-debian-python:3.7-buster-build

WORKDIR /home/pi
COPY app.py app.py

# Install wait-for-datadog.sh dependencies.
RUN apt-get update -y
RUN apt-get install -y netcat
RUN apt-get install -y jq

COPY wait-for-datadog.sh wait-for-datadog.sh
RUN chmod +x wait-for-datadog.sh
