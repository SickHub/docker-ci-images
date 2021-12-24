# TODO: consider plain alpine/kubectl base and install only argo-cd cli (smaller image)
ARG VERSION=latest
FROM bitnami/argo-cd:$VERSION

USER root
RUN apt update && apt install -y ca-certificates jq

ARG KUBECTL_VERSION=stable
RUN if [ "stable" = $KUBECTL_VERSION ]; then \
      export KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt | tr -d v); \
    fi \
    && curl -sLO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x kubectl && mv kubectl /usr/local/bin

ARG KUBEVAL_VERSION=latest
RUN if [ "latest" = $KUBEVAL_VERSION ]; then \
      URL="https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz"; \
    else \
      URL="https://github.com/instrumenta/kubeval/releases/download/v${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz"; \
    fi \
    && curl -sLO $URL \
    && tar xzf kubeval-linux-amd64.tar.gz kubeval && rm kubeval-linux-amd64.tar.gz \
    && chmod +x kubeval && mv kubeval /usr/local/bin

ARG KUBESEAL_VERSION=0.17.1
RUN curl -sL https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-amd64.tar.gz -o kubeseal.tgz \
    && tar xzf kubeseal.tgz kubeseal && rm kubeseal.tgz \
    && chmod +x kubeseal && mv kubeseal /usr/local/bin

USER 1001
