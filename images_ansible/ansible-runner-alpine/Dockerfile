ARG VERSION=3
FROM alpine:$VERSION AS builder

# install base packages
RUN apk --no-cache add gcc build-base musl-dev libffi-dev python3-dev \
    python3 py3-pip jq sshpass vim openssh-client curl bash git

## create ansible user
RUN addgroup ansible && \
    adduser -G ansible -D -s /bin/bash ansible
USER ansible
COPY requirements*.txt /home/ansible/
WORKDIR /home/ansible

ARG ANSIBLE_VERSION=latest
RUN python3 -m venv .venv \
    && . .venv/bin/activate \
    && pip3 install --upgrade pip setuptools \
    && pip3 install --requirement requirements-venv.txt \
    && pip3 install --requirement requirements-ansible_${ANSIBLE_VERSION}.txt \
    # reinstall fixes for "ERROR! Unexpected Exception, this is probably a bug: cannot import name 'CollectionRequirement' from 'ansible.galaxy.collection'"
    && pip3 install --force ansible==$(pip3 show ansible |grep ^Version |awk '{print $2}')

## cleanup
RUN mkdir -p $HOME/.ansible/roles && \
    mkdir -p $HOME/.ansible/collections && \
    rm -rf $HOME/.cache

USER root
RUN apk del -r gcc gcc build-base musl-dev libffi-dev python3-dev

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

FROM scratch
COPY --from=builder / /

USER ansible
WORKDIR /home/ansible
ENTRYPOINT ["/entrypoint.sh"]
CMD ["ansible", "--version"]
