ARG VERSION=dind
FROM docker:$VERSION

RUN apk --no-cache add curl git py3-pip socat \
    && pip3 install --upgrade pip \
    && pip3 install yamllint yamale

# install kubectl: https://github.com/kubernetes/kubectl/releases
ARG KUBECTL_URL=https://dl.k8s.io/release
ARG KUBECTL_VERSION=1.21.0
ARG TARGETARCH
ARG KUBECTL_ARCH=${TARGETARCH}

RUN URL="${KUBECTL_URL}/v${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl"; \
    CHECKSUM_URL="${KUBECTL_URL}/v${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl.sha256"; \
    curl -sSL -o kubectl-sha256 "${CHECKSUM_URL}" \
    && curl -sSL -o kubectl-${KUBECTL_VERSION} "${URL}" \
    && test "$(cat kubectl-sha256 | awk '{print $1}')" = "$(cat kubectl-${KUBECTL_VERSION} | sha256sum | awk '{print $1}')" \
    && chmod +x kubectl-${KUBECTL_VERSION} \
    && mv kubectl-${KUBECTL_VERSION} /usr/local/bin/kubectl \
    && rm -f kubectl-sha256

# install helm: https://github.com/helm/helm/releases
ARG HELM_URL=https://get.helm.sh
ARG HELM_VERSION=3.5.4
ARG HELM_ARCH=${TARGETARCH}

RUN TAR_FILE="helm-v${HELM_VERSION}-linux-${HELM_ARCH}.tar.gz"; \
    curl -sSL ${HELM_URL}/${TAR_FILE} | tar xz \
    && mv linux-${HELM_ARCH}/helm /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && rm -rf linux-${HELM_ARCH}

ARG CT_URL=https://github.com/helm/chart-testing/releases
ARG CT_VERSION=3.3.1
ARG TARGETARCH
ARG CT_ARCH=${TARGETARCH}
RUN mkdir ct; cd ct; \
    curl -sSLo ct-${CT_VERSION}.tgz "${CT_URL}/download/v${CT_VERSION}/chart-testing_${CT_VERSION}_linux_${CT_ARCH}.tar.gz" \
    && tar -xzf ct-${CT_VERSION}.tgz \
    && chmod +x ct \
    && mv -v ct /usr/local/bin/ct \
    && mkdir -p /etc/ct && mv -v etc/* /etc/ct/ \
    && cd .. && rm -rf ct

ARG KIND_URL=https://github.com/kubernetes-sigs/kind/releases
ARG KIND_VERSION=0.10.0
ARG KIND_ARCH=${TARGETARCH}
RUN curl -sSLo kind-${KIND_VERSION} "${KIND_URL}/download/v${KIND_VERSION}/kind-linux-${KIND_ARCH}" \
    && chmod +x kind-${KIND_VERSION} \
    && mv kind-${KIND_VERSION} /usr/local/bin/kind

RUN kubectl version --client=true \
    && helm version \
    && ct version \
    && kind version

# create a one-node kind cluster with
# `kind create cluster`