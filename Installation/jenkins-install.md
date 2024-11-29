
# Jenkins Installation Guide for RedHat EC2 Instance

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
- **AWS Account**: Ensure you have an active account.
- **RedHat EC2 Instance**: Use a `t2.medium` instance with **4GB RAM**.
- **Security Group**: Ensure your EC2 instance's security group allows traffic on **port 8080**.
- **Java OpenJDK 17**: Java is required to run Jenkins.

---

## **Step 1: Set Timezone and Hostname**

```bash
# Set timezone to America/New_York
sudo timedatectl set-timezone America/New_York

# Set hostname to 'jenkins'
sudo hostnamectl set-hostname jenkins
```

---

## **Step 2: Install Required Packages**

```bash
# Install necessary tools
sudo yum install wget tree vim git nano unzip -y
```

---

## **Step 3: Add Jenkins Repository**

```bash
# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import Jenkins GPG key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Upgrade system packages
sudo yum upgrade -y
```

---

## **Step 4: Install Java and Jenkins**

```bash
# Install Java OpenJDK 17
sudo yum install fontconfig java-17-openjdk -y

# Install Jenkins
sudo yum install jenkins -y
```

---

## **Step 5: Enable and Start Jenkins**

```bash
# Reload systemd configuration
sudo systemctl daemon-reload

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Check Jenkins service status
sudo systemctl status jenkins
```

---

## **Step 6: Access Jenkins**

1. Open your web browser.
2. Navigate to **http://<YOUR_EC2_PUBLIC_IP>:8080**.
3. Run the following command to retrieve the Jenkins administrative password:

    ```bash
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```

4. Copy the password and paste it into the Jenkins setup page.
5. On the **Customize Jenkins** screen, select **Install Suggested Plugins**.
6. Complete the setup by filling in the required fields:
    - Username
    - Password
    - Confirm Password
    - Full Name
    - Email Address
7. Save the settings and access Jenkins via the web interface.

---

## **Step 7: Secure Jenkins User**

To ensure Jenkins is secure, we manage it through a designated user called `jenkins`. Follow these steps to modify the Jenkins user's default interpreter:

1. Open the `/etc/passwd` file using a text editor:

    ```bash
    sudo vim /etc/passwd
    ```

2. Locate the line for the Jenkins user. It will look like this:

    ```
    jenkins:x:1001:1001:Jenkins,,,:/var/lib/jenkins:/bin/false
    ```

3. Change the last part (`/bin/false`) to `/bin/bash`:

    ```
    jenkins:x:1001:1001:Jenkins,,,:/var/lib/jenkins:/bin/bash
    ```

4. Save and exit the editor.`

---

## **Step 8: Grant Jenkins User Sudo Privileges**

To allow the Jenkins user to execute commands, grant it access by adding Jenkins to the sudoers group.

1. Open the sudoers file for editing:

    ```bash
    sudo vim /etc/sudoers
    ```

2. Locate the section starting with `## Same thing without a password`.

3. Add the following line to grant Jenkins sudo privileges without requiring a password:

    ```bash
    jenkins ALL=(ALL) NOPASSWD: ALL
    ```

4. Save the changes and exit the editor.

5. Switch back to the Jenkins user:

    ```bash
    sudo su - jenkins
    ```

---
