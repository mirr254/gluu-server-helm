**Note**:  
For minikube, Specs used to test the charts are. 3GB RAM and 40GB memory.

## Gluu Server

[Gluu server](https://www.google.com) is an open-source IAM server that sync backend identities, leverage external IDPs, and achieve SSO, 2FA and more.

## TL;DR;

`helm install beta/gluu`

## Introduction

This chart bootstraps a Gluu Server deployment on a kubernetes cluster using Helm package manager.  
It also packages other components/services that make up Gluu Server.

## Prerequisites

- kubernetes 1.5+ 
- PV provisioner support int the underlying infreastructure

## installing the chart

To install the chart with the release name `my-release`:

`$ helm install --name my-release`

The command deploys Gluu Server on kubernetes cluster in the default configuration. The [configuration](https://github.com/mirr_254/gluu-server-helm/tree/medit-charts#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

`$ helm delete my-release`

If during installation the release was not defined, released is checked by running `$ helm ls` the deleted using the previous command and the default release name.

## Configuration

|       Parameter          |      Description               |Default                             |
|--------------------------|--------------------------------|------------------------------------|
| 1                        | 2                              |                                    |
| word                     | Code                           |                                    |