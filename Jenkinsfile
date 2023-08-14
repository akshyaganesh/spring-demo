pipeline{
    agent any
    environment {
        PATH = "$PATH:/opt/apache-maven-4.0.0-alpha-7/bin"
        
        }
    stages{
      
       stage('GetCode'){
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
         }
         stage('Nexus packaging') {
            steps {
                echo 'Storing artifact (nexus3)...'
                sh 'mvn clean package -Dmaven.test.skip=true deploy:deploy-file -DgroupId=tn.esprit.spring -DartifactId=timesheet-devops -Dversion=1.0 -DgeneratePom=true -Dpackaging=jar  -DrepositoryId=sonartypeNexusRepo -Durl=http://nexus-service:8081/repository/maven-releases/ -Dfile=target/timesheet-devops-1.0.jar'
            }
      */
       stage('Build'){
            steps{
                sh 'mvn clean package'
            }
         }
         
        stage('Build docker image'){
            steps{
                script{
                    sh 'chmod 666 /var/run/docker.sock'
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
        stage("SSH Into k8s Server") {
                steps{
                         withCredentials([usernamePassword(credentialsId: 'kubemaster1', passwordVariable: 'redhat', usernameVariable: 'root')]) {
                        sh 'ssh root@192.168.1.20 uptime'
                        }
                    } 
                } 
         /*               
        stage('Put k8s-spring-boot-deployment.yaml onto k8smaster') {

            sshPut remote: remote, from: 'deployment.yaml', into: '.'
            }
        stage('Deploy spring boot') {
            sshCommand (remote: remote, command: "kubectl apply -f deployment.yaml")
            }
         */   

           
        
       
    }
}

