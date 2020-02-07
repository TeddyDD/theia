ARG go_version
FROM golang:${go_version:-1.13.7}-alpine3.11 AS builder


COPY caddy /caddy
WORKDIR /caddy

RUN go get
RUN CGO_ENABLED=0 go build -ldflags "-w -s"
