#!/bin/bash

# Check if a parameter is passed
if [ -z "$1" ]; then
  echo "Usage: $0 <values-file>"
  exit 1
fi

# Assign the parameter to a variable
VALUES_FILE=$1

# Read the image tag from the specified values file
APP_VERSION=$(grep 'tag:' "$VALUES_FILE" | awk '{print $2}')
CHART_VERSION=$(grep 'chartVersion:' "$VALUES_FILE" | awk '{print $2}')

# Check if APP_VERSION was found
if [ -z "$APP_VERSION" ]; then
  echo "Error: No tag found in $VALUES_FILE"
  exit 1
fi

# Check if CHART_VERSION was found
if [ -z "$CHART_VERSION" ]; then
  echo "Error: No chartVersion found in $VALUES_FILE"
  exit 1
fi

# Update Chart.yaml with the image tag and chart version
sed -i.bak "s/^appVersion:.*/appVersion: $APP_VERSION/" Chart.yaml
sed -i.bak "s/^version:.*/version: $CHART_VERSION/" Chart.yaml
