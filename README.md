# **Jenkins Pipeline Project**

This repository provides a comprehensive guide to Jenkins, its importance in CI/CD pipelines, and detailed instructions for setting up a Jenkins pipeline integrated with tools like GitHub, Maven, SonarQube, and Nexus.

---

## **What is Jenkins?**

Jenkins is a widely-used open-source automation tool enabling developers to build, test, and deploy applications efficiently. It plays a key role in Continuous Integration and Continuous Delivery (CI/CD) pipelines, offering the following benefits:

- Automates repetitive tasks in the software development lifecycle.
- Integrates seamlessly with tools like GitHub, Maven, SonarQube, and Nexus.
- Enhances code quality through automated testing and static code analysis.
- Accelerates delivery cycles by streamlining deployments.

With its extensive plugin ecosystem, Jenkins is indispensable for modern DevOps practices, providing flexibility and scalability for diverse workflows.

---

## **Why CI/CD with Jenkins?**

CI/CD pipelines are essential for delivering high-quality software rapidly and reliably. Jenkins simplifies CI/CD processes by:

- Providing robust integration with source control systems like Git.
- Offering plugins for build tools like Maven and Gradle.
- Supporting static code analysis with SonarQube for better code quality.
- Enabling artifact management and deployment via Nexus.

By incorporating Jenkins into your workflow, you can:

- Reduce manual effort and minimize errors.
- Ensure consistent builds and deployments.
- Foster collaboration among development, testing, and operations teams.

---

## **Contact Information**

For further assistance or inquiries, click the links below:

- [![Name](https://img.shields.io/badge/Name-Nditafon%20Hyson%20Nuigho-brightgreen)](mailto:nditafonhysonn@gmail.com)
- [![Phone](https://img.shields.io/badge/Phone-%2B237679638540-brightgreen)](tel:+237679638540)
- [![Email](https://img.shields.io/badge/Email-nditafonhysonn%40gmail.com-blue)](mailto:nditafonhysonn@gmail.com)
- [![GitHub](https://img.shields.io/badge/GitHub-Hyson--Wayne-lightgrey?logo=github)](https://github.com/Hyson-Wayne)
- [![LinkedIn](https://img.shields.io/badge/LinkedIn-nditafon--hyson-blue?logo=linkedin)](https://www.linkedin.com/in/nditafon-hyson-762a6623b/)

---

## **Repository Contents**

This repository contains the following directories:

- **Installation**: Detailed steps for installing Jenkins on a RedHat EC2 instance. Includes prerequisites and commands for setting up Java, Jenkins, and securing the environment.
- **Pipeline Project Setup**: Step-by-step instructions for configuring a Jenkins pipeline integrated with GitHub, Maven, SonarQube, and Nexus. This includes pipeline scripting and configuration tips.

Refer to the respective directories for more detailed instructions.

---

## **Pipeline Script Overview**

Below is a high-level view of the Jenkins pipeline script used in this project:

```groovy
node {
    def mavenHome = tool name: 'maven3.9.9'

    stage('1 Clone Code') {
        git branch: 'main', url: 'https://github.com/Hyson-Wayne/webapp'
    }

    stage('2 Test & Build') {
        sh "${mavenHome}/bin/mvn clean package"
    }

    stage('3 Code Quality') {
        sh "${mavenHome}/bin/mvn sonar:sonar"
    }

    stage('4 Upload Artifacts') {
        sh "${mavenHome}/bin/mvn deploy"
    }

    stage('5 Deploy to UAT') {
        sh "echo 'Deploy to UAT'"
    }

    stage('6 Approval Gate') {
        input message: 'Application ready for deployment, please review and approve', 
              ok: 'Approve Deployment'
    }

    stage('7 Deploy to Prod') {
        sh "echo 'Deploy to Production'"
    }

    stage('8 Email Notification') {
        sh "echo 'Sending Email Notifications'"
    }
}
```

### **Note:**
For deployment stages (UAT and Production), use the Jenkins **Pipeline Syntax Generator** to create deployment scripts tailored to your environment. Follow these steps:

1. Navigate to **Pipeline Syntax** in Jenkins.
2. Choose **Deploy WAR/EAR to a container**.
3. Provide the required details, such as:
   - **WAR/EAR files**: Files in the `target/` directory (e.g., `target/*.war`).
   - **Credentials**: Tomcat server credentials.
   - **Tomcat URL**: URL of your Tomcat server (e.g., `http://your-server:8080/manager/text`).
4. Generate and copy the script into the corresponding stage.

---

For further details, refer to the documentation provided in the respective directories.
