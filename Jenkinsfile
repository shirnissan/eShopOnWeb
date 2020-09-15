pipeline {
	tools{
		terraform 'terraform-11'
	}
  	environment {
    		registry = "shirnissan/eshoponweb"
    		registryCredential = 'docker-creds'
		AWS_SECRET_ACCESS_KEY = credentials('awsCredentials')
  	}
	agent any
   	stages {
		stage('Docker ps') {
			steps {
				sh "docker ps"
			}
		}
		stage('Docker-compose build eshopwebmvc') {
			steps {
				sh "docker-compose up -d --build eshopwebmvc:latest"
			}
		}
		stage('Docker-compose build eshoppublicapi') {
			steps {
				sh "docker-compose up -d --build eshoppublicapi:latest"
			}
		}
		stage('Login to docker hub') {
			steps {
				sh "docker login --username=${env.DOCKERHUB_USER_NAME} --password=${env.DOCKERHUB_PASSWORD}"
			}
		}
		stage('Docker push') {
			steps {
				sh "docker push  shirnissan/eshoponweb:${BUILD_NUMBER}"
			}
		}
		stage('Terraform init') {
			steps {
				sh "terraform init"
			}
		}
		stage('Terraform plan') {
			steps {
				sh "terraform plan -out eShop.tfplan"
			}
		}
		stage('Terraform apply') {
			steps {
				sh "terraform apply --auto-approve"
			}
		}
	}
	post {
		always {
			cleanWs deleteDirs: true, notFailBuild: true
		}
	}
}
