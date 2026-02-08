#!/usr/bin/env bash
set -euo pipefail


helm upgrade --install hello-flask ./helm/hello-flask -n sre-demo