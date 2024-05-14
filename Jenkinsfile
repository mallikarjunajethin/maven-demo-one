pipeline {
  agent any
  stages {
    //stage('Checkout') {
    //   steps {
    //    sh 'echo passed'
    //    git branch: 'main', url: 'https://github.com/mallikarjunajethin/maven-demo-one.git'
    //  }
   // }
    //stage('Build Maven Project') {
    //    steps {
    //            sh 'mvn clean package'
    //        }
   // }

   // stage('Build Docker Image') {
   //         steps {
   //             script {
   //                 docker.build("mallikarjunajethin/maven-demo-one:${BUILD_NUMBER}")
   //             }
    //        }
   // }


   // stage('push') {
   //         steps {
   //             // Log in to Docker Hub
    //            withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
     //               sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
    //            }
    //            
    //            // Push Docker image to Docker Hub
    //            sh "docker push mallikarjunajethin/maven-demo-one:${BUILD_NUMBER}"
     //           
    //            // Log out from Docker Hub
    //            sh "docker logout"
    //        }
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
