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
    stage('Static Code Analysis') {
      environment {
        SONAR_URL = "http://192.168.29.129:9000"
      }
      steps {
        withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
          sh 'mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
        }
      }
    }
    stage('Upload to Artifactory') {
    	environment {
        ARTIFACTORY_URL = 'https://mallikarjunajethin.jfrog.io/artifactory/'
        REPOSITORY = 'mallikarjunajethin'
     }
		steps {
               script {
                    withCredentials([usernamePassword(credentialsId: 'jfrog-hub-login', usernameVariable: 'ARTIFACTORY_USERNAME', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
                        // Use the injected credentials in your JFrog CLI command
                        sh "jf rt u --url ${env.ARTIFACTORY_URL} --user ${env.ARTIFACTORY_USERNAME} --password ${env.ARTIFACTORY_PASSWORD} target/*.jar ${env.REPOSITORY}/"
                    }
                }
	    }
	}

    stage('Build Docker Image') {
            steps {
                script {
                    docker.build("maven-demo-docker:${BUILD_NUMBER}")
                }
            }
    }


    stage('Push Docker Image') {
            environment {
			DOCKER_REGISTRY = 'mallikarjunajethin.jfrog.io/mallikarjunajethin-docker-local'
			IMAGE_NAME = 'maven-demo-docker'
			CREDENTIAL_ID = 'docker-hub-login'
		        DOCKER_HUB_URL= 'https://mallikarjunajethin.jfrog.io/'
               }
            steps {
                script {
                    // Login to the Docker registry using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-login', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u ${env.DOCKER_USERNAME} -p ${env.DOCKER_PASSWORD} ${env.DOCKER_HUB_URL}"

			sh "docker tag ${env.IMAGE_NAME}:${BUILD_NUMBER} ${env.DOCKER_REGISTRY}/${env.IMAGE_NAME}:${BUILD_NUMBER}"
                        // Push the Docker image to the registry
                        sh "docker push ${env.DOCKER_REGISTRY}/${env.IMAGE_NAME}:${BUILD_NUMBER}"
                        }
                    }
                }
	     } 
   }
}
