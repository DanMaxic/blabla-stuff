{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "server.name" -}}
{{- default "selenoid-server" .Values.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ui.name" -}}
{{- default "selenoid-ui" .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
