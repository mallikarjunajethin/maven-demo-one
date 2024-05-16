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
    stage('Deploy to artifactory') {
            steps {
                // Deploy the Maven artifact to Artifactory
	        //sh 'mvn deploy'
                sh 'jf rt upload --url http://192.168.29.129:8082/artifactory/ --access-token ${ARTIFACTORY-ACCESS-TOKEN} target/maven-demo-one-1.0.0.jar maven-demo-one/'
            }
        }

    //stage('Build Docker Image') {
    //        steps {
    //            script {
    //                docker.build("mallikarjunajethin/maven-demo-one:${BUILD_NUMBER}")
    //            }
    //        }
    //}


    //stage('push') {
    //        steps {
    //            // Log in to Docker Hub
    //            withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
    //                sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
    //            }
    //            
    //            // Push Docker image to Docker Hub
    //            sh "docker push mallikarjunajethin/maven-demo-one:${BUILD_NUMBER}"
    //            
    //            // Log out from Docker Hub
    //            sh "docker logout"
     //       }
     //   }

    //stage('Publish to Artifactory') {
    //        steps {
    //            // Publish Maven artifacts to Artifactory using the JFrog Artifactory plugin
    //            rtMavenDeployer (
    //                id: 'f3da7459-9fb1-4b1f-a2d8-5f3f6819ff81', // ID for this Artifactory server configuration in Jenkins
    //                serverId: 'mallikarjunajethin', // Artifactory server ID configured in Jenkins
    //                deployMavenDescriptors: true,
    //                deployIvyDescriptors: false,
    //                deployArtifacts: true,
    //                artifactsPattern: '**/target/*.jar', // Pattern to match Maven artifacts
    //                resolver: 'maven-default' // ID of the resolver to use for resolving dependencies
    //            )
     //       }
    //    }
		    
    stage('datacopy') {
       steps {
        	git credentialsId: '5c3b71b1-b26d-4069-8a82-bc7abf78161d', 
                url: 'https://github.com/mallikarjunajethin/deploymnet-test.git',
                branch: 'main'
      }
    }
    stage('Update Deployment File') {
	steps {
            script{
                withCredentials([usernamePassword(credentialsId: '5c3b71b1-b26d-4069-8a82-bc7abf78161d', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh '''
                    git config user.email "mallikarjuna.jethin@gmail.com"
                    git config user.name "mallikarjunajethin"    
		    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" Deployment.yml
                    git add Deployment.yml
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://github.com/mallikarjunajethin/deploymnet-test.git HEAD:main
		    '''
		 }
	   }
	}
      }
   }
}
