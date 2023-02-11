[![CircleCI](https://img.shields.io/circleci/build/github/SickHub/docker-ci-images)](https://app.circleci.com/pipelines/github/SickHub/docker-ci-images)
[![license](https://img.shields.io/github/license/drpsychick/docker-ci-images.svg)](https://github.com/drpsychick/docker-ci-images/blob/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/drpsychick/docker-ci-images.svg)](https://github.com/drpsychick/docker-ci-images)
[![Contributors](https://img.shields.io/github/contributors/drpsychick/docker-ci-images.svg)](https://github.com/drpsychick/docker-ci-images/graphs/contributors)
[![Paypal](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FTXDN7LCDWUEA&source=url)
[![GitHub Sponsor](https://img.shields.io/badge/github-sponsor-blue?logo=github)](https://github.com/sponsors/DrPsychick)

[![GitHub issues](https://img.shields.io/github/issues/drpsychick/docker-ci-images.svg)](https://github.com/drpsychick/docker-ci-images/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/drpsychick/docker-ci-images.svg)](https://github.com/drpsychick/docker-ci-images/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/drpsychick/docker-ci-images.svg)](https://github.com/drpsychick/docker-ci-images/pulls)
[![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/drpsychick/docker-ci-images.svg)](https://github.com/drpsychick/docker-ci-images/pulls?q=is%3Apr+is%3Aclosed)

# Docker CI Images
A collection of images that can be used in CI pipelines based on docker.

* CircleCI
* GitLab-CI
* ...

## Purpose
Instead of installing the dependencies on every run and possibly using 
different images for every stage (which is ok, don't get me wrong), 
you can use the image that has all the tools you need for your pipeline.

Included tools:
* `git`, `curl`, `jq`

# Images with `buildx`

## [drpsychick/dind-buildx](./images/dind-buildx)
[![Docker image](https://img.shields.io/docker/image-size/drpsychick/dind-buildx?sort=date)](https://hub.docker.com/r/drpsychick/dind-buildx/tags)
[![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/dind-buildx.svg)](https://hub.docker.com/r/drpsychick/dind-buildx/)
[![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/dind-buildx.svg)](https://hub.docker.com/r/drpsychick/dind-buildx/)
![architectures](https://img.shields.io/badge/arch-amd64,arm64-green)

Build multi-arch docker images
* based on `docker:dind`
* includes `buildx` so you can build for multiple architectures

### Usage
* Start docker engine with `dind dockerd &` (if not using remote docker engine)
* bootstrap your `buildx` with
```shell
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker context create xbuilder
docker buildx create xbuilder --name xbuilder --use
docker buildx inspect --bootstrap
```
* use `docker` and `docker buildx` as usual

### Examples
* Circle CI: https://github.com/DrPsychick/docker-influxdb/blob/master/.circleci/config.yml
  
## [drpsychick/dind-buildx-helm](./images/dind-buildx-helm)
[![Docker image](https://img.shields.io/docker/image-size/drpsychick/dind-buildx-helm?sort=date)](https://hub.docker.com/r/drpsychick/dind-buildx-helm/tags)
[![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/dind-buildx-helm.svg)](https://hub.docker.com/r/drpsychick/dind-buildx-helm/)
[![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/dind-buildx-helm.svg)](https://hub.docker.com/r/drpsychick/dind-buildx-helm-helm/)
![architectures](https://img.shields.io/badge/arch-amd64,arm64-green)

Build images and deploy with helm
* based on `drpsychick/dind-buildx`
* includes `kubectl` and `helm` so you can build your image and deploy with kubectl and/or helm

### Usage
Same as above plus:
* provide kubernetes config and point to it with `$KUBECONFIG`
* use `kubectl` and `helm` to deploy to your kubernetes cluster

## [drpsychick/dind-buildx-helm-kind](./images/dind-buildx-helm-kind)
[![Docker image](https://img.shields.io/docker/image-size/drpsychick/dind-buildx-helm-kind?sort=date)](https://hub.docker.com/r/drpsychick/dind-buildx-helm-kind/tags)
[![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/dind-buildx-helm-kind.svg)](https://hub.docker.com/r/drpsychick/dind-buildx-helm-kind/)
[![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/dind-buildx-helm-kind.svg)](https://hub.docker.com/r/drpsychick/dind-buildx-helm-kind/)
![architectures](https://img.shields.io/badge/arch-amd64,arm64-green)

Build images, test helm charts and deploy to kind
* based on `drpsychick/dind-buildx-helm`
* includes `ct` and `kind` so you can test your helm chart and deploy it to a kind node

### Usage
Same as above plus:
* start a kind cluster with `kind create cluster`
* optionally forward localhost to docker engine host, if using remote docker engine
* test install your charts using `ct`

### Examples
* Circle CI: https://github.com/DrPsychick/ark-server-charts/blob/master/.circleci/config.yml

# Images without `buildx`

## [drpsychick/dind-helm](./images/dind-helm)
[![Docker image](https://img.shields.io/docker/image-size/drpsychick/dind-helm?sort=date)](https://hub.docker.com/r/drpsychick/dind-helm/tags)
[![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/dind-helm.svg)](https://hub.docker.com/r/drpsychick/dind-helm/)
[![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/dind-helm.svg)](https://hub.docker.com/r/drpsychick/dind-helm/)
![architectures](https://img.shields.io/badge/arch-amd64,arm64-green)

Build images and deploy with helm (without `buildx`)
* based on `docker:dind`
* includes `kubectl` and `helm` so you can build your image and deploy with kubectl and/or helm

### Usage
Same as above plus:
* provide kubernetes config and point to it with `$KUBECONFIG`
* use `kubectl` and `helm` to deploy to your kubernetes cluster

## [drpsychick/dind-helm-kind](./images/dind-helm-kind)
[![Docker image](https://img.shields.io/docker/image-size/drpsychick/dind-helm-kind?sort=date)](https://hub.docker.com/r/drpsychick/dind-helm-kind/tags)
[![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/dind-helm-kind.svg)](https://hub.docker.com/r/drpsychick/dind-helm-kind/)
[![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/dind-helm-kind.svg)](https://hub.docker.com/r/drpsychick/dind-helm-kind/)
![architectures](https://img.shields.io/badge/arch-amd64,arm64-green)

Build images, test helm charts and deploy to kind (without `buildx`)
* based on `drpsychick/dind-helm`
* includes `ct` and `kind` so you can test your helm chart and deploy it to a kind node

### Usage
Same as above plus:
* start a kind cluster with `kind create cluster`
* optionally forward localhost to docker engine host, if using remote docker engine
* test install your charts using `ct`

# Images for Kubernetes pipelines

## [drpsychick/argocd-kubectl](./images_x86/argocd-kubectl)
[![Docker image](https://img.shields.io/docker/image-size/drpsychick/argocd-kubectl?sort=date)](https://hub.docker.com/r/drpsychick/argocd-kubectl/tags)
[![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/argocd-kubectl.svg)](https://hub.docker.com/r/drpsychick/argocd-kubectl/)
[![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/argocd-kubectl.svg)](https://hub.docker.com/r/drpsychick/argocd-kubectl/)
![architectures](https://img.shields.io/badge/arch-amd64-green)

Add apps to ArgoCD running on your Kubernetes cluster
* based on `bitnami/argo-cd`
* includes `kubectl`, `kubeval` and `kubeseal` so you can validate your manifests and encrypt your secrets for git
* includes `helm`, `kustomize`, `ct` so you can generate manifests and test your helm chart

### Usage
* use it as pipeline image to control ArgoCD: install/sync apps, change RBAC, add repos, ...
* template charts with `helm` and lint your charts using `ct`
* `kustomize` for environments and validate your manifests with `kubeval`


# Images for Ansible pipelines

## [drpsychick/ansible-runner](./images_ansible/ansible-runner)
[![Docker image](https://img.shields.io/docker/image-size/drpsychick/ansible-runner?sort=date)](https://hub.docker.com/r/drpsychick/ansible-runner/tags)
[![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/ansible-runner.svg)](https://hub.docker.com/r/drpsychick/ansible-runner/)
[![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/ansible-runner.svg)](https://hub.docker.com/r/drpsychick/ansible-runner/)
![architectures](https://img.shields.io/badge/arch-amd64-green)

Run Ansible playbooks
* based on `ubuntu` or `alpine`
* includes `ansible`, `ansible-galaxy`, `ansible-lint`

### Usage
* use it as pipeline image to run Ansible playbooks and lint or test Ansible roles or playbooks.
