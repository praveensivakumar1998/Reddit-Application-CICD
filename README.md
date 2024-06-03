# Reddit-Application-CICD
In this End-to-End DevSecOps project, we successfully deployed a Reddit App leveraging Jenkins for Continuous Integration/Continuous Deployment (CI/CD) pipelines, seamlessly integrated with Amazon EKS (Elastic Kubernetes Service), and managed deployment through Argo CD, ensuring a secure, scalable, and automated infrastructure.

> Clone this Repository : https://github.com/praveensivakumar1998/Reddit-Application-CICD.git

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

### Create and configure the Jenkins server.
 * Create a Ubuntu 22.0 instance in aws console
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
