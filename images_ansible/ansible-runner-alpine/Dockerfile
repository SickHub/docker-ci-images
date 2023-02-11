ARG VERSION=3
FROM alpine:$VERSION

# install base packages
RUN apk --no-cache add gcc build-base musl-dev libffi-dev python3-dev \
    python3 py3-pip jq sshpass vim openssh-client curl bash

## create ansible user
RUN addgroup ansible && \
    adduser -G ansible -D -s /bin/bash ansible
USER ansible
WORKDIR /home/ansible
COPY requirements*.txt /home/ansible/

ARG ANSIBLE_VERSION=latest
RUN python3 -m venv .venv \
    && . .venv/bin/activate \
    && pip3 install --upgrade pip setuptools \
    && pip3 install --requirement requirements-venv.txt \
    && pip3 install --requirement requirements-ansible_${ANSIBLE_VERSION}.txt \
    # reinstall fixes for "ERROR! Unexpected Exception, this is probably a bug: cannot import name 'CollectionRequirement' from 'ansible.galaxy.collection'"
    && pip3 install --force ansible==$(pip3 show ansible |grep ^Version |awk '{print $2}')


## cleanup
USER root
RUN apk del -r gcc gcc build-base musl-dev libffi-dev python3-dev && \
    rm -rf .cache

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

USER ansible
CMD ["ansible", "--version"]
