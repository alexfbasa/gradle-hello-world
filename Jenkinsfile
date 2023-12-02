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
                    // Use your GitHub token stored in 'github-token' secret
                    def githubToken = credentials('github-token')

                    // Perform Docker login using the token
                    sh "echo ${githubToken} | docker login ghcr.io -u ${githubToken} --password-stdin"

                    // Push the Docker image to the registry
                    sh 'docker push alexsimple/lu-hello-world:latest'
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    sh 'envsubst < ${WORKSPACE}/deployment.yaml | kubectl apply -f -'
                }
            }
        }
    }
}
