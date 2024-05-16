pipeline {
  agent any
  stages {
    stage('Checkout') {
       steps {
        sh 'echo passed'
        git branch: 'main', url: 'https://github.com/mallikarjunajethin/maven-demo-one.git'
      }
    }
    stage('Build Maven Project') {
        steps {
                sh 'mvn clean package'
            }
    }
    stage('Upload to Artifactory') {
	environment {
        ARTIFACTORY_URL = 'http://192.168.29.129:8082/artifactory/'
        REPOSITORY = 'maven-demo-one'
    }
		steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'jfrog-id-login', usernameVariable: 'ARTIFACTORY_USERNAME', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
                        // Use the injected credentials in your JFrog CLI command
                        sh "jf rt u --url ${env.ARTIFACTORY_URL} --user ${env.ARTIFACTORY_USERNAME} --password ${env.ARTIFACTORY_PASSWORD} target/*.jar ${env.REPOSITORY}/"
                    }
                }
	    }
	}

    stage('Build Docker Image') {
            steps {
                script {
                    docker.build("maven-demo-one:${BUILD_NUMBER}")
                }
            }
    }


    stage('push') {
            steps {
                // Log in to Docker Hub
                withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    sh "docker login http://192.168.29.129:8082/artifactory/maven-demo-one-docker -u ${env.DOCKER_HUB_USERNAME} -p ${env.DOCKER_HUB_PASSWORD}"
                }
                
                // Push Docker image to Docker Hub
                sh "docker push http://192.168.29.129:8082/artifactory/maven-demo-one-docker/maven-demo-one:${BUILD_NUMBER}"
                
                // Log out from Docker Hub
                sh "docker logout"
           }
        }	    
    
   }
}
