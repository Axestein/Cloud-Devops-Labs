# VLE 02 — Git, GitHub & CI/CD Pipelines

**Author:** Aditya Kumar Singh 

This lab covers building a full CI/CD workflow for a web app: setting up Git version control, configuring a GitHub Actions CI pipeline, integrating ChatOps notifications (Slack), and setting up continuous deployment to a static hosting platform (Vercel).

## Objective
- Set up a Git/GitHub workflow for a simple web app
- Build a CI pipeline using GitHub Actions (checkout, build, validate, log output)
- Integrate ChatOps notifications (Slack) into the pipeline via incoming webhooks
- Configure continuous deployment (CD) to a static hosting provider (Netlify/Vercel)

## 🛠️ Procedure

### Phase 1: Development Setup
- Created a GitHub repository named **devops-webapp**
- Cloned it to the local system:
  ```bash
  git clone https://github.com/Axestein/devops-webapp.git
  ```
- Added a simple HTML/CSS web app (`index.html`, `style.css`)

### Phase 2: Version Control Workflow
```bash
git init
git add .
git commit -m "Initial commit: Add HTML/CSS webapp"
git push
```
- Verified the pushed code appeared correctly in the GitHub repository (`main` branch)

### Phase 3: CI Pipeline Configuration (GitHub Actions)
Created `.github/workflows/ci.yml`, configured to:
- Trigger on `push` and `pull_request` to `main`
- Run on `ubuntu-latest`
- **Checkout code** (`actions/checkout@v3`)
- **Display build start** message with a timestamp
- **List project files** (`ls -la`)
- **Validate HTML** — check `index.html` exists and contains expected content (`grep -q "DevOps"`), logging a pass/warning message accordingly
- Verified successful workflow runs in the **Actions** tab, including an uploaded build artifact (`webapp-build`)

### Phase 4: ChatOps Integration (Slack + GitHub Actions)
- Created a Slack app (**DevOps CI-CD Bot**) and enabled **Incoming Webhooks**
- Generated a webhook URL for the `#ci-cd-alerts`-style notification channel
- Added the webhook URL as a GitHub Actions secret (`SLACK_WEBHOOK_URL`)
- Modified the pipeline to send **success/failure notifications** to Slack on each run

### Phase 5: CD for Static Deployment
- Logged in to **Vercel**, imported the `devops-webapp` GitHub repository
- Enabled **auto-deploy on commit** (deploys automatically from the `main` branch)
- Verified build logs, deployment previews, and the final production URL:
  🔗 **https://devops-webapp-six.vercel.app/**

## Contents of this Directory
| File / Folder | Description |
|---|---|
| `VLE-02-Git-GitHub-CI-CD.pdf` | Completed lab report covering Phases 1–5 (Git setup → CI → ChatOps → CD) |
| `Github-Actions-Practice.pdf` | Practice-6 companion report — CI/CD pipeline + ChatOps + static deployment walkthrough |
| `project-practice/` | The practice web app project used by the GitHub Actions CI workflow (build/test target) |
| `project/` | The actual web app project used by the GitHub Actions CI workflow (build/test target)+ Slack webhook connection |

| `README.md` | This file |

## 🎯 Outcome
Built an end-to-end CI/CD pipeline for a static web app: version-controlled the code in GitHub, automated build/validation checks with GitHub Actions on every push, wired up Slack notifications for pipeline status, and enabled continuous deployment to Vercel with a live production URL.