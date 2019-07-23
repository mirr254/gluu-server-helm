### Note: 
For minikube, I used 3GB of RAM and 40GB of Disk space.

# Config sub-chart
We create a service account `tiller` for the tiller server which resides in the kube-system namespace. Don't forget that service accounts are ment for intra-cluster processes running in pods.

Next we bind the cluster-admin ClustureRole to this service account. This role is included by default in a k8s cluster and has all the admin rights of a cluster. We will use ClusterRoleBinding as it is supposed to be used accross all namespaces. Here, we want tiller to manage resources in all namespaces.

After deploying the chart, we can run `helm init --service-account tiller --upgrade` just to make sure the tiller deployment has associated its pods with the service account `tiller`
