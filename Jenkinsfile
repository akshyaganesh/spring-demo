pipeline{
    agent any
    environment {
        PATH = "$PATH:/opt/apache-maven-4.0.0-alpha-7/bin"
        /*
        remoteCommands =
        """
        ls -ltr /usr/bin/;
        ls -ltr;
        scp root@192.168.1.25:/var/lib/jenkins/workspace/spring-demo/deployment.yaml .
        """
        */
        }
    stages{
      
       stage('Get Code from Git Hub'){
            steps{
                git 'https://github.com/akshyaganesh/hello-world.git'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/akshyaganesh/spring-demo.git']])
                    }  
                } 
      
        /*
        stage('SonarQube analysis') {
            //    def scannerHome = tool 'SonarScanner 4.0';
            steps{

                withSonarQubeEnv('sonarqube-scanner') { 
                //withSonarQubeEnv(credentialsId: 'sonar-token') {
                 echo 'Running Sonar Test on Code Quality...'
                sh 'mvn sonar:sonar -Dsonar.host.url=http://sonar-service:9000'  
                //sh 'mvn sonar:sonar'
                sh 'sonar-scanner'
                }
            }
         } */
        
      
       stage('Build'){
            steps{
                sh 'mvn clean package'
            }
         }
         
        stage('Build docker image'){
            steps{
                script{
                    //sh 'chmod 666 /var/run/docker.sock'
                    sh 'docker build -t hello-world .'
                }
            }
        }
        /*
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'm5muthu1975', variable: 'dockerhubpwd')]) 
                   sh 'docker login -u akshyaganesh -p ${dockerhubpwd}'
                   sh 'docker login -u akshyaganesh -p m5muthu1975'

                    }
                    sh 'docker push akshyaganesh/hello-world'
                    sh 'docker push hello-world'
                    sh 'docker tag akshyaganesh/helloworld:latest docker.io/akshyaganesh/hello-world:latest'
                    sh 'docker push docker.io/akshyaganesh/hello-world:latest'
                }
                
            }
            */
        stage('Push the Image to Nexus Repo') {
            steps {
                echo 'Storing artifact to Nexus Repository'
                nexusArtifactUploader artifacts: [
                    [artifactId: 'demo', classifier: '', file: 'target/demo-SNAPSHOT-1.war', type: 'war'
                    ]
                ], 
                    credentialsId: 'Nexus_CRED', 
                    groupId: 'com.example', 
                    nexusUrl: '192.168.1.27:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'http://192.168.1.27:8081/repository/maven-central/', 
                    version: 'SNAPSHOT-1'
            }
        }
        stage("connecting to Kubernetes Master") {
                steps{
                       
                    script {
                        sshagent(credentials : ['kubemaster-sshagent']) {
			            //sh 'ssh -tt root@192.168.1.20 $remoteCommands'
                        sh """ssh -tt root@192.168.1.20 << EOF
                        date
                        exit
                        EOF"""
                        }
                    }

                } 
            } 
        stage("Copying Deployment File into Kubernetes Master") {
                steps{
                       
                    script {
                        sshagent(credentials : ['kubemaster-sshagent']) {
                        sh """ssh -tt root@192.168.1.20 << EOF
                        scp root@192.168.1.25:/var/lib/jenkins/workspace/spring-demo/deployment.yaml .
                        exit
                        EOF"""
                        }
                    }

                } 
            } 
        stage("Creating Container in Kubernetes Cluster") {
                steps{
                       
                    script {
                        sshagent(credentials : ['kubemaster-sshagent']) {
                        sh """ssh -tt root@192.168.1.20 << EOF
                        kubectl apply -f deployment.yaml
                        exit
                        EOF"""
                        }
                    }

                } 
            }                        


           
        
       
    }
}

