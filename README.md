# Udacity Capstone Project for Cloud DevOps

<h2>Introduction</h2>

<p> This is a project aimed at applying concepts studied in the Udacity Cloud DevOps program. Concepts studied include but not limited to:</p>

<ul>
	<li>AWS Cloud Fundamentals</li>
        <li>Deploying Infrastructure as Code on Infrastructure as a Service (IaaS) Platform</li>
	<li>Continuous Integration and Continuous Deployment (CI/CD) with <code>Jenkins</code>, <code>Circleci</code>, etc.</li>
	<li>Microservices with Docker</li>
	<li>Kubernetes for Microservices Orchestration</li>
</ul>


<h2>Project Details</h2>

<ul>
  <li>Run a Simple <code>nginx</code> Docker Application</li>
  <li>Create a Jenkins Pipeline to deploy the containerised application to <code>Amazon Elastic Kubernetes Service (EKS)</code></li>
  <li>Include steps: Linting, upload to dockerhub, deployment to <code>AWS EKS</code>, and Security scanning of the docker build with <code>Clair-scanner</code> steps in the Jenkinsfile</li>
  <li>Perform and test Rolling Updates</li> 
</ul>

<h2>Project Files</h2>

<ul>
  <li><code>index.html:</code> This is the html code to run in the Docker container via nginx</li>
  <li><code>Dockerfile:</code> This defines the docker container</li>
  <li><code>Jenkinsfile:</code> This defines the pipeline for CI/CD automation<li>
  <li><code>deployment.yml</code> This defines the parameters for Kubernetes deployment and services</li>
  <li><code>loadbalancer.yml</code> This provides an interface to the Kubernetes pods to loadbalance incoming requests to the cluster</li> 
</ul>

<h2>Testing</h2>

The Website is accessible at:
[WebApp](http://a9479c23ed45246a590f57de4a6b6004-204603934.us-west-2.elb.amazonaws.com/)

