# Apps repo



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