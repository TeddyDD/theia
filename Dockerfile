ARG GO_VERSION=1.14

FROM golang:$GO_VERSION-alpine3.11 AS builder
RUN apk --no-cache add git
ENV CGO_ENABLED=0

COPY caddy /caddy
WORKDIR /caddy

RUN go get
RUN go build -ldflags "-w -s" && go install

COPY ./md2html /md2html
WORKDIR /md2html
RUN go get
RUN go build -ldflags "-w -s" && go install

WORKDIR /
COPY ./dependencies ./dependencies
COPY ./scripts/install_tool.sh ./install_tool
RUN ./install_tool dependencies

ARG strip

RUN [ -n "$strip" ] &&  ( apk --no-cache add binutils && \
  strip /go/bin/* && du -hs /go/bin/* ) || :

ARG upx

RUN [ -n "$upx" ] &&  ( apk --no-cache add upx && \
  upx $upx /go/bin/* && du -hs /go/bin/* ) || :

FROM alpine:latest
COPY --from=builder /go/bin/* /usr/local/bin/

ARG packages

RUN [ -n "$packages" ] && (apk --no-cache add $packages) || :
USER 1000:1000
WORKDIR /app
CMD ["caddy"]
