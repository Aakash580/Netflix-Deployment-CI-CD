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

    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages {
        stage ("clean workspace") {
            steps {
                cleanWs()
            }
        }
        stage ("Git checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/Aakash580/Netflix-Deployment-CI-CD.git'
            }
        }
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Netflix \
                    -Dsonar.projectKey=Netflix '''
                }
            }
        }
        stage("quality gate"){
           steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token' 
                }
            } 
        }
        stage ("Trivy File Scan") {
            steps {
                sh "trivy fs . > trivy.txt"
            }
        }
        stage ("Build Docker Image") {
            steps {
                sh "docker build -t netflix ."
            }
        }
        stage ("Tag & Push to DockerHub") {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'Docker') {
                        sh "docker tag netflix aakashbendre580/netflix:latest"
                        sh "docker push aakashbendre580/netflix:latest "
                    }
                }
            }
        }
        stage('Docker Scout Image') {
            steps {
                script{
                   withDockerRegistry(credentialsId: 'Docker', toolName: 'Docker'){
                       sh 'docker-scout quickview aakashbendre580/netflix:latest'
                       sh 'docker-scout cves aakashbendre580/netflix:latest'
                       sh 'docker-scout recommendations aakashbendre580/netflix:latest'
                   }
                }
            }
        }
        stage ("Deploy to Conatiner") {
            steps {
                sh 'docker run -d  -p 3000:3000 aakashbendre580/netflix:latest'
            }
        }
    }
    post {
    always {
        emailext attachLog: true,
            subject: "'${currentBuild.result}'",
            body: """
                <html>
                <body>
                    <div style="background-color: #FFA07A; padding: 10px; margin-bottom: 10px;">
                        <p style="color: white; font-weight: bold;">Project: ${env.JOB_NAME}</p>
                    </div>
                    <div style="background-color: #90EE90; padding: 10px; margin-bottom: 10px;">
                        <p style="color: white; font-weight: bold;">Build Number: ${env.BUILD_NUMBER}</p>
                    </div>
                    <div style="background-color: #87CEEB; padding: 10px; margin-bottom: 10px;">
                        <p style="color: white; font-weight: bold;">URL: ${env.BUILD_URL}</p>
                    </div>
                </body>
                </html>
            """,
            to: 'provide_your_Email_id_here',
            mimeType: 'text/html',
            attachmentsPattern: 'trivy.txt'
        }
    }
}
```
![image](https://github.com/user-attachments/assets/0c4a44bf-160e-47ca-806b-c851b4e899cc)

![Screenshot 2025-06-07 210242](https://github.com/user-attachments/assets/c151d151-3029-4879-940d-498cfed60f9e)

