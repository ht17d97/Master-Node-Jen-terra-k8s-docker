{{/*
Generate the full name of the release (e.g., amazon-app-amazon-app)
*/}}
{{- define "amazon-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

