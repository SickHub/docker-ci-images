ARG VERSION=latest
FROM alpine:$VERSION

RUN apk add --update --no-cache ca-certificates git curl jq

# argocd
ARG ARGOCD_VERSION=2.1.7
RUN curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/download/v$ARGOCD_VERSION/argocd-linux-amd64 \
    && chmod +x argocd && mv argocd /usr/local/bin

# install helm: https://github.com/helm/helm/releases
ARG HELM_URL=https://get.helm.sh
ARG HELM_VERSION=3.5.4
ARG HELM_ARCH=amd64

RUN if [ -z "$HELM_ARCH" ]; then HELM_ARCH=amd64; fi; \
    TAR_FILE="helm-v${HELM_VERSION}-linux-${HELM_ARCH}.tar.gz"; \
    curl -sSL ${HELM_URL}/${TAR_FILE} | tar xz \
    && mv linux-${HELM_ARCH}/helm /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && rm -rf linux-${HELM_ARCH}

ARG KUBECTL_VERSION=stable
RUN if [ "stable" = $KUBECTL_VERSION ]; then \
      export KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt | tr -d v); \
    fi \
    && curl -sLO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x kubectl && mv kubectl /usr/local/bin

ARG KUSTOMIZE_VERSION=4.4.1
RUN curl -sL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -o kustomize_linux_amd64.tar.gz \
    && tar xvzf kustomize_linux_amd64.tar.gz kustomize && rm kustomize_linux_amd64.tar.gz \
    && chmod +x kustomize && mv kustomize /usr/local/bin

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
