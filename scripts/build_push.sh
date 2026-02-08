#!/usr/bin/env bash
set -euo pipefail

ARTIFACT_URL='us-central1-docker.pkg.dev'
PROJECT_ID=sre-assignment-gke-hpa
REPO=sre-takehome-demo
IMAGE=hello-flask
TAG=v1


#PROJECT_ID="${1:?usage: build_push.sh <PROJECT_ID>}"
PROJECT_ID="${1:?${PROJECT_ID}}"
TAG="${2:?${TAG}}"

docker buildx build \
  --platform linux/amd64 \
  -t ${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO}/${IMAGE}:${TAG} \
  --push \
  ./app


IMAGE="gcr.io/${PROJECT_ID}/hello-flask:${TAG}"
IMAGE="${ARTIFACT_URL}/${PROJECT_ID}/${REPO}/${IMAGE}:${TAG}"

gcloud auth configure-docker -q
docker build -t "${IMAGE}" ./app
docker push "${IMAGE}"

echo "Pushed ${IMAGE}"
