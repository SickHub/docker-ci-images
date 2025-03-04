ARG VERSION=dind
FROM docker:$VERSION

RUN apk add --update --no-cache ca-certificates git curl jq

# install buildx
ARG BUILDX_URL=https://github.com/docker/buildx/releases
# github-releases:docker/buildx
ARG BUILDX_VERSION=v0.21.2
# TARGETARCH requires 'DOCKER_BUILDKIT=1'
ARG TARGETARCH
ARG BUILDX_ARCH=${TARGETARCH}

RUN if [ -z "$BUILDX_ARCH" ]; then BUILDX_ARCH=amd64; fi; \
    mkdir -p ~/.docker/cli-plugins; \
    fileName="buildx-${BUILDX_VERSION}.linux-${BUILDX_ARCH}"; \
    url="${BUILDX_URL}/download/${BUILDX_VERSION}/${fileName}"; \
    curl -sSL -o ~/.docker/cli-plugins/docker-buildx $url \
    && chmod a+x ~/.docker/cli-plugins/docker-buildx; \
    export DOCKER_CLI_EXPERIMENTAL="enabled"; \
    docker buildx install

# cleanup
RUN rm -f /var/cache/apk/*

# start daemon with `dind dockerd &`
ENV DOCKER_CLI_EXPERIMENTAL="enabled" \
    DOCKER_HOST=unix:///var/run/docker.sock

RUN docker buildx version
