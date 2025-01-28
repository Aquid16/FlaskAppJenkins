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
			withCredentials([sshUserPrivateKey(credentialsId: 'SSH_KEY', keyFileVariable: 'keyfile')]) {
				sh '''ssh -i $keyfile -o StrictHostKeyChecking=no ubuntu@44.222.93.154
    				docker pull 992382545251.dkr.ecr.us-east-1.amazonaws.com/sharon-jenkins:latest
				docker run -d -p 80:5000 992382545251.dkr.ecr.us-east-1.amazonaws.com/sharon-jenkins:latest'''
			}
		}
	}
   }
}	
