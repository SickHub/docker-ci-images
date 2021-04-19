ARG VERSION=dind
FROM docker:$VERSION

RUN apk add --update --no-cache ca-certificates git curl jq

# install buildx
# TARGETARCH requires 'DOCKER_BUILDKIT=1'
ARG TARGETARCH
ARG BUILDX_URL=https://github.com/docker/buildx/releases
ARG BUILDX_VERSION=0.5.1
ARG BUILDX_ARCH=${TARGETARCH}
RUN mkdir -p ~/.docker/cli-plugins; \
    fileName="buildx-v${BUILDX_VERSION}.linux-${BUILDX_ARCH}"; \
    url="${BUILDX_URL}/download/v${BUILDX_VERSION}/${fileName}"; \
    curl -sSL -o ~/.docker/cli-plugins/docker-buildx $url \
    && chmod a+x ~/.docker/cli-plugins/docker-buildx \
    && docker buildx install

# cleanup
RUN rm -f /var/cache/apk/*

# start daemon with `dind dockerd &`
ENV DOCKER_CLI_EXPERIMENTAL="enabled"

RUN docker buildx version
