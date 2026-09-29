# AWS Terraform S3 Pipeline
# Automated AWS Infrastructure Deployment via Terraform & GitHub Actions CI/CD

## 📌 Overview
This repository demonstrates an end-to-end **Infrastructure as Code (IaC)** and **Continuous Integration/Continuous Deployment (CI/CD)** workflow. It automates the provisioning of an **Amazon S3 Bucket** using **Terraform** and **GitHub Actions**, eliminating manual console configurations ("ClickOps") and enforcing security best practices.

---

## 🏗️ Architecture Workflow

```text
[ Local Developer Environment ]
              │
              │ (git push origin main)
              ▼
[ GitHub Repository ] ──► (Triggers GitHub Actions Workflow)
              │
              │ (Injects GitHub Secrets: AWS IAM Credentials)
              ▼
[ GitHub Actions Runner (Ubuntu Linux) ]
              │
              ├── 1. terraform init   (Downloads AWS Provider plugin)
              ├── 2. terraform plan   (Previews execution plan)
              └── 3. terraform apply  (Provisions cloud resources)
              │
              ▼
[ AWS Cloud (us-east-1) ]
              └── Amazon S3 Bucket ("johann-s3-pipeline-website-2026")
            
Tech Stack & Tools
Cloud Provider: AWS (Amazon S3, IAM)

Infrastructure as Code (IaC): Terraform (HCL v1.8+)

CI/CD Automation: GitHub Actions (YAML)

Version Control: Git & GitHub

Key Features & Security Architecture
Declarative Provisioning: Infrastructure state defined purely through HashiCorp Configuration Language (main.tf).

Automated Pipeline: Deployment pipeline automatically triggered upon code push to the main branch (deploy.yml).

Secure Credential Management: Zero hardcoded secrets in source code. AWS access keys are encrypted using GitHub Secrets and injected dynamically into the ephemeral runner environment.

Repository Hygiene & Data Protection (.gitignore):

Excluded .terraform/ directory to prevent uploading platform-specific binaries (~685 MB) and exceeding GitHub file size limits.

Excluded *.tfstate and *.tfstate.backup files to mitigate sensitive credential exposure and state file corruption.

Repository Structure
.
├── .github/
│   └── workflows/
│       └── deploy.yml      # GitHub Actions CI/CD pipeline configuration
├── .gitignore              # Excludes binaries, cache, and state files
├── main.tf                 # Terraform IaC definition (AWS Provider & S3)
└── README.md               # Project documentation
CI/CD Pipeline Breakdown (deploy.yml)
Trigger: Fires automatically on push events to main.

Runner Initialization: Provisions a clean ubuntu-latest virtual machine.

Checkout: Clones the repository codebase using actions/checkout@v3.

Terraform CLI Setup: Installs Terraform using hashicorp/setup-terraform@v2.

Terraform Init: Initializes the environment and fetches the required AWS provider.

Terraform Plan: Generates an execution plan comparing configuration against existing cloud resources.

Terraform Apply: Deploys resources automatically using the -auto-approve flag.

How to Replicate

Prerequisites

An AWS Account with IAM access keys (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY).

A GitHub Account.

Deployment Steps
Clone this repository:

Bash
git clone <your-repository-url>
cd <your-repository-folder>
Configure GitHub Secrets:
In your GitHub repository, navigate to Settings ➔ Secrets and variables ➔ Actions and add:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Push changes to deploy:

Bash
git add .
git commit -m "feat: deploy infrastructure"
git push origin main
Monitor Workflow:
Check the Actions tab in your GitHub repository to watch the pipeline execute in real time.

Engineering Key Takeaways
Designed a clean Git workflow enforcing sensitive data isolation (.gitignore).

Implemented secure authentication patterns for CI/CD runners using encrypted environment variables.

Demonstrated foundational IaC lifecycle management (init, plan, apply) within automated pipelines.

