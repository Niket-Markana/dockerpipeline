pipeline { 
    agent any 
    
    stages { 
        stage('Checkout') { 
            steps { 
                checkout scmGit( 
                    branches: [[name: '*/main']], 
                    extensions: [], 
                    userRemoteConfigs: [[ credentialsId: 'github', url: 'https://github.com/Niket-Markana/dockerpipeline' ]] 
                ) 
            } 
        } // <-- Fixed: Added missing closing bracket for stage('Checkout')

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
        } // <-- Fixed: Added missing closing bracket for stage('Build Image')

        stage('Docker Push') { 
            steps { 
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) { 
                    script { 
                        if (isUnix()) { 
                            sh 'echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin' 
                            sh 'docker push niketmarkana/dockerpipeline' 
                            sh 'docker logout' 
                        } else { 
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
