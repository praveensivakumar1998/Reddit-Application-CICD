# Reddit-Application-CICD
In this End-to-End DevSecOps project, we successfully deployed a Reddit App leveraging Jenkins for Continuous Integration/Continuous Deployment (CI/CD) pipelines, seamlessly integrated with Amazon EKS (Elastic Kubernetes Service), and managed deployment through Argo CD, ensuring a secure, scalable, and automated infrastructure.

> Clone this Repository : https://github.com/praveensivakumar1998/Reddit-Application-CICD.git

  ![reddit-application0102](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/fd56bfe0-623f-4959-8aa8-5bb6478c3a9e)



## Tools used
1. Jenkins (Continous Integration)
2. Docker (Packages the App into Containers)
3. Sonarqube (Checks code qualiity and code vulneribility)
4. Npm (Javascript Dependency package manager)
5. Owasp (Depemd)
6. Trivy (Vulnerability scanner for containers)
7. ArgoCD (Continous Delivery)
8. EKS (Run and manages the containers in Kubernetes cluster)
9. Prometheus and Grafana (Monitoring)

## Steps 1:
### Create IAM role with respective access
### Create and configure the Jenkins server.
 * Create a Ubuntu 22.0 instance in aws console with 30GB volume 
 * login as root user
 * Install neccessary dependencies 
```
sudo apt update -y
sudo apt install net-tools
sudo apt install zip -y
```
 * Install and configure Jenkins
```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```
  * Validate the Installations
```
java --version
sudo systemctl enable Jenkins
sudo systemctl status Jenkins
```
*Configure Jenkins in http://public-ip:8080/*

![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/ec579e7c-5f4f-4bd0-9495-8461bc73f343)

## Step 2:
### Install Docker in Ubuntu machine
```
sudo apt install docker.io -y

sudo usermod -aG docker Jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker 
```

## Step 3:
### Run Sonarqube container in ubuntu machine
```
docker run -d -p 9000:9000 --name sonar-server sonarqube:latest
```
*Configure Sonarqube server as http://public-ip:9000/ - username as admin and password as admin*
 
  * Generate token for Jenkins Code Analysis
    -  My Account > Security > Generate Tokens
    ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/89af9ca2-ec41-4ea5-9b4f-8310bf10b0fb)
  * Create Sonarqube webhook in Sonarqube server
    - Administrator > Configuration > Webhooks > Create
      ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/50338a6b-7bac-4029-a1fe-7e5779acc1a4)
## Step 4:
### Add the neccessary Credentials in Jenkins console 
  * Sonar as **sonar**
  * Docker as **docker-cred**
  * Github as **github**
    
    Dashboard > Manage Jenkins > Credentials
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/863f74a8-67c7-44fd-a14b-87c03ae95434)

## Step 5:  
### Install and configure neccessary Plugins in jenkins console
  * Docker plugin
  * Sonarqube scanner
  * OWASP Dependency-Check Plugin
  * Eclipse Temurin installer Plugin
  * NodeJS Plugin

### Configure above installed plugins in a Jenkins console 
***SonarQube***

 Configure the sonarqube server in Jenkins console > Manage Jenkins > System > SonarQube servers 
 
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/1f6bafa1-b35e-480d-b79a-aa072348d69f)

Configure Sonarqube Scanner in Jenkins console > Manage Jenkins > Tools > Sonarqube Scanner Installations

  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/311bfe1f-a6d5-40cb-9568-79c2107c7f6f)

***NodeJS***

Configure NodeJS in Jenkins console > Manage Jenkins > Tools > NodeJS Installations

  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/dcd9a716-827c-4712-a8e8-8d401af0b92e)

 ***Owasp Dependency Check***
 
Configure Owasp in Jenkins console > Manage Jenkins > Tools > Dependency-Check installations

  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/2c6bbd24-80de-4ebd-8bd4-175177784fb5)

## Step 6:
### Create Jenkins Pipeline job for Reddit Application

  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/e7c89eb6-58ed-4153-ae36-3f7a4f89b935)



  
