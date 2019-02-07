{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "rabbitmq.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rabbitmq.fullname" -}}
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
{{- define "rabbitmq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Defines a JSON file containing definitions of all broker objects (queues, exchanges, bindings,
users, virtual hosts, permissions and parameters) to load by the management plugin.
*/}}
{{- define "rabbitmq.definitions" -}}
{
  "users": [
    {
      "name": {{ .Values.managementUsername | quote }},
      "password": {{ .Values.managementPassword | quote }},
      "tags": "management"
    },
    {
      "name": {{ .Values.rabbitmqUsername | quote }},
      "password": {{ .Values.rabbitmqPassword | quote }},
      "tags": "administrator"
    }{{- range $user := .Values.definitions.users -}},
    {{ $user | toJson }}
{{- end }}
  ],
  "vhosts": [
    {
      "name": {{ .Values.rabbitmqVhost | quote }}
    }{{- range $vhost := .Values.definitions.vhosts -}},
    {{ $vhost | toJson }}
{{- end }}
  ],
  "permissions": [
    {
      "user": {{ .Values.rabbitmqUsername | quote }},
      "vhost": {{ .Values.rabbitmqVhost | quote }},
      "configure": ".*",
      "read": ".*",
      "write": ".*"
    }{{- range $permission := .Values.definitions.permissions -}},
    {{ $permission | toJson }}
{{- end }}
  ],
  "parameters": {{ .Values.definitions.parameters | toJson }},
  "policies": {{ .Values.definitions.policies | toJson }},
  "queues": {{ .Values.definitions.queues | toJson }},
  "exchanges": {{ .Values.definitions.exchanges | toJson }},
  "bindings": {{ .Values.definitions.bindings | toJson }}
}
{{- end -}}

