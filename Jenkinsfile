pipeline {
  	environment {
    		DOCKER_REGISTRY = "shirnissan/"
    		registryCredential = 'docker-creds'
		IMAGE_TAG = "${BUILD_NUMBER}"
  	}
	agent {
		node {
			lable 'master'
		}
	}
   	stages {
		// stage('Docker ps') {
		// 	steps {
		// 		sh "docker ps"
		// 	}
		// }
		// stage('Docker-compose build and tag eshopwebmvc') {
		// 	steps {
		// 		sh "docker-compose up -d --build eshopwebmvc"
		// 	}
		// }
		// stage('Docker-compose build eshoppublicapi') {
		// 	steps {
		// 		sh "docker-compose up -d --build eshoppublicapi"
		// 	}
		// }
		// stage('Login to docker hub') {
		// 	steps {
		// 		sh "docker login --username=${env.DOCKERHUB_USER_NAME} --password=${env.DOCKERHUB_PASSWORD}"
		// 	}
		// }
		// stage('Docker push') {
		// 	steps {
		// 		sh "docker push  shirnissan/eshopwebmvc:${BUILD_NUMBER}"
		// 		sh "docker push  shirnissan/eshoppublicapi:${BUILD_NUMBER}"
		// 	}
		// }
		stage('Docker run'){
			steps{
				script{
                    // The script triggers PayloadJob on every node.
                    // It uses Node and Label Parameter plugin to pass the job name to the payload job.
                    // The code will require approval of several Jenkins classes in the Script Security mode
                    def vms = [:]
                    def names = nodeNames()
                    for (int i=0; i<names.size(); ++i) {
                        def nodeName = names[i];
                        if (nodeName != "master") {
                            // Into each branch we put the pipeline code we want to execute
                            vms["node_" + nodeName] = {
                                node(nodeName) {
                                    echo "Triggering on " + nodeName
                                }
                            }
                        }
                    }   
                    // Now we trigger all vms
                    parallel vms
		        }
	        }
        }
    }

	post {
		always {
			cleanWs deleteDirs: true, notFailBuild: true
		}
	}
}






// This method collects a list of Node names from the current Jenkins instance
@NonCPS
def nodeNames() {
  return jenkins.model.Jenkins.instance.nodes.collect { node -> node.name }
}
