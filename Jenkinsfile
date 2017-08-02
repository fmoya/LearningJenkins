pipeline {
    agent { label 'dockerized-agent' }
    stages {
        stage('build') {
            steps {
                sh 'prove t'
            }
        }
    }
}
