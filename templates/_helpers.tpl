{{/*
Expand the name of the chart.
*/}}
{{- define "jumpwire.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jumpwire.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jumpwire.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "jumpwire.labels" -}}
helm.sh/chart: {{ include "jumpwire.chart" . }}
{{ include "jumpwire.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "jumpwire.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jumpwire.name" . }}
app.kubernetes.io/component: engine
app.kubernetes.io/part-of: jumpwire
app.kubernetes.io/instance: {{ .Release.Name }}
jumpwire.ai/cluster: {{ .Values.cluster }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "jumpwire.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "jumpwire.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
