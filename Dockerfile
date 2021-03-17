FROM golang:alpine as builder
COPY . $GOPATH/bin/api-gateway
WORKDIR $GOPATH/bin/api-gateway
RUN go get -d -v github.com/devopsfaith/krakend
RUN ls -a
RUN go build go/bin/api-gateway/main.go
RUN ls -a
FROM scratch
COPY --from=builder /go/bin/api-gateway/main /go/bin/api-gateway/api-gateway
ENTRYPOINT ["/go/bin/api-gateway/api-gateway"]