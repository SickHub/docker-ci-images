ARG VERSION=latest
FROM alpine:$VERSION

RUN apk add --update --no-cache ca-certificates git curl jq

# install minio-client: https://github.com/minio/mc/releases
ARG MINIOMC_URL=https://dl.min.io/client/mc/release
ARG TARGETARCH
ARG MINIOMC_ARCH=${TARGETARCH}
RUN curl -o /usr/bin/mc $MINIOMC_URL/linux-$MINIOMC_ARCH/mc && chmod +x /usr/bin/mc

# cleanup
RUN rm -f /var/cache/apk/*

RUN mc --version
