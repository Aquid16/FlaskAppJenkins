pipeline {
	agent any
stages {
	stage('Docker build') {
		steps {
			sh 'docker build -t flaskappimage .'
			}
		}
	stage('Push to ECR') {
		steps {
			withAWS(credentials: 'aws-credentials'){
				sh '''aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 992382545251.dkr.ecr.us-east-1.amazonaws.com
				docker tag flaskappimage:latest 992382545251.dkr.ecr.us-east-1.amazonaws.com/sharon-jenkins:latest
    				docker push 992382545251.dkr.ecr.us-east-1.amazonaws.com/sharon-jenkins:latest'''
			}
		}
	}
	stage('Deploy to Production'){
		steps{
			script{
			withCredentials([sshUserPrivateKey(credentialsId:'SSH_KEY',keyFileVariable:'ssh_sharon')]) {
				withAWS(credentials: 'aws-credentials'){
				sh '''ssh -o StrictHostKeyChecking=no -i $ssh_sharon ubuntu@44.222.93.154
    				whoami
    				aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 992382545251.dkr.ecr.us-east-1.amazonaws.com
    				docker pull 992382545251.dkr.ecr.us-east-1.amazonaws.com/sharon-jenkins:latest
				docker run -d -p 80:5000 992382545251.dkr.ecr.us-east-1.amazonaws.com/sharon-jenkins:latest'''
				}
			}
			}
		}
	}
   }
}	
