# Create docker-registry secret help
```bash
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/IAM# k create secret docker-registry -h
```
# Create secret
```bash
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/IAM# kubectl create secret docker-registry devuser-secret --docker-server=mybl-registry.banglalink.net:443 --docker-username='regdevuser' --docker-password='Dev@Uer#20240415' --docker-email='regdevuser@example.com'
```
# Get all secrets
```bash
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/IAM# k get secrets
NAME                                 TYPE                             DATA   AGE
admin-secret                         kubernetes.io/dockerconfigjson   1      68d
devuser-secret                       kubernetes.io/dockerconfigjson   1      68d
iam-service-secrets                  Opaque                           6      5m17s
my-secret                            Opaque                           2      3h13m
my-secret-from-file                  Opaque                           1      3h11m
my-wordpress                         Opaque                           1      62d
my-wordpress-mariadb                 Opaque                           2      62d
sh.helm.release.v1.my-wordpress.v1   helm.sh/release.v1               1      62d
sh.helm.release.v1.test-bliam.v1     helm.sh/release.v1 
```


# get secret
```bash
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/IAM# k get secret devuser-secret
NAME             TYPE                             DATA   AGE
devuser-secret   kubernetes.io/dockerconfigjson   1      68d
```
# Describe secret
```bash
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/IAM# k describe secret devuser-secret
Name:         devuser-secret
Namespace:    devcl2-deploy-ns
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/dockerconfigjson

Data
====
.dockerconfigjson:  181 bytes
```
# get secret value in yaml format
```bash
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/IAM# k get secret devuser-secret -o yaml
apiVersion: v1
data:
  .dockerconfigjson: eyJhdXRocyI6eyJteWJsLXJlZ2lzdHJ5LmJhbmdsYWxpbmsubmV0OjQ0MyI6eyJ1c2VybmFtZSI6InJlZ2RldnVzZXIiLCJwYXNzd29yZCI6IkRldkBVZXIjMjAyNDA0MTUiLCJlbWFpbCI6InJlZ2RldnVzZXJAZXhhbXBsZS5jb20iLCJhdXRoIjoiY21WblpHVjJkWE5sY2pwRVpYWkFWV1Z5SXpJd01qUXdOREUxIn19fQ==
kind: Secret
metadata:
  creationTimestamp: "2024-04-18T09:53:26Z"
  name: devuser-secret
  namespace: devcl2-deploy-ns
  resourceVersion: "6925400"
  uid: c739e601-ea3a-4c2f-926e-469f79bf25f1
type: kubernetes.io/dockerconfigjson
```
# show secret value
```bash
root@DESKTOP-OAM0BVD:/mnt/d/BL/Helm/IAM# echo 'eyJhdXRocyI6eyJteWJsLXJlZ2lzdHJ5LmJhbmdsYWxpbmsubmV0OjQ0MyI6eyJ1c2VybmFtZSI6InJlZ2RldnVzZXIiLCJwYXNzd29yZCI6IkRldkBVZXIjMjAyNDA0MTUiLCJlbWFpbCI6InJlZ2RldnVzZXJAZXhhbXBsZS5jb20iLCJhdXRoIjoiY21WblpHVjJkWE5sY2pwRVpYWkFWV1Z5SXpJd01qUXdOREUxIn19fQ==' | base64 -d
```

# output
```bash
{"auths":{"mybl-registry.banglalink.net:443":{"username":"regdevuser","password":"Dev@Uer#20240415","email":"regdevuser@example.com","auth":"cmVnZGV2dXNlcjpEZXZAVWVyIzIwMjQwNDE1"}}}
```