# GitOps-based Flask Application on GKE

This repository demonstrates an end-to-end **GitOps workflow** for deploying and operating
a containerized Flask application on **Google Kubernetes Engine (GKE)**.

The solution follows modern platform engineering and SRE best practices by clearly
separating **infrastructure provisioning**, **continuous integration**, and
**continuous delivery** responsibilities.

---

## Architecture Overview
### Core Principles
- **Git is the single source of truth**
- **Infrastructure is provisioned declaratively**
- **Applications are deployed via GitOps**
- **Manual Kubernetes changes are intentionally overwritten**

### Tooling
- **Terraform** – Infrastructure provisioning
- **GitHub Actions** – Continuous Integration (CI)
- **ArgoCD** – GitOps-based Continuous Delivery (CD)
- **Helm** – Kubernetes application packaging
- **GKE** – Kubernetes runtime
- **Artifact Registry** – Container image registry

### Deployment Flow
```
Developer Commit
         ↓
GitHub Actions (CI)
       - Build Docker image
       - Push to Artifact Registry
       - Update Helm values with immutable image tag
         ↓
Git Repository (desired state)
         ↓
ArgoCD (GitOps reconciliation)
         ↓
GKE (Application rollout)
````

---

## Repository Structure
```
.
├── app/ # Flask application source code
│ ├── app.py
│ ├── Dockerfile
│ └── requirements.txt
├── helm/
│ └── hello-flask/ # Helm chart for Flask application
│ ├── Chart.yaml
│ ├── templates/
│ └── values.yaml
├── infra/ # Terraform infrastructure code
├── argocd/ # ArgoCD Application manifests
├── scripts/ # Helper scripts (build, deploy, load test)
├── .github/workflows/ # GitHub Actions CI pipelines
└── README.md
```

### Directory Responsibilities
- `infra/`  
  Bootstraps the **platform** (GKE, ArgoCD, ingress, Artifact Registry, networking)

- `app/`  
  Contains **application code only** (no Kubernetes concerns)

- `helm/`  
  Defines the **desired Kubernetes state** for the application

- `argocd/`  
  Defines how ArgoCD consumes Git as the source of truth

---

## Infrastructure Provisioning (Terraform)
Infrastructure is provisioned using Terraform and includes:

- VPC and networking
- GKE cluster
- Artifact Registry
- ingress-nginx controller
- metrics-server
- ArgoCD installation
- TLS configuration for ArgoCD ingress

Terraform is responsible **only for platform bootstrapping**.
Application lifecycle management is intentionally excluded and delegated to GitOps.

### Usage
```
bash
cd infra
terraform init
terraform apply
```
> Terraform state files are intentionally excluded from version control.

---
## Continuous Integration (CI)
CI is implemented using *GitHub Actions*.

### CI Responsibilities
- Build Docker image from Flask application
- Tag image using an immutable Git SHA
- Push image to Google Artifact Registry
- Update Helm values.yaml with the new image tag
- Commit the change back to Git

### CI Trigger
The CI pipeline runs automatically when changes are pushed to:

- app/**
- .github/workflows/**

### Authentication
CI authenticates to GCP using a dedicated service account with the
artifactregistry.writer role.
Credentials are stored securely as GitHub repository secrets.

---
## Continuous Delivery (CD) with ArgoCD
ArgoCD is used as the GitOps engine for this project.

### GitOps Principles
- Git is the single source of truth
- No manual kubectl apply for application resources
- Drift is automatically detected and corrected
- Rollbacks are performed via Git history

### Application Deployment
The Flask application is deployed via an ArgoCD Application resource that points
directly to the Helm chart in this repository.

ArgoCD continuously watches Git and reconciles the cluster state.

> Any manual changes made directly to Kubernetes resources will be overwritten by ArgoCD.

---
## Application Deployment Details
- Deployed into the flask namespace
- Packaged as a Helm chart
- Uses immutable image tags
- Rolling updates enabled
- Horizontal Pod Autoscaler (HPA) configured
- Exposed via nginx-ingress

---
## Validation Performed
The following validations were completed:
- CI pipeline successfully builds and pushes images
- Helm values are updated automatically by CI
- ArgoCD detects Git changes and syncs automatically
- New image versions are deployed without manual intervention
- Replica count changes via Git are reconciled correctly
- End-to-end CI → CD → GitOps flow verified

---
### Operational Notes
- Self-signed certificates are used for demonstration purposes
- Browser trust must be configured locally to access HTTPS endpoints
- For production environments, cert-manager or Google Managed Certificates are recommended

---
## Design Decisions & Trade-offs
- *Helm + ArgoCD* were chosen for standardization and flexibility
- *GitOps over imperative deployments* ensures auditability and drift prevention
- *Immutable image tags* guarantee reproducibility and traceability
- *Single repository model* simplifies ownership and evaluation for this assignment

---
## Demonstrating GitOps
To demonstrate GitOps behavior:
1. Update replicaCount in helm/hello-flask/values.yaml
2. Commit and push the change
3. Observe ArgoCD automatically syncing and scaling pods

No manual Kubernetes commands are required.

---
## Future Improvements
- Replace service account keys with Workload Identity Federation
- Add automated tests to the CI pipeline
- Introduce ArgoCD Image Updater
- Support multiple environments (dev/stage/prod)
- Add monitoring and alerting (Prometheus/Grafana)

---
## Summary
This repository demonstrates a clean, production-aligned GitOps workflow where:
- Terraform bootstraps the platform
- GitHub Actions handles build and image publication
- ArgoCD continuously reconciles application state from Git
- Kubernetes remains declarative and self-healing

