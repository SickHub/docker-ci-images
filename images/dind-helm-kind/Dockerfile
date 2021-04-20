ARG VERSION=latest
FROM drpsychick/dind-helm:$VERSION

RUN apk add --update --no-cache py3-pip socat \
    && pip3 install yamllint yamale

ARG CT_URL=https://github.com/helm/chart-testing/releases
ARG CT_VERSION=3.3.1
ARG TARGETARCH
ARG CT_ARCH=${TARGETARCH}

RUN if [ -z "$CT_ARCH" ]; then CT_ARCH=amd64; fi; \
    mkdir ct; cd ct; \
    curl -sSLo ct-${CT_VERSION}.tgz "${CT_URL}/download/v${CT_VERSION}/chart-testing_${CT_VERSION}_linux_${CT_ARCH}.tar.gz" \
    && tar -xzf ct-${CT_VERSION}.tgz \
    && chmod +x ct \
    && mv -v ct /usr/local/bin/ct \
    && mkdir -p /etc/ct && mv -v etc/* /etc/ct/ \
    && cd .. && rm -rf ct

ARG KIND_URL=https://github.com/kubernetes-sigs/kind/releases
ARG KIND_VERSION=0.10.0
ARG KIND_ARCH=${TARGETARCH}

RUN if [ -z "$KIND_ARCH" ]; then KIND_ARCH=amd64; fi; \
    curl -sSLo kind-${KIND_VERSION} "${KIND_URL}/download/v${KIND_VERSION}/kind-linux-${KIND_ARCH}" \
    && chmod +x kind-${KIND_VERSION} \
    && mv kind-${KIND_VERSION} /usr/local/bin/kind

# cleanup
RUN rm -f /var/cache/apk/*

RUN kubectl version --client=true \
    && helm version \
    && ct version \
    && kind version

# create a one-node kind cluster with
# `kind create cluster`