pipeline {
    agent any

    stages {
        stage('Checkout') { 
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']], 
                    extensions: [], 
                    userRemoteConfigs: [[
                        credentialsId: 'github', 
                        url: 'https://github.com/Niket-Markana/dockerpipeline   '
                    ]]
                )
            }

            stage('Build Image') {
                steps {
                    script {
                        if (isUnix()) {
                            sh 'docker build -t niketmarkana/dockerpipeline .'
                        } else {
                            bat 'docker build -t niketmarkana/dockerpipeline .'
                        }
                    }
                }
            }
            stage('Docker Push') {
                steps {
                    // 1. Replace 'YOUR_JENKINS_CREDENTIAL_ID' with your actual Jenkins credential ID
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        script {
                            if (isUnix()) {
                                // Secures login by piping the password instead of exposing it in the CLI string
                                sh 'echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin'
                                // 2. Replace with your own 'username/repository'
                                sh 'docker push niketmarkana/dockerpipeline'
                                sh 'docker logout'
                            } else {
                                // Fixes Windows variable syntax to use $ instead of %
                                bat 'echo %DOCKERHUB_PASSWORD% | docker login -u %DOCKERHUB_USERNAME% --password-stdin'
                                bat 'docker push niketmarkana/dockerpipeline'
                                bat 'docker logout'
                            }
                        }
                    }
                }
            }

    }
}
