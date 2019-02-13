# Swagger Demo

## Purpose

The purpose of this repository is to show a deployment process that uses per Lambda function 
swagger configs to build up a full API specification. By using Swagger we can simplify the 
Terraform provisioning process which will accept a full Swagger config in an 
aws_api_gateway_rest_api resource to build out the demo API Gateway. 

The process is 

* Package the Lambdas
  Not automated in this demo. Will be replaced with a Jenkins to package the individual 
  Lambda functions. In the short term<br />
  ```bash
  source venv/bin/activate
  cd serverless
  cd <function>
  bash package.sh
  ```
  
* Run the Terraform code 
  ```
  cd tf/modules-common/FidelityDemo
  bash provision.sh plan 
  bash provision.sh apply 
  ```
  
The provision.sh script is a simple shell script that performs the following actions 
* exports some Terraform environment variables 
* Runs a simple Python script to merge per function swagger files 
  Writes a temporary file called swagger-merged.yaml 
* Runs Terraform to create the AWS resources passing in the Swagger definition file 
  to create the service 
  
  

 
  





