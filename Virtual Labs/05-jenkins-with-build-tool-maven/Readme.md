# VLE 06 — Jenkins with Build Tool (Maven)

**Author:** Aditya Kumar Singh

## 🎯 Aim
To implement Continuous Integration using **Jenkins** and **Maven**, where source code is automatically built and tested whenever changes are pushed to a Git repository.

## 🧠 Scenario (Real-Time Use Case)
A software company wants to automatically build and test a Java application whenever developers push code to GitHub. Requirements:
- Source code should be stored in Git
- Build process should be automated
- Build tool should compile the application
- Jenkins should trigger the build automatically

**Solution Stack:**

| Requirement | Tool |
|---|---|
| Version Control | Git |
| CI/CD Tool | Jenkins |
| Build Tool | Maven |
| Programming Language | Java |
| Repository | GitHub |
| Operating System | Linux / Ubuntu |

## 🏗️ Architecture Overview
1. Developer pushes code to GitHub
2. Jenkins detects the code change (SCM polling)
3. Jenkins pulls the source code
4. Jenkins invokes Maven goals — Maven compiles & packages the application (`Java Application.jar`)
5. Jenkins reports the build outcome → **Build Success** notification to the team

**Jenkins architecture note:** the Jenkins Server hosts Jobs, Users, Plugins, Credentials, Global Configs, and Jenkins Data, and connects to agents — either **static agents** (long-running Linux/Windows nodes via SSH/WinRM, JNLP) or **dynamic agents** (ephemeral, spun up on Docker, Kubernetes Pods, EC2 instances, or AWS EKS, and destroyed after job completion).

## 🧰 Tools & Technologies
Git · GitHub · Jenkins · Maven · Java JDK · Linux / Ubuntu

## 💻 System Requirements
- OS: Ubuntu / Linux / Windows
- RAM: Minimum 4 GB
- Java JDK, Git, Maven, and Jenkins installed

## 📁 Project Directory Structure
```
jenkins-lab/
├── src/
│   └── HelloWorld.java
└── pom.xml
```

## 🛠️ Step-by-Step Implementation

### PART A — Install Required Tools
```bash
# Java
sudo apt update
sudo apt install openjdk-11-jdk -y
java -version

# Maven
sudo apt install maven -y
mvn -version

# Jenkins
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
```
Accessed Jenkins at `http://localhost:8080`, unlocked it with:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Installed the suggested plugins and confirmed the **Welcome to Jenkins!** dashboard (Build Queue, Build Executor Status).

### PART B — Create Sample Java Application
```bash
mkdir jenkins-lab && cd jenkins-lab && mkdir src
nano src/HelloWorld.java
```
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello from Jenkins CI Pipeline!");
    }
}
```

### PART C — Create Maven Build File
`pom.xml`:
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.devops</groupId>
    <artifactId>jenkins-lab</artifactId>
    <version>1.0</version>
    <build>
        <sourceDirectory>src</sourceDirectory>
        <plugins>
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
            </plugin>
        </plugins>
    </build>
</project>
```

### PART D — Push Code to GitHub
```bash
git init
git add .
git commit -m "Initial Jenkins Maven Project"
git remote add origin <repo-url>
git push origin main
```
Repository created: `jenkins-lab` (public, `main` branch) containing `src/`, `.gitignore`, and `pom.xml`.

### PART E — Configure Jenkins Job
1. Jenkins Dashboard → **New Item**
2. Named the job `jenkins-maven-build`, selected **Freestyle Project**
3. **Source Code Management** → Git → repository URL `https://github.com/<username>/jenkins-lab.git`, branch `*/main`
4. **Build** section → **Invoke top-level Maven targets** → Goals: `clean package`

### PART F — Build the Project
Clicked **Build Now** — Jenkins pulled the source, ran the Maven build, and compiled the Java application.

**Build #1** (Sep 22, 2026, 3:52:47 PM) — completed successfully in 35 sec, Git revision `a5b3ccc`, no changes on first run.
**Build #2** — a subsequent successful build, 13 sec ago at the time of the report.

Job page (`jenkins-maven-build`) confirmed both builds green, with permalinks for **Last build**, **Last stable build**, **Last successful build**, and **Last completed build** all pointing to **#2**.

Console output confirmed:
```
BUILD SUCCESS
```

## 📋 Observations
- Jenkins successfully integrated with GitHub
- Maven automatically compiled the Java project
- Jenkins dashboard shows build status (success/failure, history, permalinks)

## ✅ Result
The Continuous Integration pipeline was successfully implemented using Jenkins and Maven, where Jenkins automatically builds the application whenever the source code is updated.

## 🎤 Viva Voce Question Bank
- **Basic:** What is Jenkins? What is Continuous Integration? What is Maven? What is a build tool? What is `pom.xml`?
- **Intermediate:** CI vs. CD, Jenkins plugins, Jenkins pipelines, Jenkins workspace, freestyle job vs. pipeline job
- **Advanced:** How Jenkins triggers builds automatically, Jenkins webhooks, Maven dependency management, Maven artifact generation, Jenkins pipeline stages

See `VLE_6.pdf` for the full question list.

## 📂 Contents of this Directory
| File | Description |
|---|---|
| `VLE6_0916.pdf` | Completed lab report — Jenkins install, GitHub repo, Maven build config, and successful build runs |
| `VLE-6.pdf` | Reference lab sheet — aim, scenario, architecture, and full step-by-step procedure with viva questions |
| `README.md` | This file |