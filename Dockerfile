FROM alpine:latest
ENV SMARTMETER_DEVICE /dev/ttyUSB0
ENV MQTT_HOST eclipse-mosquitto
RUN apk update && apk add bash perl perl-device-serialport mosquitto-clients
RUN mkdir /app
ADD https://github.com/ohitz/smartmeter-readout/raw/master/smartmeter-readout /app
RUN chmod +x /app/smartmeter-readout
COPY mqtt /app
WORKDIR /app
CMD ./smartmeter-readout -r 1.8.0 -n -c -w 30 $SMARTMETER_DEVICE | ./mqtt
