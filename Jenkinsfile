pipeline{
    agent any
    environment {
        PATH = "$PATH:/opt/apache-maven-4.0.0-alpha-7/bin"
    }
    stages{
       stage('GetCode'){
            steps{
                // git 'https://github.com/akshyaganesh/hello-world.git'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/akshyaganesh/spring-demo.git']])
            }
         } 

       
        stage('SonarQube analysis') {
            //    def scannerHome = tool 'SonarScanner 4.0';
            steps{

                withSonarQubeEnv('sonarqube-scanner') { 
                //withSonarQubeEnv(credentialsId: 'sonar-token1') {
                // If you have configured more than one global server connection, you can specify its name
                //      sh "${scannerHome}/bin/sonar-scanner"
                sh 'mvn clean package sonar:sonar'
                }
            }
         }
       /*
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
        
        stage('Push image to Hub'){
            steps{
                script{
                   //withCredentials([string(credentialsId: 'm5muthu1975', variable: 'dockerhubpwd')]) 
                   //sh 'docker login -u akshyaganesh -p ${dockerhubpwd}'
                   sh 'docker login -u akshyaganesh -p m5muthu1975'

                    }
                   //sh 'docker push akshyaganesh/hello-world'
                    //sh 'docker push hello-world'
                    sh 'docker tag akshyaganesh/helloworld:latest docker.io/akshyaganesh/hello-world:latest'
                    sh 'docker push docker.io/akshyaganesh/hello-world:latest'
                }
                
            }
            */
            
         }
       
    }

