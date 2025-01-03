FROM registry.redhat.io/ubi9/ubi-minimal:latest

ADD helper/install-kustomize.sh /usr/local/bin/

RUN microdnf install -y diffutils tar gzip \
 && install-kustomize.sh


