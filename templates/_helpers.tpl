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
Creates the basic labels which everything has.
*/}}
{{- define "gluu.labels" -}}
app: {{ template "gluu.name" . }}
chart: {{ template "gluu.chart" . }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end -}}

{{/*
Creates a csv list of the ldap servers
*/}}
{{- define "gluu.ldaplist" -}}
{{- $hosts := .Values.global.ldap.extraHosts -}}
{{- $genLdap := dict "host" (printf "%s-%s" .Release.Name .Values.global.ldap.type) "port" .Values.global.ldap.ldapPort -}}
{{- $hosts := prepend $hosts $genLdap -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := $hosts -}}
{{- if not $local.first -}},{{- end -}}{{- printf "%s:%.f" $v.host $v.port -}}{{- $_ := set $local "first" false -}}
{{- end -}}
{{- end -}}
