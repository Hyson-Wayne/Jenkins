
# **<span style="color:green">Jenkins Installation and Configuration Guide</span>**

---

## **<span style="color:green">Contact Information</span>**

For further assistance or inquiries, click the buttons below:

- [![Name](https://img.shields.io/badge/Name-Nditafon%20Hyson%20Nuigho-brightgreen)](mailto:nditafonhysonn@gmail.com)
- [![Phone](https://img.shields.io/badge/Phone-%2B237679638540-brightgreen)](tel:+237679638540)
- [![Email](https://img.shields.io/badge/Email-nditafonhysonn%40gmail.com-blue)](mailto:nditafonhysonn@gmail.com)
- [![GitHub](https://img.shields.io/badge/GitHub-Hyson--Wayne-lightgrey?logo=github)](https://github.com/Hyson-Wayne)
- [![LinkedIn](https://img.shields.io/badge/LinkedIn-nditafon--hyson-blue?logo=linkedin)](https://www.linkedin.com/in/nditafon-hyson-762a6623b/)

---

## **<span style="color:green">Prerequisites</span>**

- An **active AWS account**.
- A **Red Hat EC2 instance** (t2.medium) with 4GB RAM.
- **Security Group** configured to allow access (e.g., port 8080 for Jenkins).
- **OpenJDK 17** installed.

---

## **<span style="color:green">Jenkins Installation Steps</span>**

### **<span style="color:blue">Step 1: Set Timezone and Hostname</span>**
1. **Set the timezone and hostname for the Jenkins server:**
    ```bash
    sudo timedatectl set-timezone America/New_York
    sudo hostnamectl set-hostname jenkins
    ```

---

### **<span style="color:blue">Step 2: Install Required Packages</span>**
1. **Install essential packages:**
    ```bash
    sudo yum install wget tree vim git nano unzip -y
    ```

---

### **<span style="color:blue">Step 3: Add Jenkins Repository</span>**
1. **Add the Jenkins repository to your system:**
    ```bash
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade -y
    ```

---

### **<span style="color:blue">Step 4: Install Java and Jenkins</span>**
1. **Install Java and Jenkins:**
    ```bash
    sudo yum install fontconfig java-17-openjdk -y
    sudo yum install jenkins -y
    ```

---

### **<span style="color:blue">Step 5: Enable and Start Jenkins</span>**
1. **Enable and start Jenkins:**
    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo systemctl status jenkins
    ```

---

## **<span style="color:green">Post-Installation Steps</span>**

### **<span style="color:blue">Accessing Jenkins on the Web</span>**
1. **Retrieve the administrative password:**
    ```bash
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
    - Copy the password and paste it into the Jenkins web interface.

2. **Customize Jenkins:**
    - On the "Customize Jenkins" screen, select **Install Suggested Plugins**.

3. **Create Admin User:**
    - Fill in the following details:
        - Username
        - Password (and confirm it)
        - Full Name
        - Email Address
    - Click **Save** to access Jenkins on the web.

---

### **<span style="color:blue">Configure Jenkins User Shell</span>**
1. **Change the Jenkins user's default shell to `/bin/bash`:**
    ```bash
    sudo vim /etc/passwd
    ```
    - Locate the line for the Jenkins user:
        ```
        jenkins:x:1001:1001:Jenkins,,,:/var/lib/jenkins:/bin/false
        ```
    - Change `/bin/false` to `/bin/bash`:
        ```
        jenkins:x:1001:1001:Jenkins,,,:/var/lib/jenkins:/bin/bash
        ```

2. **Switch to the Jenkins user:**
    ```bash
    sudo su - jenkins
    ```

---

### **<span style="color:blue">Grant Jenkins User Sudo Privileges</span>**
1. **Edit the `sudoers` file:**
    ```bash
    sudo vim /etc/sudoers
    ```

2. **Add the following line to grant Jenkins passwordless sudo access:**
    ```
    jenkins ALL=(ALL) NOPASSWD: ALL
    ```

3. **Switch to the Jenkins user to verify:**
    ```bash
    sudo su - jenkins
    ```

---

## **<span style="color:green">Conclusion</span>**

You have successfully installed and configured Jenkins on your Red Hat EC2 instance. Follow the steps above to manage Jenkins securely and efficiently. Enjoy automating your workflows with Jenkins!
