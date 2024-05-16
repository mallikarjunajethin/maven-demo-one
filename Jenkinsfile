pipeline {
  agent any
  stages {
    stage('Checkout') {
       steps {
        sh 'echo passed'
        git branch: 'main', url: 'https://github.com/mallikarjunajethin/maven-demo-one.git'
      }
    }
    //stage('Build Maven Project') {
    //    steps {
    //            sh 'mvn clean package'
    //        }
    //}
    //stage('Upload to Artifactory') {
    //	environment {
    //    ARTIFACTORY_URL = 'https://mallikarjunajethin.jfrog.io/artifactory/'
    //    REPOSITORY = 'mallikarjunajethin'
    // }
//		steps {
  //              script {
    //                withCredentials([usernamePassword(credentialsId: 'jfrog-hub-login', usernameVariable: 'ARTIFACTORY_USERNAME', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
      //                  // Use the injected credentials in your JFrog CLI command
       //                 sh "jf rt u --url ${env.ARTIFACTORY_URL} --user ${env.ARTIFACTORY_USERNAME} --password ${env.ARTIFACTORY_PASSWORD} target/*.jar ${env.REPOSITORY}/"
       //             }
      //          }
//	    }
//	}

    stage('Build Docker Image') {
            steps {
                script {
                    docker.build("maven-demo-docker:${BUILD_NUMBER}")
                }
            }
    }


    stage('Push Docker Image') {
            environment {
			DOCKER_REGISTRY = 'https://mallikarjunajethin.jfrog.io/'
			IMAGE_NAME = 'maven-demo-docker'
			CREDENTIAL_ID = 'docker-hub-login'
		        DOCKER_IMAGE_TAG = "${env.IMAGE_NAME}:${env.BUILD_NUMBER}"
               }
            steps {
                script {
                    // Login to the Docker registry using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-login', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        docker.withRegistry("${env.DOCKER_REGISTRY}", "${env.DOCKER_USERNAME}", "${env.DOCKER_PASSWORD}") {
                            // Push the Docker image to the registry
                            docker.image("${env.IMAGE_NAME}:${BUILD_NUMBER}").push()
                        }
                    }
                }
                }
	     } 
   }
}
