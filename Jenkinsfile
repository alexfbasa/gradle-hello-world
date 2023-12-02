pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Print the current directory
                    echo "Current Directory: ${pwd()}"

                    // List the contents of the current directory
                    sh 'ls -la'

                    // Echo the Gradle wrapper script location
                    sh 'echo "Gradle Wrapper Location: ${WORKSPACE}/gradlew"'

                    // Run Gradle build
                    sh './gradlew build'
                }
            }
        }


        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t alexsimple/lu-hello-world .'
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    sh "echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_ACTOR --password-stdin"
                    sh 'docker push alexsimple/lu-hello-world'
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
