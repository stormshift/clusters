# Clusters repository

contains the cluster configuration from our StormShift OCP clusters.
Rollout via OpenShift GitOps / ArgoCD and Red Hat Advances Cluster Manager.

# Directories:
```
.
├── argocd                              # Contains ArgoCD configurations
└── configuration                       # Kustomize cluster configuration rollout via ArgoCD
    ├── base
    ├── components
    │   ├── alertreceiver
    │   └── sealed-secrets-operator
    └── overlays
        ├── common                        # common included from all clusters
        ├── ocp1                          # ocp1 cluster configuration
        ├── ocp2                          # ocp2 cluster configuration
        ├── ocp3                          # ocp3 cluster configuration
        ├── ocp4                          # ocp4 cluster configuration
        ├── ocp5                          # ocp5 cluster configuration
        ├── ocp6                          # ocp6 cluster configuration
        ├── ocp7                          # ocp7 cluster configuration
        ├── ocp8                          # ocp8 cluster configuration
        └── rhacm                         # rhacm cluster configuration
```



## Seal secrets

```bash
kubeseal  \
  --controller-name sealed-secret-controller-sealed-secrets \
  --controller-namespace sealed-secrets \
  --fetch-cert


kubeseal \
  --controller-name sealed-secret-controller-sealed-secrets \
  --controller-namespace sealed-secrets \
  --format yaml \
  < <(oc create secret generic test --from-literal=key1=supersecret --dry-run=client -o yaml)

```
