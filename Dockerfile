FROM golang:1.21 AS build

WORKDIR /go/src/app

COPY . .

RUN GO111MODULE=on CGO_ENABLED=0 go build -o mosquitto_exporter -a -ldflags '-extldflags "-static"' .

FROM scratch

COPY --from=build /go/src/app/mosquitto_exporter /mosquitto_exporter

EXPOSE 9234

ENTRYPOINT [ "/mosquitto_exporter" ]
