# Bootstrap coe-cluster

## Install following Operators

 * [External Secrets Operator](https://docs.redhat.com/en/documentation/openshift_container_platform/4.21/html/security_and_compliance/external-secrets-operator-for-red-hat-openshift)
 * OpenShift GitOps

## Configure gitops

Note: Auto-sync disabled by default! 

```bash
export CLUSTER_NAME=stormshift-ocpX

oc apply -k apps/gitops-privileges/

oc apply -f - <<EOF
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cluster-configuration
  namespace: openshift-gitops
spec:
  destination:
    server: https://kubernetes.default.svc
  project: default
  source:
    path: configuration/overlays/${CLUSTER_NAME}
    repoURL: https://github.com/stormshift/clusters.git
    targetRevision: HEAD
EOF

```

### Optional, add idp-coe-sso-admin to argo role:admin

```
oc edit argocds.argoproj.io  -n openshift-gitops   openshift-gitops
```

and add `g, global-cluster-admins, role:admin` to rbac.policy
and add `g, local-cluster-admins, role:admin` to rbac.policy


## Configure External Secrets Operator

```shell
oc apply -f - <<EOF
apiVersion: operator.openshift.io/v1alpha1
kind: ExternalSecretsConfig
metadata:
  labels:
    app: external-secrets-operator
    app.kubernetes.io/name: cluster
  name: cluster
spec:
  controllerConfig:
    networkPolicies:
    - componentName: ExternalSecretsCoreController
      egress:
      - {}
      name: allow-external-secrets-egress
EOF
```

```bash
export CLUSTER_NAME=stormshift-ocpX
# Stored in Red Hat Bitwarden, Coe Lab Mgmt collection
export VAULT=....
export APP_ROLE=....
export APP_PW=....

oc create secret generic redhat-vault \
    -n external-secrets-operator \
    --from-literal=token=$APP_PW

oc apply -f - <<EOF
apiVersion: external-secrets.io/v1
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
            namespace: external-secrets-operator
      caProvider:
        key: ca.crt
        name: redhat-current-it-root-cas
        namespace: openshift-config
        type: ConfigMap
      path: apps
      server: ${VAULT}
      version: v2
EOF

```

#### Check ClusterSecretStore

```bash
$ oc get clustersecretstore.external-secrets.io/redhat-vault
NAME           AGE   STATUS   CAPABILITIES   READY
redhat-vault   16s   Valid    ReadWrite      True
```
