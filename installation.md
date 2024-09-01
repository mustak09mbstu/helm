# Helm installation

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh
 helm version --short
```

# add helm public repo
```bash
helm repo add stable https://charts.helm.sh/stable
helm repo list
helm search repo -l gitlab/gitlab-runner
```


# Flow control in Helm

- ['https://www.baeldung.com/ops/helm-flow-control']

# Manage different environment using helm
- ['https://blog.tarkalabs.com/handling-multiple-environments-with-helm-kubernetes-f214192f8f7b']

# Tutorial for managing multi-environment using helm
- ['https://www.youtube.com/watch?v=ZvG8rfJ4XxM']

# Helm tutorial
- ['https://www.youtube.com/watch?v=gbUBTTXuQwI&list=PLLYW3zEOaqlKYku0piyzzLFGpR9VpPvXR']

# Github link for Resources
- ['https://github.com/DeekshithSN']