### Config-init

This sub-chart is supposed to generate or load all the configurations required by the Gluu server to run.

### Environment Variables

For the env vars we use k8s `ConfigMap` for templating the required variables.
These variables maybe changed/customized according to your own preference as stated in the official Gluu server documentaion show [Here](https://gluu.org/docs/de/reference/config-init/#generate)

To check which values are available for customization, use the helm command `helm inspect values <chart_name>` you will be presented with something like  

```
# Declare variables to be passed into your templates.

# values for config-init sub-chart
config:
  orgName: gluu
  # email address of the administrator usually. Used for certificate creation
  email: support@gluu.com
  # adminPass is administrator password for oxTrust and LDAP
  adminPass: password
  # domain name where the Gluu Server resides
  domain: localhost
  # organisation location details
  countryCode: US
  state: UT
  city: SLC
  # ldapType only OpenDJ is supported
  ldapType: opendj

global:
  namespace: default
  configAdapterName: kubernetes
  configSecretAdapter: kubernetes
  gluuConfigK8sNamespace: default
  gluuConfigK8sConfigmap: gluu
  gluuConfigK8sUseKubeConfig: false
  gluuSecretK8sNamespace: default
  gluuSecretK8sConfigmap: gluu
  gluuSecretK8sUseKubeConfig: false
  gluuSecretAdapter: kubernetes
```

For the config-init environment variables, use the variables under config. You can pass pass your data configurations via `--values or -f ` option when doing `helm install` for example `helm install -f my-own-config.yml`  

The other way is to use `--set` flag when installing the chart. Example of nested values, `--set config.orgName=K8s`

`NOTE :`   
The value `provisioner` that is under `storageclass` must be changed to the correct cloud provider in use. In our case, we have taken care of the major 3 cloud providers. i.e `GCP`,`AWS` and `AZURE`.

The following values should be used as provisioner for different types of cloud providers.

|  Cloud Provider  |  provisioner               |
|  --------------  |  ------------------------- |
|  AWS             |  kubernetes.io/aws-ebs     |
|  GKE             |  kubernetes.io/gce-pd      |
|  AZURE           |  kubernetes.io/azure-disk  |  

One will need to change different values based on the provisioner used. For example, if you choose `kubernetes.io/aws-ebs` you may need to change the value of `awsZones` to fit the zone you are using. Refer to [kubernetes.io](https://kubernetes.io/docs/concepts/storage/storage-classes/) for more details on what parameters to use for your provisioner.

One more thing to note here is that the `ConfigMap` has a namespace metadata variable. Which is globally referenced in the charts. it can be changed the same way described above but in this case we use the parent value `global`.