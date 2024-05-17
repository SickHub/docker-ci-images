# Using the `ansible-runner` image

Ansible roadmap, see https://docs.ansible.com/ansible/latest/roadmap/ansible_roadmap_index.html#

## Run ansible commands with different Ansible versions
```shell
docker run -it --rm drpsychick/ansible-runner:latest ansible --version
docker run -it --rm drpsychick/ansible-runner:12 ansible --version
docker run -it --rm drpsychick/ansible-runner:13 ansible --version
docker run -it --rm drpsychick/ansible-runner:14 ansible --version
docker run -it --rm drpsychick/ansible-runner:15 ansible --version
docker run -it --rm drpsychick/ansible-runner:16 ansible --version

# using ansible-galaxy (most collections preinstalled)
docker run -it --rm drpsychick/ansible-runner:latest ansible-galaxy collection list
```