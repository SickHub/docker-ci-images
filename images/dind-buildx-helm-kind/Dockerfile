ARG VERSION=latest
FROM drpsychick/dind-buildx-helm:$VERSION

RUN apk add --update --no-cache py3-pip socat \
    && export VERSION="$(grep VERSION_ID /etc/os-release | cut -d= -f2)" PIP3_EXTRA="" \
    && if [ $(echo $VERSION | cut -d. -f1) -eq 3 -a $(echo $VERSION | cut -d. -f2) -ge 19 ]; then export PIP3_EXTRA="--break-system-packages"; fi \
    && pip3 install $PIP3_EXTRA yamllint yamale

ARG CT_URL=https://github.com/helm/chart-testing/releases
# github-releases:helm/chart-testing
ARG CT_VERSION=v3.11.0
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

ARG KIND_URL=https://github.com/kubernetes-sigs/kind/releases
# github-releases:kubernetes-sigs/kind
ARG KIND_VERSION=v0.22.0
ARG KIND_ARCH=${TARGETARCH}
RUN if [ -z "$KIND_ARCH" ]; then KIND_ARCH=amd64; fi; \
    curl -sSLo kind-${KIND_VERSION} "${KIND_URL}/download/${KIND_VERSION}/kind-linux-${KIND_ARCH}" \
    && chmod +x kind-${KIND_VERSION} \
    && mv kind-${KIND_VERSION} /usr/local/bin/kind

# cleanup
RUN rm -f /var/cache/apk/*

RUN docker buildx version \
    && kubectl version --client=true \
    && helm version \
    && ct version \
    && kind version

# create a one-node kind cluster with
# `kind create cluster`