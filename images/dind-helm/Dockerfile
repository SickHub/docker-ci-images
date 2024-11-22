ARG VERSION=dind
FROM docker:$VERSION

RUN apk add --update --no-cache ca-certificates git curl jq

# install kubectl: https://github.com/kubernetes/kubectl/releases
ARG KUBECTL_URL=https://dl.k8s.io/release
# github-releases:kubernetes/kubernetes
ARG KUBECTL_VERSION=v1.31.3
ARG TARGETARCH
ARG KUBECTL_ARCH=${TARGETARCH}

RUN if [ -z "$KUBECTL_ARCH" ]; then KUBECTL_ARCH=amd64; fi; \
    URL="${KUBECTL_URL}/${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl"; \
    CHECKSUM_URL="${KUBECTL_URL}/${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl.sha256"; \
    curl -sSL -o kubectl-sha256 "${CHECKSUM_URL}" \
    && curl -sSL -o kubectl-${KUBECTL_VERSION} "${URL}" \
    && test "$(cat kubectl-sha256 | awk '{print $1}')" = "$(cat kubectl-${KUBECTL_VERSION} | sha256sum | awk '{print $1}')" \
    && chmod +x kubectl-${KUBECTL_VERSION} \
    && mv kubectl-${KUBECTL_VERSION} /usr/local/bin/kubectl \
    && rm -f kubectl-sha256

# install helm: https://github.com/helm/helm/releases
ARG HELM_URL=https://get.helm.sh
# github-releases:helm/helm
ARG HELM_VERSION=v3.16.3
ARG HELM_ARCH=${TARGETARCH}

RUN if [ -z "$HELM_ARCH" ]; then HELM_ARCH=amd64; fi; \
    TAR_FILE="helm-${HELM_VERSION}-linux-${HELM_ARCH}.tar.gz"; \
    curl -sSL ${HELM_URL}/${TAR_FILE} | tar xz \
    && mv linux-${HELM_ARCH}/helm /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && rm -rf linux-${HELM_ARCH}

# cleanup
RUN rm -f /var/cache/apk/*

RUN kubectl version --client=true \
    && helm version
