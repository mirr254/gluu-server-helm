{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "gluu.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gluu.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gluu.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
    Define common environment variables that will be used on all the microservices
*/}}
{{- define "gluu.commonEnvVars" -}}
- name: GLUU_CONFIG_ADAPTER
  value: {{ .Values.global.configAdapterName | quote }}
- name: GLUU_CONFIG_KUBERNETES_NAMESPACE
  value: {{ .Values.global.gluuConfigK8sNamespace | quote }}
- name: GLUU_CONFIG_KUBERNETES_CONFIGMAP
  value: {{ .Values.global.gluuConfigK8sConfigmap | quote }}
- name: GLUU_CONFIG_KUBERNETES_USE_KUBE_CONFIG
  value: {{ .Values.global.gluuConfigK8sUseKubeConfig }}
- name: GLUU_SECRET_KUBERNETES_NAMESPACE
  value: {{ .Values.global.gluuSecretK8sNamespace | quote }}
- name: GLUU_SECRET_KUBERNETES_CONFIGMAP
  value: {{ .Values.global.gluuSecretK8sConfigmap | quote }}
- name: GLUU_SECRET_KUBERNETES_USE_KUBE_CONFIG
  value: {{ .Values.global.gluuSecretK8sUseKubeConfig }}
{{- end -}}