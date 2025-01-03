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



# Build differ image

```bash
export VERSION=$(date +%Y%m%d%H%M)
export IMAGE="quay.io/stormshift/gitops-differ:${VERSION}"

podman build --platform linux/amd64,linux/arm64 \
  -f gitops-differ.Containerfile \
  --manifest ${IMAGE}  .
podman manifest push ${IMAGE}

```