ARG VERSION=jammy
FROM ubuntu:$VERSION

# install base packages
RUN apt-get clean && \
    apt-get update --fix-missing || true && \
    apt-get install -y --no-install-recommends python3-minimal python3-venv netcat iproute2 jq sshpass vim \
    curl openssh-client && rm -rf /var/lib/apt/lists/*

# create ansible user
RUN useradd -U -m -s /bin/bash ansible
USER ansible
WORKDIR /home/ansible
COPY requirements*.txt /home/ansible/

ARG ANSIBLE_VERSION="latest"
# latest 2.14
RUN python3 -m venv .venv \
    && . .venv/bin/activate \
    && pip3 install --upgrade pip setuptools \
    && pip3 install --requirement requirements-venv.txt \
    && pip3 install --requirement requirements-ansible_${ANSIBLE_VERSION}.txt \
    # reinstall fixes for "ERROR! Unexpected Exception, this is probably a bug: cannot import name 'CollectionRequirement' from 'ansible.galaxy.collection'" \
    && pip3 install --force ansible==$(pip3 show ansible |grep ^Version |awk '{print $2}')

# cleanup
RUN mkdir -p $HOME/.ansible/roles && \
    mkdir -p $HOME/.ansible/collections && \
    rm -rf $HOME/.cache

USER root
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

USER ansible
CMD ["latest", "ansible", "--version"]
