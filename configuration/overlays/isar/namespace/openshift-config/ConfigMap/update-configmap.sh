#!/usr/bin/env bash

    oc create configmap console-custom-logo \
        --from-file=isar-logo-dark.png=isar-logo-dark.png \
        --from-file=isar-logo-light.png=isar-logo-light.png \
        -n openshift-config \
        --dry-run=client \
        -o yaml > console-custom-logo.yaml

    echo '  annotations:' >> console-custom-logo.yaml
    echo '    argocd.argoproj.io/sync-options: "ServerSideApply=true,Validate=false"' >> console-custom-logo.yaml
    echo '    argocd.argoproj.io/compare-options: IgnoreExtraneous' >> console-custom-logo.yaml


