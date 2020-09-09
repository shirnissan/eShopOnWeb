pipeline {
  environment {
    registry = "shirnissan/eshoponweb"
    registryCredential = 'docker-creds'
  }
	agent any
   stages {
	 stage('Login to docker hub') {
       	  steps {
		sh "docker login --username=${env.DOCKERHUB_USER_NAME} --password=${env.DOCKERHUB_PASSWORD}"	
	 }
      }  
      stage('Docker-compose build') {
         steps {
            sh "docker-compose up -d --build"
         }
      }
      stage('Docker push') {
         steps {
           sh "docker push  shirnissan/eshoponweb:${BUILD_NUMBER}"
         }
      }
      stage('Docker run') {
         steps {
           sh " docker run -d -p 8080:80 shirnissan/eshoponweb:${BUILD_NUMBER}"
         }
      }
   } 
	    post {
        always {
            cleanWs deleteDirs: true, notFailBuild: true
        }
    }

}
