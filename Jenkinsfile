pipeline {
  environment {
    registry = "shirnissan/eshoponweb"
    registryCredential = 'docker-creds'
  }
	agent any
   stages {
	         stage('folder check') {
         steps {
            sh "pwd"
	    sh "ls"
         }
      }
	stage('Docker ps') {
          steps {
            sh "docker ps"
         }
      }
      stage('Docker-compose build') {
         steps {
            sh "docker-compose up -d --build"
         }
      }
      stage("Docker build") {
         steps {
            sh "docker build -t shirnissan/eshoponweb:${BUILD_NUMBER} ."
         }
      }
      stage('Login to docker hub') {
         steps {
           sh "docker login --username=${DOCKERHUB_USER_NAME} --password=${DOCKERHUB_PASSWORD}"    
	}
      }
      stage('Docker push') {
         steps {
           sh "docker push  shirnissan/eshoponweb:${BUILD_NUMBER}"
         }
      }
      stage('Docker run') {
         steps {
           sh " docker run -d -p 8080:80 --name myapp shirnissan/eshoponweb:${BUILD_NUMBER}"
         }
      }
   } 
	    post {
        always {
            cleanWs deleteDirs: true, notFailBuild: true
        }
    }

}
