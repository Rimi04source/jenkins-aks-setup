# 🚀 Jenkins on AKS – Cloud‑Native DevOps Setup

A **production‑style Jenkins setup on Azure Kubernetes Service (AKS)** using **Helm**, designed and documented the way a **DevOps Engineer** would do it in a real organization.

This repository focuses on:

* Clean Jenkins installation on AKS
* Persistence and reliability
* Browser‑accessible Jenkins UI
* Clear documentation and reusable scripts

---

## 📌 What is Jenkins?

**Jenkins** is an open‑source automation server used primarily for **CI/CD (Continuous Integration & Continuous Deployment)**.

With Jenkins, teams can:

* Build applications automatically
* Run unit and integration tests
* Build Docker images
* Trigger deployments
* Integrate with GitHub, GitLab, Azure Repos, Docker, Kubernetes, etc.
---

## ☁️ Why Run Jenkins on AKS?

Running Jenkins on **Azure Kubernetes Service** provides:

* ✅ Automatic pod restarts
* ✅ Persistent storage using Azure Managed Disks
* ✅ Easy upgrades using Helm
* ✅ No VM‑level maintenance
* ✅ Cloud‑native, scalable architecture

### Jenkins on VM vs Jenkins on AKS

| Jenkins on VM           | Jenkins on AKS     |
| ----------------------- | ------------------ |
| Manual OS patching      | Kubernetes‑managed |
| Single point of failure | Self‑healing       |
| Hard to scale           | Easy to scale      |
| Manual backups          | Persistent volumes |

This repository intentionally demonstrates **Jenkins on AKS**, which is the preferred modern approach.

---

## 🏗️ Architecture

```
Browser (Chrome)
   |
   v
Azure Load Balancer (Public IP)
   |
   v
Jenkins Service (Kubernetes)
   |
   v
Jenkins Pod
   |
   v
Persistent Volume (Azure Managed Disk)
```
---
## ✅ Prerequisites

Ensure the following are installed and configured:

* Azure CLI (`az login` completed)
* kubectl
* Helm v3
* An existing AKS cluster

Verify cluster access:

```bash
kubectl get nodes
```

---

## ⚙️ Jenkins Installation (AKS)

### 1️⃣ Add Jenkins Helm Repository

```bash
helm repo add jenkins https://charts.jenkins.io
helm repo update
```

---

### 2️⃣ Install Jenkins

```bash
./install.sh
```

The script will:

* Create a namespace
* Install Jenkins using Helm
* Configure persistence
* Expose Jenkins via LoadBalancer

---

### 3️⃣ Access Jenkins UI

```bash
kubectl get svc -n jenkins
```

Open in browser:

```
http://<EXTERNAL-IP>:8080
```

Default credentials:

```
Username: admin
Password: admin123
```

---

## 🧹 Uninstall Jenkins

To completely remove Jenkins and all related resources:

```bash
./uninstall.sh
```

This removes:

* Jenkins Helm release
* Persistent volumes
* Jenkins namespace

---

## 💾 Persistence & Reliability

* Jenkins home directory is stored on **Azure Managed Disk**
* Jenkins survives:

  * Pod restarts
  * Node replacement
  * AKS upgrades

Jenkins will stop only if:

* The AKS cluster itself is stopped

---

## 🔐 Security Notes

This setup is intended for **learning and internal use**.

For production:

* Use Ingress + HTTPS
* Disable local admin accounts
* Integrate SSO (OIDC / Azure AD)
* Restrict network access

---
## 📸 Image
<img width="1884" height="865" alt="image" src="https://github.com/user-attachments/assets/ef002474-7604-4b1d-a352-d7cd9d5f8862" />
<img width="1916" height="836" alt="image" src="https://github.com/user-attachments/assets/7000bfa5-7b8a-47ee-8ca4-f2db3e243d90" />



