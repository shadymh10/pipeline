pipeline {
    agent any
    stages {
        stage('Test Credentials') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'KEY1'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'KEY2')
                ]) {
                    sh 'echo "Credentials loaded successfully!"'
                }
            }
        }
    }
}
