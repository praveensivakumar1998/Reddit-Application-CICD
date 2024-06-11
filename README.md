# Reddit-Application-CICD
In this End-to-End DevSecOps project, we successfully deployed a Reddit App leveraging Jenkins for Continuous Integration/Continuous Deployment (CI/CD) pipelines, seamlessly integrated with Amazon EKS (Elastic Kubernetes Service), and managed deployment through Argo CD, ensuring a secure, scalable, and automated infrastructure.

> Clone this Repository : https://github.com/praveensivakumar1998/Reddit-Application-CICD.git

  
![Reddit-Application-Final](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/2accc236-9c58-4b69-ab57-e4539295c9d2)



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
sudo apt install openjdk-17-jre -y
```
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
### Run Sonarqube as container in ubuntu machine
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
### Install Trivy for Image scan  in ubuntu machine
```
wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.deb
sudo dpkg -i trivy_0.18.3_Linux-64bit.deb
```
## Step 5:
### Add the neccessary Credentials in Jenkins console 
  * Sonar as **sonar**
  * Docker as **docker-cred**
  * Github as **github**
    
    Dashboard > Manage Jenkins > Credentials
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/863f74a8-67c7-44fd-a14b-87c03ae95434)

## Step 6:  
### Install and configure neccessary Plugins in jenkins console
  * Docker plugin
  * Docker pipeline
  * Sonarqube scanner
  * OWASP Dependency-Check Plugin
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

## Step 7:
 * Create the seperate Kubernetes manifest repository for Deployment yaml update
 * update the github manifest url in Jenkins File

## Step 8:
### Create and Build the application
  * Create Pipeline job in a Jenkins Dashboard and update your JenkinsFile in a Pipeline
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/73cefee3-0ecf-4179-accb-dd8c11edbb95)

  * Build the Reddit application
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/d2fc1eaf-3ea9-46e4-bc3b-d5114a1a37a5)

# Now the Continous Integration CI process is build successfully 
   -  Sonarqube Code Vulnerability Check - Passed :tada:
   -  Quality Gate - Passed :tada:
   -  Npm Installation - Passed :tada:
   -  Owasp Dependency Check - Report Created :tada:
   -  DockerHub Image Build and Push - Passed :tada:
   -  Trivy Image Scan - Completed :tada:
   -  Github commit for updated image in Deployment.yaml manifest - Passed :tada:
### Check the below screenshots for post CI process
 ***Sonarqube Code Analysis***
 
 ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/d9d72a2e-4f43-44d9-b062-c81dcb5a60ce)
 
 ***Owasp Dependency Check***
 
 ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/1ab032c2-38d9-4530-91cf-78ad33ebaa36)

 ***Trivy Image Scan Report***
 
 ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/d57f6f5e-9140-4230-a9da-fc41939cc3f0)
--

*also validate the **Github manifest repository***
# Deploy the Reddit applicaition in EKS 
## Step 9:
### Install neccesary Command Line for EKS 

***Command Line tools we used for EKS Deployments***

  1.  AWS Cli (Control AWS Services)
  2.  Kubectl (Control Kubernetes cluster, pods and objects)
  3.  eksctl (Control EKS services)

   ```
    sudo apt update
    sudo apt install zip -y
   ```
  1. **Install CLI**
     https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
     ```
     curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
     unzip awscliv2.zip
     sudo ./aws/install
     ```
  2. **Install Kubectl**
     https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
     ```
     curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
     sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
     chmod +x kubectl
     mkdir -p ~/.local/bin
     mv ./kubectl ~/.local/bin/kubectl
     ```
  3. **Install eksctl**
     https://eksctl.io/installation/
     ```
     ARCH=amd64
     PLATFORM=$(uname -s)_$ARCH

     curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
     curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
     tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
     sudo mv /tmp/eksctl /usr/local/bin 
     ```
## Step 10:
### Create a EKS Cluster and Nodegroups:

a, **Cluster creation**
    
    
      eksctl create cluster --name=reddit-app \
                            --region=ap-south-1 \
                            --zones=ap-south-1a,ap-south-1b \
                            --without-nodegroup 
    

The command mentioned above generates a CloudFormation template for creating an EKS cluster, which typically takes approximately 15-20 minutes to complete the  cluster creation process.

**Note** - In AWS, we opt for a fully managed EKS service where we do not need to handle the EKS master nodes or their associated components (API server, scheduler, etcd, cloud controller). These elements are fully managed by AWS.

***Validate the Cluster***
```
eksctl get cluster
```
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/98c3771b-60e1-40a6-bab6-a710e6be5853)

  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/ffd8c485-557d-491e-9be6-9bb3751ebe5c)

b, **NodeGroup Creation**

   
    eksctl create nodegroup --cluster=reddit-app \
                       --region=ap-south-1 \
                       --name=reddit-app-public-nodegroup \
                       --node-type=t3.medium \
                       --nodes=2 \
                       --nodes-min=2 \
                       --nodes-max=4 \
                       --node-volume-size=20 \
                       --ssh-access \
                       --ssh-public-key=my-test-keypair-mumbai \
                       --managed \
                       --asg-access \
                       --external-dns-access \
                       --full-ecr-access \
                       --appmesh-access \
                       --alb-ingress-access 
                       
***Validate the NodeGroup***
```
eksctl get nodegroup --cluster reddit-app --region ap-south-1
```
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/1dac5791-0b2a-40bd-833a-01e84582871c)

---
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/6b4a8675-c6b8-4fff-a6b5-5942040c655c)

---
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/3eb4ce9b-0a12-47b6-9425-8ef047715a13)

## Step 11:
  
### Install and Configure ArgoCD  :

***Install ArgoCD Operators***
    In Kubernetes, operators are custom controllers that automate the management of complex applications and services. They extend Kubernetes' capabilities to handle tasks beyond basic orchestration, ensuring more efficient and automated operations.

  ```
   curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.28.0/install.sh | bash -s v0.28.0

   kubectl create -f https://operatorhub.io/install/argocd-operator.yaml

   kubectl get csv -n operators
  ```

***Install ArgoCD***
  ```
  kubectl create namespace argocd
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
  ```
***validate the pods and service***

  ```
  kubectl get pods -n argocd

  kubectl get svc -n argocd
  ```
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/3d08ee2c-2ae3-483d-ae60-0a55fae9631e)
  ---
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/24301db3-a088-4b57-9263-eb72ba57a716)
  
***Change ArgoCD service type as ClusterIp to LoadBalancer***
  ```
  kubectl edit -n argocd svc argocd-server
  ```
***Get Encrypted ArgoCD Server password***
  ```
  export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`|
  echo $ARGO_PWD
  ```
  ![image](https://github.com/praveensivakumar1998/Reddit-Application-CICD/assets/108512714/eee78911-1a4d-496b-aa62-72dfd1783814)



  
 
  
