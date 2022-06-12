# About this session
This session is about how to use ECS + EC2 + VPC + Load Balancer
The example code will be developed in php and the infrastructure will be coded with Terraform.

## Project Structure
- A sample php app
- A repository folder with terraform code to create the ECR repository necessary to deploy the app.
- The infrastructure code to deploy VPC, ECS, Load Balancer, DNS record and so on.

## Setup tf vars

Create a `default.tfvars` in repository and infrastructure folders with the following content:
```
aws_region         = "us-east-1"
availability_zones = ["us-east-1a", "us-east-1b"]

cidr            = "10.10.0.0/16"
public_subnets  = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets = ["10.10.0.0/24", "10.10.1.0/24"]

app_name        = "app"
app_environment = "dev"
```

## How to use it

1. Deploy repository project.
2. Build the app and push it to the created repo.
3. Finally deploy the infrastructure.