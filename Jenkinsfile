pipeline {
	tools{
		terraform 'terraform-11'
	}
  	environment {
    		registry = "shirnissan/"
    		registryCredential = 'docker-creds'
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
				sh "docker-compose up -d --build shirnissan/eshopwebmvc"
			}
		}
		stage('Docker-compose build eshoppublicapi') {
			steps {
				sh "docker-compose up -d --build shirnissan/eshoppublicapi"
			}
		}
		stage('Login to docker hub') {
			steps {
				sh "docker login --username=${env.DOCKERHUB_USER_NAME} --password=${env.DOCKERHUB_PASSWORD}"
			}
		}
		stage('Docker push') {
			steps {
				sh "docker push  shirnissan/eshopwebmvc:${BUILD_NUMBER}"
				sh "docker push  shirnissan/eshoppublicapi:${BUILD_NUMBER}"
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
