# kubernetes-docker-server

This repository contains a Dockerfile for building a minimal (*~ 272.2 MB*) Kubernetes Docker image containing the `server side` components.

This images is based on [Alpine Linux](https://registry.hub.docker.com/_/alpine/).

The executables shipped in this image are:
```
/usr/local/bin # ls -lrth
total 253172
-rwxr-x---    1 root     root       45.7M Jul 17 05:19 kubernetes
-rwxr-x---    1 root     root       33.9M Jul 17 05:19 kubelet
-rwxr-x---    1 root     root       17.0M Jul 17 05:19 kube-scheduler
-rwxr-x---    1 root     root       16.9M Jul 17 05:19 kube-proxy
-rwxr-x---    1 root     root       31.7M Jul 17 05:19 kube-controller-manager
-rwxr-x---    1 root     root       37.9M Jul 17 05:19 kube-apiserver
-rwxr-x---    1 root     root       44.8M Jul 17 05:19 hyperkube
-rwxr-x---    1 root     root       19.4M Jul 17 05:19 kubectl
```
