{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "milvus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "milvus.namespace" -}}
{{- .Release.Namespace -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "milvus.fullname" -}}
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
Create a default fully qualified standalone name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.standalone.fullname" -}}
{{ template "milvus.fullname" . }}-standalone
{{- end -}}

{{/*
Create a default fully qualified Root Coordinator name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.rootcoord.fullname" -}}
{{ template "milvus.fullname" . }}-rootcoord
{{- end -}}

{{/*
Create a default fully qualified Proxy name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.proxy.fullname" -}}
{{ template "milvus.fullname" . }}-proxy
{{- end -}}

{{/*
Create a default fully qualified Query Coordinator name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.querycoord.fullname" -}}
{{ template "milvus.fullname" . }}-querycoord
{{- end -}}

{{/*
Create a default fully qualified Query Node name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.querynode.fullname" -}}
{{ template "milvus.fullname" . }}-querynode
{{- end -}}

{{/*
Create a default fully qualified Index Coordinator name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.indexcoord.fullname" -}}
{{ template "milvus.fullname" . }}-indexcoord
{{- end -}}

{{/*
Create a default fully qualified Index Node name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.indexnode.fullname" -}}
{{ template "milvus.fullname" . }}-indexnode
{{- end -}}

{{/*
Create a default fully qualified Data Coordinator name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.datacoord.fullname" -}}
{{ template "milvus.fullname" . }}-datacoord
{{- end -}}

{{/*
Create a default fully qualified Data Node name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.datanode.fullname" -}}
{{ template "milvus.fullname" . }}-datanode
{{- end -}}

{{/*
Create a default fully qualified Mixture Coordinator name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.mixcoord.fullname" -}}
{{ template "milvus.fullname" . }}-mixcoord
{{- end -}}

{{/*
Create a default fully qualified pulsar name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.pulsar.fullname" -}}
{{- $name := .Values.pulsar.name -}}
{{- if contains $name .Release.Name -}}
{{ .Release.Name }}
{{- else -}}
{{ .Release.Name }}-pulsar
{{- end -}}
{{- end -}}

{{/*
Create a default failly qualified logstore name.
*/}}
{{- define "milvus.logstore.fullname" -}}
{{- $name := .Values.logstore.name -}}
{{- if contains $name .Release.Name -}}
{{ .Release.Name }}
{{- else -}}
{{ .Release.Name }}-log
{{- end -}}
{{- end -}}

{{- define "milvus.logstore.zk.fullname" -}}
{{ template "milvus.logstore.fullname" . }}-zk
{{- end -}}

{{- define "milvus.logstore.bookie.fullname" -}}
{{ template "milvus.logstore.fullname" . }}-bookie
{{- end -}}

{{- define "milvus.logstore.proxy.fullname" -}}
{{ template "milvus.logstore.fullname" . }}-proxy
{{- end -}}

{{- define "milvus.tikv.fullname" }}
{{- $name := .Values.tikv.name -}}
{{- if contains $name .Release.Name -}}
{{ .Release.Name }}
{{- else -}}
{{ .Release.Name }}-tikv
{{- end -}}
{{- end -}}

{{/*
{/*
Create a default fully qualified attu name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "milvus.attu.fullname" -}}
{{ template "milvus.fullname" . }}-attu
{{- end -}}

{{/*
  Create the name of the service account to use for the Milvus components
  */}}
  {{- define "milvus.serviceAccount" -}}
  {{- if .Values.serviceAccount.create -}}
      {{ default "milvus" .Values.serviceAccount.name }}
  {{- else -}}
      {{ default "default" .Values.serviceAccount.name }}
  {{- end -}}
  {{- end -}}

{{/*
Create milvus attu env name.
*/}}
{{- define "milvus.attu.env" -}}
- name: MILVUS_URL
  value: http://{{ template "milvus.fullname" .}}:19530
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "milvus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Helm required labels */}}
{{- define "milvus.labels" -}}
helm.sh/chart: {{ include "milvus.chart" . }}
{{ include "milvus.matchLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* labels defiend by user*/}}
{{- define "milvus.ud.labels" -}}
{{- if .Values.labels }}
{{- toYaml .Values.labels }}
{{- end -}}
{{- end -}}

{{/* annotations defiend by user*/}}
{{- define "milvus.ud.annotations" -}}
{{- if .Values.annotations }}
{{- toYaml .Values.annotations }}
{{- end -}}
{{- end -}}

{{/* matchLabels */}}
{{- define "milvus.matchLabels" -}}
app.kubernetes.io/name: {{ include "milvus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* define rootcoord activeStandby */}}
{{- define "milvus.rootcoord.activeStandby" -}}
{{- if or .Values.rootCoordinator.activeStandby.enabled (and .Values.mixCoordinator.enabled .Values.mixCoordinator.activeStandby.enabled) -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}

{{/* define querycoord activeStandby */}}
{{- define "milvus.querycoord.activeStandby" -}}
{{- if or .Values.queryCoordinator.activeStandby.enabled (and .Values.mixCoordinator.enabled .Values.mixCoordinator.activeStandby.enabled) -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}

{{/* define indexcoord activeStandby */}}
{{- define "milvus.indexcoord.activeStandby" -}}
{{- if or .Values.indexCoordinator.activeStandby.enabled (and .Values.mixCoordinator.enabled .Values.mixCoordinator.activeStandby.enabled) -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}

{{/* define datacoord activeStandby */}}
{{- define "milvus.datacoord.activeStandby" -}}
{{- if or .Values.dataCoordinator.activeStandby.enabled (and .Values.mixCoordinator.enabled .Values.mixCoordinator.activeStandby.enabled) -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}