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
                withAWS(credentials: 'aws-access-key', region: 'us-east-1') {
                    sh 'terraform init -reconfigure'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                echo "🔹 Creating Terraform plan..."
                withAWS(credentials: 'aws-access-key', region: 'us-east-1') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                echo "🔹 Applying Terraform..."
                withAWS(credentials: 'aws-access-key', region: 'us-east-1') {
                    sh 'terraform apply -auto-approve tfplan'
                }
                echo "✅ Infrastructure deployed successfully!"
            }
        }

        stage('Terraform Destroy') {
            steps {
                echo "🗑️ Destroying Terraform infrastructure..."
                withAWS(credentials: 'aws-access-key', region: 'us-east-1') {
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
