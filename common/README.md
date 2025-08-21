**Table Contents:**
- [1. A Common Library Chart for DPE, Banglalink Deployment](#1-a-common-library-chart-for-dpe-banglalink-deployment)
  - [1.1. Chart Dependency](#11-chart-dependency)
  - [1.2. Package Helm Chart Files](#12-package-helm-chart-files)
  - [1.3. Generate index.yaml](#13-generate-indexyaml)
  - [1.4. Push the Charts and index.yaml to GitLab](#14-push-the-charts-and-indexyaml-to-gitlab)
  - [1.5. Access the Repository](#15-access-the-repository)
  - [1.6. Add the GitLab Repository to Helm](#16-add-the-gitlab-repository-to-helm)
- [2. References](#2-references)


# 1. A Common Library Chart for DPE, Banglalink Deployment

**Chart name:** common


## 1.1. Chart Dependency
Add below dpendency in application's `Chart.yaml`:
```bash
dependencies:
  - name: common
    version: 0.1.x
    repository: https://digital-gitlab.banglalink.net/helm/helm-charts/-/raw/main/
```

## 1.2. Package Helm Chart Files
Make a package of common-library:
```bash
# move to chart folder
cd helm/common

# make package
helm package .
```

Now, move to .tgz file to target charts repo:
```bash
# chart repo: https://digital-gitlab.banglalink.net/helm/helm-charts
# git clone https://digital-gitlab.banglalink.net/helm/helm-charts

mv common-x.x.x.tgz helm-charts
```

## 1.3. Generate index.yaml

After packaging your charts, generate the index.yaml file
```bash
# prepare index.yaml
# helm repo index .
# helm repo index /path/to/chart-directory --url https://<your-gitlab-instance>/helm-charts/-/raw/main
# helm repo index . --url https://digital-gitlab.banglalink.net/helm/common/-/raw/main
# https://digital-gitlab.banglalink.net/helm/common/-/raw/main/index.yaml?ref_type=heads


# final command
# move to helm-charts folder
helm repo index . --url https://digital-gitlab.banglalink.net/helm/helm-charts/-/raw/main
```

Now push *.tgz and index.yaml to repo:
```bash
git add .
git commit -m "Helm charts"
git remote add origin https://digital-gitlab.banglalink.net/helm/helm-charts.git
git push -u origin develop

# then create pull request
```


## 1.4. Push the Charts and index.yaml to GitLab

```bash
git init
git add .
git commit -m "Initial commit with Helm charts"
git remote add origin https://digital-gitlab.banglalink.net/helm/common.git
git push -u origin develop

# then create pull request
```


## 1.5. Access the Repository

```bash
curl -k https://digital-gitlab.banglalink.net/helm/common/-/raw/main/index.yaml
```


## 1.6. Add the GitLab Repository to Helm
```bash
helm repo add dpe https://digital-gitlab.banglalink.net/helm/common/-/raw/main
helm repo update

# check chart version
helm show chart dpe/common
```



# 2. References
- https://helm.sh/docs/topics/library_charts/
- https://codefresh.io/docs/docs/ci-cd-guides/helm-best-practices/
- https://docs.vmware.com/en/VMware-Tanzu-Application-Catalog/services/tutorials/GUID-production-ready-charts-index.html