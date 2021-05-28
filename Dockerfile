FROM golang:alpine as builder
COPY ./go/bin /go/bin/api-gateway
WORKDIR /go/bin/api-gateway
RUN apk add build-base && go mod tidy && go build main.go

FROM alpine
COPY --from=builder /go/bin/api-gateway/main /go/bin/api-gateway/API-Gateway
COPY --from=builder /go/bin/api-gateway/config go/bin/api-gateway/config
COPY --from=builder /go/bin/api-gateway/krakend.json /go/bin/api-gateway/krakend.json
USER 0
RUN chmod +w go/bin/api-gateway/config && chmod +x /go/bin/api-gateway/API-Gateway
EXPOSE 7070
ENV FC_ENABLE=1
ENV FC_SETTINGS=/go/bin/api-gateway/config/settings
ENV FC_PARTIALS=/go/bin/api-gateway/config/partials
ENV FC_OUT=/go/bin/api-gateway/compiled-krakend.json
ENV FC_TEMPLATES=/go/bin/api-gateway/config/templates
WORKDIR /go/bin/api-gateway
ENTRYPOINT ["./API-Gateway","run", "-c","./krakendEnv.json"]