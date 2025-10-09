FROM alpine:3.22.1

RUN apk update \
  && rm -rf /var/cache/apk/*
