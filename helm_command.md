# Helm basic command
```bash
helm --help
helm registry login [host] [flags]
helm search repo
helm repo add stable https://charts.helm.sh/stable
helm repo list

helm search repo
helm repo add gitlab https://charts.gitlab.io
helm repo list

helm search repo -l gitlab/gitlab-runner
helm repo list
helm repo update gitlab
```
# create nginx-chart using helm
```bash

helm create nginx-chart
root@DESKTOP-OAM0BVD:/home/sysadmin# cd nginx-chart/
root@DESKTOP-OAM0BVD:/home/sysadmin/nginx-chart#
root@DESKTOP-OAM0BVD:/home/sysadmin/nginx-chart# ls -la
total 28
drwxr-xr-x  4 root     root     4096 Apr 16 16:04 .
drwxr-x--- 12 sysadmin sysadmin 4096 Apr 16 16:04 ..
-rw-r--r--  1 root     root      349 Apr 16 16:04 .helmignore
-rw-r--r--  1 root     root     1147 Apr 16 16:04 Chart.yaml
drwxr-xr-x  2 root     root     4096 Apr 16 16:04 charts
drwxr-xr-x  3 root     root     4096 Apr 16 16:04 templates
-rw-r--r--  1 root     root     2364 Apr 16 16:04 values.yaml
root@DESKTOP-OAM0BVD:/home/sysadmin/nginx-chart#
```

# Create a folder and generate heml charts there

```bash
mkdir two-tier-app
cd two-tier-app
helm create mysql-chart

root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm create mysql-chart
Creating mysql-chart
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# ls
mysql-chart
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# cd mysql-chart
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app/mysql-chart# ls
Chart.yaml  charts  templates  values.yaml
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app/mysql-chart#
```

# Package helm chart
```bash
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# ls
mysql-chart
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm package mysql-chart
Successfully packaged chart and saved it to: /home/sysadmin/two-tier-app/mysql-chart-0.1.0.tgz
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# ls
mysql-chart  mysql-chart-0.1.0.tgz
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app#
```

# Install helm chart
- https://www.youtube.com/watch?v=pHGc87zHLlo&list=PL7iMyoQPMtANm_35XWjkNzDCcsw9vy01b

```bash
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm install mysql-chart ./mysql-chart
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
mysql-chart     dev-ns          1               2024-04-16 16:46:25.647364314 +0600 +06 deployed        mysql-chart-0.1.0       1.16.0
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app#
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# k logs mysql-chart-7658dd648d-4pvp8
Error from server (BadRequest): container "mysql-chart" in pod "mysql-chart-7658dd648d-4pvp8" is waiting to start: trying and failing to pull image

# Others helm installation command
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm install release-name webapp1/
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm install release-dev webapp1/ --values webapp1/values.yaml -f webapp1/values-dev.yaml -n dev
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm install release-prod webapp1/ --values webapp1/values.yaml -f webapp1/values-prod.yaml -n prod

```

# uninstall helm chart

```bash
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
mysql-chart     dev-ns          1               2024-04-16 16:46:25.647364314 +0600 +06 deployed        mysql-chart-0.1.0       1.16.0
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app#
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app#
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm uninstall mysql-chart
release "mysql-chart" uninstalled
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app#
```

# Check template

```bash
root@DESKTOP-OAM0BVD:/home/sysadmin/two-tier-app# helm template mysql-chart
```
# Upgrade helm chart

```bash
helm upgrade mysql-chart ./mysql-chart
```
```bash
k exec -it mysql-chart-5b67c69cfd-c5bd5 bash
```

# Helm Search command

```bash
helm search hub wordpress
helm search hub wordpress --max-col-width=0
helm search hub wordpress --output yaml
```
# Run the helm show chart command to retrieve the metadata for the chart

```bash
helm show chart bitnami/wordpress --version 12.1.6
helm show readme
helm show values
helm show all
```

# The following commands can be used to provide a set of detailed release information

