# Bootstrap coe-cluster


## Install following Operators

 * External Secrets Operator
 * OpenShift GitOps

## Apply reousrces

```
oc apply -k .
```

## Configure External Secrets Operator

```
export VAULT=....
export APP_ROLE=....
export APP_PW=....

oc create secret generic redhat-vault \
    -n infra-external-secrets-operator \
    --from-literal=token=$APP_PW

oc apply -f - <<EOF
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: redhat-vault
spec:
  provider:
    vault:
      auth:
        appRole:
          path: approle
          roleId: ${APP_ROLE}
          secretRef:
            key: token
            name: redhat-vault
            namespace: infra-external-secrets-operator
      caProvider:
        key: ca-bundle.crt
        name: trusted-ca-bundle
        namespace: infra-external-secrets-operator
        type: ConfigMap
      path: apps
      server: ${VAULT}
      version: v2
EOF

```


#### Check ClusterSecretStore

ToDO: Approle should not have ReadWrite access. Ticket is created.

```
oc get clustersecretstore.external-secrets.io/redhat-vault
NAME           AGE   STATUS   CAPABILITIES   READY
redhat-vault   16s   Valid    ReadWrite      True
```
