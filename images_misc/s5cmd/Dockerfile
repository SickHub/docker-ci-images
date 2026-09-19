ARG VERSION=latest
FROM alpine:$VERSION
LABEL org.opencontainers.image.authors="drpsychick@drsick.net"
LABEL org.opencontainers.image.description="s5cmd on Alpine Linux - fast parallel S3 client to up- and download files from any S3 compatible service"
LABEL org.opencontainers.image.source="https://github.com/SickHub/docker-ci-images"

RUN apk add --update --no-cache ca-certificates git curl jq

# install s5cmd: https://github.com/peak/s5cmd/releases
# github-releases:peak/s5cmd
ARG S5CMD_VERSION=v2.3.0
ARG TARGETARCH
ARG S5CMD_ARCH=${TARGETARCH}
# map docker TARGETARCH to s5cmd release asset name (amd64 -> Linux-64bit, arm64 -> Linux-arm64)
RUN case "${S5CMD_ARCH}" in \
      amd64) asset_arch="Linux-64bit" ;; \
      arm64) asset_arch="Linux-arm64" ;; \
      *) asset_arch="Linux-${S5CMD_ARCH}" ;; \
    esac \
    && curl -fsSLo /tmp/s5cmd.tar.gz https://github.com/peak/s5cmd/releases/download/${S5CMD_VERSION}/s5cmd_${S5CMD_VERSION#v}_${asset_arch}.tar.gz \
    && tar -xzf /tmp/s5cmd.tar.gz -C /usr/bin/ s5cmd \
    && chmod +x /usr/bin/s5cmd \
    && rm /tmp/s5cmd.tar.gz

# cleanup
RUN rm -f /var/cache/apk/*

RUN s5cmd version
