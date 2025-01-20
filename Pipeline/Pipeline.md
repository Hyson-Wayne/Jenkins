# **Jenkins Pipeline Project Setup**

This guide provides a comprehensive step-by-step setup for a Jenkins pipeline project with GitHub integration, Maven, SonarQube, and Nexus. 

---

## **<span style="color:green">Contact Information</span>**

For further assistance or inquiries, click the buttons below:

- [![Name](https://img.shields.io/badge/Name-Nditafon%20Hyson%20Nuigho-brightgreen)](mailto:nditafonhysonn@gmail.com)
- [![Phone](https://img.shields.io/badge/Phone-%2B237679638540-brightgreen)](tel:+237679638540)
- [![Email](https://img.shields.io/badge/Email-nditafonhysonn%40gmail.com-blue)](mailto:nditafonhysonn@gmail.com)
- [![GitHub](https://img.shields.io/badge/GitHub-Hyson--Wayne-lightgrey?logo=github)](https://github.com/Hyson-Wayne)
- [![LinkedIn](https://img.shields.io/badge/LinkedIn-nditafon--hyson-blue?logo=linkedin)](https://www.linkedin.com/in/nditafon-hyson-762a6623b/)

---

## **Prerequisites**

Ensure that all the necessary servers are set up and running:

- Jenkins Server
- SonarQube Server
- Nexus Repository Server
- Tomcat Server

---

## **Pipeline: Stage View Plugin**

Install the `Pipeline: Stage View Plugin` in Jenkins for visualizing pipeline stages effectively.

---

## **Fork the Repository**

Ensure you have the GitHub project available or fork my repository:

- [Web App Repository](https://github.com/Hyson-Wayne/webapp)

---

## **Jenkins-GitHub Integration**

1. **Add GitHub Project URL:**
   - Navigate to your pipeline job configuration.
   - Scroll down to the **Source Code Management** section.
   - Select **Git** and provide the repository URL (e.g., `https://github.com/YourUsername/maven-web-application`).

2. **Create New Credentials:**
   - Click on the **Add** button next to the Credentials dropdown, then select **Jenkins**.
   - Choose **Username with password** as the kind.
   - Enter your GitHub username in the **Username** field.
   - Use a GitHub personal access token as the password.

3. **Generate a Personal Access Token:**
   - Log in to your GitHub account.
   - Go to **Settings > Developer Settings > Personal Access Tokens**.
   - Click **Generate new token**, provide a note (e.g., "Jenkins integration"), select the necessary scopes (`repo`), and generate the token.
   - Copy the token and paste it into the **Password** field in Jenkins.

4. **Select the Credentials:**
   - In the Jenkins configuration, choose the credentials you just created from the dropdown.
   - Save the configuration.

---

## **Maven-Jenkins Integration**

1. **Configure Maven in Jenkins:**
   - Go to **Manage Jenkins > Global Tool Configuration**.
   - Under **Maven**, click **Add Maven**.
   - Name the installation (e.g., `maven3.9.9`) and provide the Maven home directory if needed.

2. **Configure Maven Project:**
   - In the pipeline job configuration, add a build step: **Invoke top-level Maven targets**.
   - Set the goal to `clean package`.
   - Save the configuration.

3. **Verify Build Output:**
   - Click **Build Now** and ensure the artifacts are generated in the target directory within the workspace.

---

## **Jenkins-SonarQube Integration**

1. **Start SonarQube Server:**
   ```bash
   sudo su - sonar
   sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start
   sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status
   ```

2. **Configure Project for SonarQube:**
   - Update the `pom.xml` in your GitHub repository to include SonarQube server credentials and IP address.
   - Save and commit the changes.

---

## **Jenkins-Nexus Integration**

1. **Configure Nexus Repository:**
   - Copy the repository details from the Nexus UI.
   - Update the `distributionManagement` section in the `pom.xml` file.

2. **Configure Jenkins for Nexus:**
   - Edit the `settings.xml` file in the Jenkins server:
     ```bash
     vi /var/lib/jenkins/tools/hudson.tasks.Maven_MavenInstallation/maven3.9.9/conf/settings.xml
     ```
   - Add Nexus server credentials:
     ```xml
     <server>
       <id>nexus</id>
       <username>admin</username>
       <password>admin123</password>
     </server>
     ```

---

## **Jenkins Pipeline Script**

In the pipeline project, navigate to **Pipeline** and add the following script:

```groovy
node {
    // Step 1: Define Maven tool version
    def mavenHome = tool name: 'maven3.9.9'
 
    stage('1 Clone Code') {
        // Clone the source code
        git branch: 'main', url: 'https://github.com/Hyson-Wayne/webapp'
    }
 
    stage('2 Test & Build') {
        // Build the project
        sh "${mavenHome}/bin/mvn clean package"
    }
 
    stage('3 Code Quality') {
        // Perform code quality analysis with SonarQube
        sh "${mavenHome}/bin/mvn sonar:sonar"
    }
 
    stage('4 Upload Artifacts') {
        // Upload artifacts to Nexus
        sh "${mavenHome}/bin/mvn deploy"
    }
 
    stage('5 Deploy to UAT') {
        // Deploy to UAT environment
        sh "echo 'Deploy to UAT'"
        // Use Jenkins Pipeline Syntax to generate the deployment script for Tomcat
    }
 
    stage('6 Approval Gate') {
        // Manual approval step
        sh "echo 'Ready for review'"
        timeout(time: 6, unit: 'HOURS') {
            input message: 'Application ready for deployment, please review and approve'
        }
    }
 
    stage('7 Deploy to Prod') {
        // Deploy to Production environment
        sh "echo 'Deploy to Production'"
        // Use Jenkins Pipeline Syntax to generate the deployment script for Tomcat
    }
 
    stage('8 Email Notification') {
        // Send email notifications
        sh "echo 'Sending Email Notifications'"
    }
}
```

### **Note:**
For stages 5 and 7 (UAT and Production deployment), generate the deployment script using **Pipeline Syntax Generator** in Jenkins:

1. Navigate to **Pipeline Syntax**.
2. Choose **Deploy WAR/EAR to a container**.
3. Fill in the fields:
   - **WAR/EAR files:** Specify files in the `target/` directory (e.g., `target/*.war`).
   - **Credentials:** Select or add Tomcat credentials.
   - **Tomcat URL:** Enter the Tomcat server URL (e.g., `http://your-server:8080/manager/text`).
4. Click **Generate Pipeline Script** and copy the script into the appropriate stage.
