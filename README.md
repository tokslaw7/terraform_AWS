# Terraform and AWS deployment 

This repository contains Terraform configuration files to automate the deployment and management of infrastructure on Amazon Web Services (AWS). By using Infrastructure as Code (IaC), this project ensures that the environment is version-controlled, reproducible, and scalable.

## Architecture

A 3-tier web application VPC with Public/Private subnets, an RDS database, and an Auto Scaling Group

- Deployable environment, including an EC2 instance accessible via SSH 
- Deploy AWS resources and an EC2 instance that you can SSH into to have your own redeployable environment.

## Project Structure
`
 - modules/                # Reusable modules (VPC, EC2, S3, etc.)
 - environments/           # Environment-specific variables (dev, prod)
 - main.tf                 # Main entry point for Terraform
 - variables.tf            # Input variable definitions
 - outputs.tf              # Values to be printed after deployment
 - providers.tf            # AWS Provider and Version constraints
 - terraform.tfvars        # Secret/Specific variable values (Git ignored)


## Prerequisites
1. **Terraform** 
2. **AWS CLI** configured with appropriate credentials.
3. An IAM User with permissions for the resources


## Getting Started
1. **Initialize the Directory**
Download the necessary providers and initialize 
`terraform init`

2. **Preview the Changes**
Review the infrastructure plan to ensure it matches your expectations
`terraform plan`

3. **Deploy Infrastructure**
Apply the configuration to create resources in AWS
```terraform apply```

4. **Cleanup**
To avoid ongoing costs, destroy the infrastructure when finished
`terraform destroy`


#### The Userdata helps to boostrap the Docker engine and this allows to have an easy instance deployed with Docker ready to go for all development needs.

