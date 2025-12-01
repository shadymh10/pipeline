pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "🔹 Checking out repository..."
                git branch: 'main', url: 'https://github.com/Ahmedlebshten/Jenkins-Pipeline-Project'
            }
        }

        stage('Terraform Init') {
            steps {
                echo "🔹 Initializing Terraform..."
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-access-key'
                ]]) {
                    sh 'terraform init -reconfigure'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                echo "🔹 Creating Terraform plan..."
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-access-key'
                ]]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        /*
        stage('Terraform Apply') {
            steps {
                echo "🔹 Applying Terraform..."
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-access-key'
                ]]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
                echo "✅ Infrastructure deployed successfully!"
            }
        }
        */

        stage('Terraform Destroy') {
            steps {
                echo "🗑️ Destroying Terraform infrastructure..."
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-access-key'
                ]]) {
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
