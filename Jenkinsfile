pipeline {
     agent any
     stages {
         stage('Info') {
              steps {
                  sh "echo Starting Pipeline"
              }
         }
         stage('Lint all HTML files') {
              steps {
                  sh "tidy -q -e *.html"
              }
         }
         stage('Build Docker Image') {
              steps {
                  sh "docker build -t udacity-capstone-cloud-devops:v1 ."
              }
         }
         stage("docker_scan") {
              steps {
                  sh '''
                     #docker run -d --name db arminc/clair-db
                     sleep 15 # wait for db to come up
                     docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan
                     sleep 1
                     DOCKER_GATEWAY=$(docker network inspect bridge --format "{{range .IPAM.Config}}{{.Gateway}}{{end}}")
                     wget -qO clair-scanner https://github.com/arminc/clair-scanner/releases/download/v8/clair-scanner_linux_amd64 && chmod +x clair-scanner
                     ./clair-scanner --ip="$DOCKER_GATEWAY" udacity-capstone-cloud-devops:v1 || exit 0
                   '''
              }
         }
         stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
                      sh "docker tag udacity-capstone-cloud-devops:v1 ofosukin/udacity-capstone-cloud-devops"
                      sh "docker push ofosukin/udacity-capstone-cloud-devops"
                  }
              }
         }
         stage('Deploying to AWS') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials: 'aws-udacity', region: 'us-west-2') {
                      sh "aws eks --region us-west-2 update-kubeconfig --name capstone-production"
                      sh "kubectl config use-context arn:aws:eks:us-west-2:282457606471:cluster/capstone-production"
                      sh "kubectl apply -f deployment/deployment.yml"
                      sh "kubectl get deployment"
                      sh "kubectl get pods"
                      sh "kubectl describe pods"
                      sh "kubectl set image deployment/udacity-capstone-cloud-devops udacity-capstone-cloud-devops=ofosukin/udacity-capstone-cloud-devops:latest"
                      sh "kubectl get pods"
                      sh "kubectl describe services/udacity-capstone-cloud-devops"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/udacity-capstone-cloud-devops"
                      sh "kubectl rollout status deployments/udacity-capstone-cloud-devops"
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
