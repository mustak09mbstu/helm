# 1. Helm Library Chart for DPE, Banglalink Deployment

**Chart name:** common


## 1.1. Chart Dependency
Add below dpendency in application's `Chart.yaml`, check [index.yaml](./index.yaml) for the latest chart release version:
```bash
dependencies:
  - name: common
    version: 0.1.x
    repository: https://digital-gitlab.banglalink.net/helm/helm-charts/-/raw/main
```


# References