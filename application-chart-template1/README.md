# Application Chart Template 1

You require to setup `/etc/hosts` of your laptop file with below entry:
```bash
172.22.36.13 digital-gitlab.banglalink.net
```

If you face certificate related issue while cloning git repo then add following export command:
```bash
export GIT_SSL_NO_VERIFY=true
```

In the template chart, application chart name is consider `application-chart-template1` which is required to change as per your application name. 


If you need a token to clone the git repo then [do the same from here](https://digital-gitlab.banglalink.net/-/user_settings/personal_access_tokens).

Clone git repo to your local pc/laptop:
```bash
git clone https://digital-gitlab.banglalink.net/helm/application-chart-template1.git <application-name>

# or below command will help to clone repo
export GIT_SSL_NO_VERIFY=true git clone https://digital-gitlab.banglalink.net/helm/application-chart-template1.git <application-name>

cd application-name
```

Now change chart name and latest version in [`Chart.yaml`](./Chart.yaml):
```bash
apiVersion: v2
name: application-name
description: A Helm Application Chart Template for Kubernetes, DPE, Banglalink
type: application
version: 0.1.x

dependencies:
  - name: common
    version: 0.1.x
    repository: https://digital-gitlab.banglalink.net/helm/helm-charts/-/raw/main/
```

In [value file (an example file: `values-dev.yaml`)](./values-dev.yaml), change your app name:
```bash
app:
  name: application-name
```

Also, adjust [example value file](./values-dev.yaml) as per application need. 

Add the library chart repo information in your laptop/pc to generate manifest file:
```bash
# if certificate is provided by well-known/trusted partner
helm repo add dpe https://digital-gitlab.banglalink.net/helm/helm-charts/-/raw/main/

# insecure-skip-tls-verify for self-sign certificate
helm repo add dpe https://digital-gitlab.banglalink.net/helm/helm-charts/-/raw/main/ --insecure-skip-tls-verify

# update repo
helm repo update
```

Check latest chart version, set accordingly in the [Chart.yaml](./Chart.yaml)
```bash
# check latest chart version, set
helm show chart dpe/common
```



Then, require to build/update the helm dependency:
```bash
# cd move-to-chart-dir
# for first time you have to use dependency build command
helm dependency build

# for updating chart use dpendency update command
helm dependency update
```


Generate manifest file from template using [a modified value file](./values-dev.yaml):
```bash
# generate yaml file manually and check manifest files with respect to vaule file
helm template . -f values-dev.yaml
```

Now check manifest files for your target application deployment scenario. If everything is correct in terms of manifest then push your application chart code to repo in [`https://digital-gitlab.banglalink.net/digital-platform-manifest/yyyyy/application-name.git`](https://digital-gitlab.banglalink.net/digital-platform-manifest)


# References
- https://digital-gitlab.banglalink.net/-/user_settings/personal_access_tokens
- https://digital-gitlab.banglalink.net/helm/common
- https://digital-gitlab.banglalink.net/helm/helm-charts
- https://digital-gitlab.banglalink.net/digital-platform-manifest