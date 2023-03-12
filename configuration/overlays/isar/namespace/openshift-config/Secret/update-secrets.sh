#!/usr/bin/env bash

for i in login-template providers-template errors-template ; do
    echo "Update $i ${i/-template}"

    oc create secret generic $i \
        --from-file=${i/-template}.html=$i.html \
        -n openshift-config \
        --dry-run=client \
        -o yaml > $i.yaml

    echo '  annotations:' >> ${i}.yaml
    echo '    argocd.argoproj.io/sync-options: "ServerSideApply=true,Validate=false"' >> ${i}.yaml
    echo '    argocd.argoproj.io/compare-options: IgnoreExtraneous' >> ${i}.yaml
done;


