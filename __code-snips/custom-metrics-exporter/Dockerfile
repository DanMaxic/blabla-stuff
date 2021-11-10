FROM alpine:3.7
LABEL   name="selenium_metrics_exporter for K8S HPA" \
		maintainer="sre team " \
		build-date="20200801"

WORKDIR /root/
ENV HUB_PORT_4444_TCP_ADDR='' HUB_PORT_4444_TCP_PORT=4444 

EXPOSE 9300 9300

RUN apk --no-cache add curl jq bc
ADD ./src/* ./
COPY ./scripts ./scripts

CMD ["./bash-exporter","-interval","10","-web.listen-address","0.0.0.0:9300", "-prefix","selenium_metrics_slots","-path","/root/scripts"," -debug" ]
