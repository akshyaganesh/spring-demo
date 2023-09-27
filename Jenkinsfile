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
      


        stage('SonarQube Analysis') {
           mvn clean verify sonar:sonar \
            -Dsonar.projectKey=springdemo \
            -Dsonar.projectName='springdemo' \
            -Dsonar.host.url='http://192.168.1.26:9000' \
            -Dsonar.token='squ_cd9696fc71cd308009c9b61a33fb4e0da2661273'
        }

        
      
       stage('Build'){
            steps{
                sh 'mvn clean package'
            }
         }
          /*
        stage('Build docker image'){
            steps{
                script{
                    //sh 'chmod 777 /var/run/docker.sock'
                    sh 'docker build -t hello-world .'
                }
            }
        }
       
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
                    repository: 'maven-central', 
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
              */            


           
        
       
    }
}

