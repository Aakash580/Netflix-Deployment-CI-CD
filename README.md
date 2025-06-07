# 🎬 Netflix Clone – DevSecOps Deployment 🚀

A professional-grade Netflix clone built with HTML, CSS, and JavaScript, fully containerized and deployed using modern **DevSecOps principles**.

---

## 🛠️ Tech Stack

| Area         | Tools/Technologies                            |
|--------------|-----------------------------------------------|
| CI/CD        | Jenkins, ArgoCD                               |
| Security     | OWASP Dependency-Check, Trivy, SonarQube      |
| Container    | Docker                                        |
| Debugging    | Bash, Shell logs, Static analysis             |
----------------------------------------------------------------


---

## 🚧 Features

- 🔁 CI/CD pipeline via **Jenkins**
- 🔐 Integrated **OWASP Dependency Check** & **Trivy** vulnerability scan
- 🧹 Static analysis using **SonarQube**

-![Screenshot 2025-06-07 210231](https://github.com/user-attachments/assets/cc74a4a3-9204-4458-b340-afb04b17f3ae)



- 🐳 Docker containerization

-![image](https://github.com/user-attachments/assets/fec27c2c-7bce-4838-b68e-61f500a6cd2d)
 

- 🚀 GitOps-style deployment with **ArgoCD** to Kubernetes
- 🧑‍🔧 Manual **debugging and linting fixes** applied for clean, secure code

---

## 🔁 CI/CD Pipeline (Jenkins)

### Stages:
1. **Checkout Code** from GitHub
2. **Static Code Analysis** with SonarQube
3. **Security Scans** using:
   - OWASP Dependency Check
   - Trivy (for Docker image)
4. **Build Docker Image**
5. **Push to Docker Hub**
6. **K8s Deployment** via ArgoCD

### Sample `Jenkinsfile`:
```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps { git 'https://github.com/youruser/netflix-clone.git' }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'sonar-scanner'
                }
            }
        }
        stage('OWASP Dependency Check') {
            steps { sh './dependency-check.sh' }
        }
        stage('Trivy Scan') {
            steps { sh 'trivy image youruser/netflix-clone:latest' }
        }
        stage('Docker Build & Push') {
            steps {
                sh 'docker build -t youruser/netflix-clone:latest .'
                sh 'docker push youruser/netflix-clone:latest'
            }
        }
        stage('Trigger ArgoCD') {
            steps {
                sh 'curl -X POST https://argocd-api-url/applications/netflix-clone/sync'
            }
        }
    }
}
```
![Screenshot 2025-06-07 210242](https://github.com/user-attachments/assets/c151d151-3029-4879-940d-498cfed60f9e)

