ARG VERSION=jammy
FROM ubuntu:$VERSION AS builder

# install base packages
RUN <<EOT
    set -e
    apt-get clean
    apt-get update --fix-missing
    apt-get install -y --no-install-recommends \
    python3-minimal python3-venv netcat iproute2 jq sshpass vim curl openssh-client git sudo rsync unzip gpg gpg-agent dirmngr
    rm -rf /var/lib/apt/lists/*
EOT

# create ansible user with sudo permissions
RUN <<EOT
    useradd -U -m -G sudo -s /bin/bash ansible
    echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
EOT
USER ansible
COPY requirements*.txt /home/ansible/
WORKDIR /home/ansible

ARG ANSIBLE_VERSION=latest
RUN <<EOT
    set -e
    python3 -m venv .venv
    . .venv/bin/activate
    pip3 install --upgrade pip setuptools
    pip3 install --requirement requirements-venv.txt
    pip3 install --requirement requirements-ansible_${ANSIBLE_VERSION}.txt
    # reinstall fixes for "ERROR! Unexpected Exception, this is probably a bug: cannot import name 'CollectionRequirement' from 'ansible.galaxy.collection'" \
    pip3 install --force ansible==$(pip3 show ansible |grep ^Version |awk '{print $2}')
EOT

# cleanup
RUN <<EOT
    mkdir -p $HOME/.ansible/roles
    mkdir -p $HOME/.ansible/collections
    rm -rf $HOME/.cache
EOT

USER root
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

FROM scratch
COPY --from=builder / /

USER ansible
WORKDIR /home/ansible
ENTRYPOINT ["/entrypoint.sh"]
CMD ["ansible", "--version"]
