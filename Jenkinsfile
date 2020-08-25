pipeline {
     agent any
     stages {
         stage('Info') {
              steps {
                  sh 'echo Starting Pipeline'
              }
         }
         stage('Lint all HTML files') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Build Docker Image') {
              steps {
                  sh 'docker build -t udacity-capstone-cloud-devops .'
              }
         }
         stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
                      sh "docker tag udacity-capstone-cloud-devops ofosukin/udacity-capstone-cloud-devops"
                      sh 'docker push ofosukin/udacity-capstone-cloud-devops'
                  }
              }
         }
         stage('Security Scan') {
              steps {
                  aquaMicroscanner imageName: 'udacity-capstone-cloud-devops:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
              }
         }
         stage('Deploying to AWS') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentialsId: '282457606471', region: 'us-west-2') {
                      sh "aws eks --region us-west-2 update-kubeconfig --name capstone-production"
                      sh "kubectl config use-context arn:aws:eks:us-west-2:arn:aws:eks:us-west-2:282457606471:cluster/capstone-production"
                      sh "kubectl set image deployments/udacity-capstone-cloud-devops udacity-capstone-cloud-devops=ofosukin/udacity-capstone-cloud-devops:latest"
                      sh "kubectl apply -f deployment/deployment.yml"
                      sh "kubectl get nodes"
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/udacity-capstone-cloud-devops"
                  }
              }
        }
        stage("Cleaning up") {
              steps{
                    echo 'Cleaning up...'
                    sh "docker system prune"
              }
        }
     }
}
