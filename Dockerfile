ARG go_version # allows to customize go version

FROM golang:${go_version:-1.13.7}-alpine3.11 AS builder
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

ARG strip      # strip compiled binaries if not empty

RUN [ -n "$strip" ] &&  ( apk --no-cache add binutils && \
  strip /go/bin/* && du -hs /go/bin/* ) || :

ARG upx        # use upx (value is upx params) NOT RECOMMENDED

RUN [ -n "$upx" ] &&  ( apk --no-cache add upx && \
  upx $upx /go/bin/* && du -hs /go/bin/* ) || :

FROM alpine:latest
COPY --from=builder /go/bin/* /usr/local/bin/

ARG packages   # additional alpine packages to install

RUN [ -n "$packages" ] && (apk --no-cache add $packages) || :
USER 1000:1000
WORKDIR /app
CMD ["caddy"]
