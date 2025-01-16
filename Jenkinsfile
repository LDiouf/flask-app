pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'lduiof/flask-app:latest'
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials-id' // Remplace par l'ID de tes credentials Jenkins
        KUBE_CONFIG = '/path/to/kubeconfig' // Chemin vers ton fichier kubeconfig
    }
    stages {
        stage('Cloner le dépôt') {
            steps {
                git 'https://github.com/LDiouf/flask-app.git'
            }
        }
        
        stage('Construire l\'image Docker') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Pousser l\'image sur DockerHub') {
            steps {
                withDockerRegistry([credentialsId: "$DOCKER_HUB_CREDENTIALS", url: 'https://index.docker.io/v1/']) {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Déployer sur Kubernetes') {
            steps {
                sh '''
                kubectl --kubeconfig=$KUBE_CONFIG apply -f kubernetes/deployment.yaml
                kubectl --kubeconfig=$KUBE_CONFIG apply -f kubernetes/service.yaml
                '''
            }
        }
    }
    post {
        success {
            echo 'Pipeline terminé avec succès!'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}