```bash
helm get hooks 
helm get manifest
helm get manifest bitnami/wordpress > wordpress-dev-manifest.yaml
helm get notes
helm get values
helm show values bitnami/wordpress > wordpress-dev-values.yaml
helm get all
```
# Wordpress installation using helm chart
```bash
helm install my-release oci://registry-1.docker.io/bitnamicharts/wordpress
helm install my-release \
  --set wordpressUsername=admin \
  --set wordpressPassword=password \
  --set mariadb.auth.rootPassword=secretpassword \
    oci://registry-1.docker.io/bitnamicharts/wordpress

helm upgrade my-release \
  --set wordpressUsername=admin \
  --set wordpressPassword=password \
  --set mariadb.auth.rootPassword=secretpassword \
    oci://registry-1.docker.io/bitnamicharts/wordpress
```
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-wordpress bitnami/wordpress --version 22.2.1
helm install my-wordpress -f values.yaml oci://registry-1.docker.io/bitnamicharts/wordpress
```

```bash
helm install my-wordpress ./my-wordpress --dry-run --debug 
helm install my-wordpress ./my-wordpress --set service.type=NodePort
```
# helm autocompletion
```bash
source <(helm completion bash)
```
# helm package for packaging a helm chart
```bash
helm package my-wordpress
helm package my-wordpress --destination /app/opt
helm package my-wordpress --destination /app/opt --version 0.2.0
```

# helm plugin install
- ['https://helm.sh/docs/community/related/#helm-plugins']

```bash
helm plugin install https://github.com/databus23/helm-diff.git
helm -h
helm diff upgrade my-app test --values test/values.yaml
helm plugin update diff
```

# helm pull

```bash
helm pull [chart_name] [option] --repo [repo_url]
helm pull airflow --version 6.2.0 --repo https://charts.bitnami.com/bitnami
```

# helm install and rollnback
```bash
helm install [release_name] [chart_name]
helm install my-app nginx
helm install my-all --debug --dry-run nginx

```
```bash
helm history [release_name]
helm history my-app
helm rollback [release_name] [revision_number]
helm rollback my-app 1
helm rollback my-app 1 --force --no-hooks
```
# helm search

```bash
helm repo list

root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/webserver/nginx# helm repo list
NAME    URL
stable  https://charts.helm.sh/stable
gitlab  https://charts.gitlab.io
bitnami https://charts.bitnami.com/bitnami
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/webserver/nginx#
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/webserver/nginx#
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/webserver/nginx# helm search repo nginx
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION
bitnami/nginx                           16.0.5          1.25.5          NGINX Open Source is a web server that can be a...
bitnami/nginx-ingress-controller        11.1.0          1.10.0          NGINX Ingress Controller is an Ingress controll...
bitnami/nginx-intel                     2.1.15          0.4.9           DEPRECATED NGINX Open Source for Intel is a lig...
stable/nginx-ingress                    1.41.3          v0.34.1         DEPRECATED! An nginx Ingress controller that us...
stable/nginx-ldapauth-proxy             0.1.6           1.13.5          DEPRECATED - nginx proxy with ldapauth
stable/nginx-lego                       0.3.1                           Chart for nginx-ingress-controller and kube-lego
stable/gcloud-endpoints                 0.1.2           1               DEPRECATED Develop, deploy, protect and monitor...
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/webserver/nginx#

root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/webserver/nginx# helm search repo nginx --devel
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION
bitnami/nginx                           16.0.5          1.25.5          NGINX Open Source is a web server that can be a...
bitnami/nginx-ingress-controller        11.1.0          1.10.0          NGINX Ingress Controller is an Ingress controll...
bitnami/nginx-intel                     2.1.15          0.4.9           DEPRECATED NGINX Open Source for Intel is a lig...
stable/nginx-ingress                    1.41.3          v0.34.1         DEPRECATED! An nginx Ingress controller that us...
stable/nginx-ldapauth-proxy             0.1.6           1.13.5          DEPRECATED - nginx proxy with ldapauth
stable/nginx-lego                       0.3.1                           Chart for nginx-ingress-controller and kube-lego
stable/gcloud-endpoints                 0.1.2           1               DEPRECATED Develop, deploy, protect and monitor...
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/webserver/nginx#

```

If you want to search in hub

```bash
helm search hub nginx
helm search hub nginx --devel
```

# helm show
```bash
helm show -h
helm show all [chart_name]
helm show all nginx
helm show chart nginx
helm show readme nginx
helm show values nginx
```

# helm status

```bash
helm status [release_name]
helm status my-app
helm status my-app -o json
```
# helm template

```bash
helm template -h
helm template [name] [chart] [flag]
helm template test1 nginx
```