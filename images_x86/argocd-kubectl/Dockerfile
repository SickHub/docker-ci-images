# TODO: consider plain alpine/kubectl base and install only argo-cd cli (smaller image)
ARG VERSION=latest
FROM bitnami/argo-cd:$VERSION

USER root
RUN apt update && apt install -y ca-certificates jq

ARG KUBECTL_VERSION=stable
RUN if [ "stable" = $KUBECTL_VERSION ]; then \
      export KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt | tr -d v); \
    fi \
    && curl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x kubectl && mv kubectl /usr/local/bin

USER 1001
