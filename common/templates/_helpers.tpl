# common defination for template

{{- define "common.labels.standard" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/common-lib-chart-version: {{ .Values.commonLibChartVersion }}
{{- end -}}

{{- /*
# {{- define "common.labels.extended" -}}
# {{- include "common.labels.standard" . }}
# additional-label: some-value
# {{- end -}}
*/}}

{{- define "namespace" -}}
    {{ .Release.Namespace }}
{{- end -}}


{{- /*
define extra label from value file
*/}}
{{- define "common.extra.label" -}}

{{- if .Values.extraLabel.enabled }}
{{- range $key, $value := .Values.extraLabel.labels }}
{{ $key }}: {{ $value }}
{{- end }}
{{- end }}

{{- end -}}



{{- define "ApplicationLabel-stable" -}}
{{- include "common.labels.standard" . }}
app: {{ .Values.app.name }}
env: {{ .Values.env }}
loglabelindex: {{ .Values.app.name }}-{{ .Values.env }}
version: {{ .Values.app.name }}-stable
# version: stable
# smversion: {{ .Values.app.name }}-stable
{{- include "common.extra.label" . }}
{{- end -}}

{{- define "ApplicationLabel-canary" -}}
{{- include "common.labels.standard" . }}
app: {{ .Values.app.name }}
env: {{ .Values.env }}
loglabelindex: {{ .Values.app.name }}-{{ .Values.env }}
version: {{ .Values.app.name }}-canary
# version: canary
# smversion: {{ .Values.app.name }}-canary
{{- include "common.extra.label" . }}
{{- end -}}


{{- define "applicationServiceLabelSelector" -}}
app: {{ .Values.app.name }}
env: {{ .Values.env }}
loglabelindex: {{ .Values.app.name }}-{{ .Values.env }}
{{- include "common.extra.label" . }}
{{- end -}}

{{- /*
# {{- define "vaultAuthRefName" -}}
# vault-auth
# {{- end -}}
*/}}

{{- /*
# {{- define "application-worker" -}}
# app: {{ .Values.app.name }}-worker
# env: {{ .Values.env }}
# loglabelindex: {{ .Values.app.name }}-worker-{{ .Values.env }}
# version: stable
# {{- end -}}
*/}}






{{- /*
# Define label for worker
*/}}

{{- define "applicationLable-worker-stable" -}}
{{- include "common.labels.standard" . }}
app: {{ .Values.app.name }}-worker
env: {{ .Values.env }}
version: {{ .Values.app.name }}-worker-stable
{{- include "common.extra.label" . }}
{{- end -}}

{{- define "applicationLabel-worker-canary" -}}
{{- include "common.labels.standard" . }}
app: {{ .Values.app.name }}-worker
env: {{ .Values.env }}
version: {{ .Values.app.name }}-worker-canary
{{- include "common.extra.label" . }}
{{- end -}}

{{- define "applicationWorkerServiceLabelSelector" -}}
app: {{ .Values.app.name }}-worker
env: {{ .Values.env }}
{{- include "common.extra.label" . }}
{{- end -}}


{{- /*
# Define label topologySpreadConstraints
*/}}
{{- define "application.topologySpreadConstraints" -}}
{{- if and .Values.trafficTopologyDistributionRule.enabled .Values.trafficTopologyDistributionRule.topologySpreadConstraints }}
topologySpreadConstraints:
{{- range .Values.trafficTopologyDistributionRule.topologySpreadConstraints }}
  - maxSkew: {{ .maxSkew }}
    topologyKey: "{{ .topologyKey }}"
    whenUnsatisfiable: {{ .whenUnsatisfiable }}
    nodeAffinityPolicy: {{ .nodeAffinityPolicy }}
    nodeTaintsPolicy: {{ .nodeTaintsPolicy }}
    labelSelector:
      matchLabels:
      {{- include "applicationServiceLabelSelector" (dict "Values" $.Values "Chart" $.Chart "Release" $.Release) | nindent 8 }}
{{- if .matchLabelKeys }}
    matchLabelKeys:
{{- range .matchLabelKeys }}
      - {{ . }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "application.nodeAffinity" -}}
{{- if and .Values.trafficTopologyDistributionRule.affinity.enabled .Values.trafficTopologyDistributionRule.affinity.nodeAffinity.enabled }}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
{{- range .Values.trafficTopologyDistributionRule.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms }}
      - matchExpressions:
{{- range .matchExpressions }}
        - key: "{{ .key }}"
          operator: {{ .operator }}
          values:
{{- range .values }}
            - {{ . }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}



{{- /*
# End of Define label topologySpreadConstraints
*/}}

