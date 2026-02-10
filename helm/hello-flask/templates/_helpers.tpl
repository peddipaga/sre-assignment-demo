{{- define "hello-flask.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hello-flask.labels" -}}
app.kubernetes.io/name: {{ include "hello-flask.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: Helm
argocd.argoproj.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "hello-flask.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hello-flask.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
