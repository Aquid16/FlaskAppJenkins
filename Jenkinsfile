pipeline {
	agent any
	environment{
		AWS_REGION='us-east-1'
	}
stages {
	stage('Docker build') {
		steps {
			sh 'docker build -t flaskappimage .'
			}
		}
	stage('Push to ECR') {
		steps {
			withAWS(credntials: 'aws-credntials'){
				sh '''aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 992382545251.dkr.ecr.us-east-1.amazonaws.com
				docker tag sharon-jenkins:latest 992382545251.dkr.ecr.us-east-1.amazonaws.com/sharon-jenkins:latest
    				docker push 992382545251.dkr.ecr.us-east-1.amazonaws.com/sharon-jenkins:latest'''
			}
		}
	}
   }
}	
