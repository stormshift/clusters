#!/usr/bin/env bash

ARCH=$(uname -i)


case $ARCH in

  aarch64)
    GO_ARCH=arm64
    ;;

  x86_64)
    GO_ARCH=amd64
    ;;
  *)
    exit 99
    ;;
esac

echo "Download kustomize_v5.5.0_linux_${GO_ARCH}.tar.gz"
curl -# -L -O https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.5.0/kustomize_v5.5.0_linux_${GO_ARCH}.tar.gz
tar xzf kustomize_v5.5.0_linux_${GO_ARCH}.tar.gz
mv -v kustomize /usr/local/bin/
rm -v kustomize_v5.5.0_linux_${GO_ARCH}.tar.gz
