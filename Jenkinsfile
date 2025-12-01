pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    stages {
        stage('Checkout Code') {
            steps {
                echo "🔹 Checking out repository..."
                git branch: 'main', url: 'https://github.com/shadymh10/pipeline'
            }
        }
        stage('Terraform Init') {
            steps {
                echo "🔹 Initializing Terraform..."
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        echo "AWS credentials loaded successfully"
                        terraform init -reconfigure
                    '''
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                echo "🔹 Creating Terraform plan..."
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                echo "🔹 Applying Terraform..."
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
                echo "✅ Infrastructure deployed successfully!"
            }
        }
        stage('Terraform Destroy') {
            steps {
                echo "🗑️ Destroying Terraform infrastructure..."
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'terraform destroy -auto-approve'
                }
                echo "🔥 Infrastructure destroyed successfully!"
            }
        }
    }
    post {
        success {
            echo "🎉 Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
