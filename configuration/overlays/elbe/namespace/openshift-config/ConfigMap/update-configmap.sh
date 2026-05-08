#!/usr/bin/env bash

    oc create configmap console-custom-logo \
        --from-file=logo-dark.png=logo-dark.png \
        --from-file=logo-light.png=logo-light.png \
        -n openshift-config \
        --dry-run=client \
        -o yaml > console-custom-logo.yaml

    echo '  annotations:' >> console-custom-logo.yaml
    echo '    argocd.argoproj.io/sync-options: "ServerSideApply=true,Validate=false"' >> console-custom-logo.yaml
    echo '    argocd.argoproj.io/compare-options: IgnoreExtraneous' >> console-custom-logo.yaml


