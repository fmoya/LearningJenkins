pipeline {
    agent { docker 'surhive/daemons:base_v1' }
    stages {
        stage('build') {
            steps {
                sh 'perl --version'
            }
        }
    }
}
