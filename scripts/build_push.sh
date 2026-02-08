#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${1:?usage: build_push.sh <PROJECT_ID>}"
TAG="${2:-v1}"

IMAGE="gcr.io/${PROJECT_ID}/hello-flask:${TAG}"

gcloud auth configure-docker -q
docker build -t "${IMAGE}" ./app
docker push "${IMAGE}"

echo "Pushed ${IMAGE}"
