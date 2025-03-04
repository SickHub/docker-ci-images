ARG VERSION=latest
FROM alpine:$VERSION

RUN apk add --update --no-cache ca-certificates git curl jq py3-pip socat \
    && pip3 install --break-system-packages yamllint yamale

# github-releases:argoproj/argo-cd
ARG ARGOCD_VERSION=v2.14.4
RUN curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64 \
    && chmod +x argocd && mv argocd /usr/local/bin

# install helm: https://github.com/helm/helm/releases
ARG HELM_URL=https://get.helm.sh
# github-releases:helm/helm
ARG HELM_VERSION=v3.17.1
ARG HELM_ARCH=amd64

RUN if [ -z "$HELM_ARCH" ]; then HELM_ARCH=amd64; fi; \
    TAR_FILE="helm-${HELM_VERSION}-linux-${HELM_ARCH}.tar.gz"; \
    curl -sSL ${HELM_URL}/${TAR_FILE} | tar xz \
    && mv linux-${HELM_ARCH}/helm /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && rm -rf linux-${HELM_ARCH}

ARG CT_URL=https://github.com/helm/chart-testing/releases
# github-releases:helm/chart-testing
ARG CT_VERSION=v3.12.0
ARG TARGETARCH
ARG CT_ARCH=${TARGETARCH}

RUN if [ -z "$CT_ARCH" ]; then CT_ARCH=amd64; fi; \
    mkdir ct; cd ct; \
    export version=$(echo "${CT_VERSION}" | tr -d v); \
    curl -sSLo ct-${CT_VERSION}.tgz "${CT_URL}/download/${CT_VERSION}/chart-testing_${version}_linux_${CT_ARCH}.tar.gz" \
    && tar -xzf ct-${CT_VERSION}.tgz \
    && chmod +x ct \
    && mv -v ct /usr/local/bin/ct \
    && mkdir -p /etc/ct && mv -v etc/* /etc/ct/ \
    && cd .. && rm -rf ct

ARG KUBECTL_VERSION=stable
RUN if [ "stable" = $KUBECTL_VERSION ]; then \
      export KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt); \
    fi \
    && curl -sLO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x kubectl && mv kubectl /usr/local/bin

# github-releases:kubernetes-sigs/kustomize
ARG KUSTOMIZE_VERSION=kustomize/v5.6.0
RUN export VERSION=${KUSTOMIZE_VERSION//*\//}; curl -sL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${VERSION}/kustomize_${VERSION}_linux_amd64.tar.gz -o kustomize_linux_amd64.tar.gz \
    && tar xvzf kustomize_linux_amd64.tar.gz kustomize && rm kustomize_linux_amd64.tar.gz \
    && chmod +x kustomize && mv kustomize /usr/local/bin

ARG KUBEVAL_VERSION=latest
RUN if [ "latest" = $KUBEVAL_VERSION ]; then \
      URL="https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz"; \
    else \
      URL="https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz"; \
    fi \
    && curl -sLO $URL \
    && tar xzf kubeval-linux-amd64.tar.gz kubeval && rm kubeval-linux-amd64.tar.gz \
    && chmod +x kubeval && mv kubeval /usr/local/bin

# github-releases:bitnami-labs/sealed-secrets
ARG KUBESEAL_VERSION=v0.28.0
RUN export version=$(echo "${KUBESEAL_VERSION}" | tr -d v); \
    curl -sL https://github.com/bitnami-labs/sealed-secrets/releases/download/${KUBESEAL_VERSION}/kubeseal-${version}-linux-amd64.tar.gz -o kubeseal.tgz \
    && tar xzf kubeseal.tgz kubeseal && rm kubeseal.tgz \
    && chmod +x kubeseal && mv kubeseal /usr/local/bin
