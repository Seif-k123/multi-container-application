pipeline {

    agent any

    environment {

        IMAGE_NAME = "seifkhaled123/multi-container-app"
        DOCKER_CREDS = "dockerhub-cred"
        ANSIBLE_INVENTORY = "ansible/inventory.ini"

    }


    stages {


        stage('Checkout') {

            steps {
                checkout scm
            }

        }


        stage('Terraform Provision') {

            steps {

                dir('terraform') {

                    sh '''

                    terraform init
                    terraform apply -auto-approve

                    echo "Waiting for EC2 instance to be ready..."
                    sleep 60
                    '''

                }

            }

        }


        stage('Build Docker Image') {

            steps {

                sh """

                docker build \
                -t ${IMAGE_NAME}:${BUILD_NUMBER} \
                -t ${IMAGE_NAME}:latest \
                ./api

                """

            }

        }


        stage('Docker Login') {

            steps {

                withCredentials([

                    usernamePassword(
                    credentialsId: "${DOCKER_CREDS}",
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                    )

                ]) {

                    sh '''

                    echo "$DOCKER_PASSWORD" | docker login \
                    -u "$DOCKER_USERNAME" \
                    --password-stdin

                    '''

                }

            }

        }


        stage('Push Image') {

            steps {

                sh """

                docker push ${IMAGE_NAME}:${BUILD_NUMBER}

                docker push ${IMAGE_NAME}:latest

                """

            }

        }


        stage('Ansible Deploy') {

            steps {

                sh '''
                export ANSIBLE_HOST_KEY_CHECKING=False
    
                ansible-playbook \
                -i ${ANSIBLE_INVENTORY} \
                ansible/playbook.yml

                '''

            }

        }


        stage('Cleanup') {

            steps {

                sh """

                docker image rm ${IMAGE_NAME}:${BUILD_NUMBER} || true

                docker image rm ${IMAGE_NAME}:latest || true

                """

            }

        }

    }


    post {

        success {
            echo 'Deployment completed successfully 🚀'
        }

        failure {
            echo 'Pipeline failed ❌'
        }

        always {
            sh 'docker logout || true'
        }

    }

}
