# Supermarket Checkout Application

## Overview

This is a simple Spring Boot application for a supermarket checkout system. The application calculates the total price of a number of items based on predefined prices and special offers. The application is containerized using Docker and deployed on Amazon ECS with CDN caching configured using Terraform.

## Prerequisites

- Docker installed locally.
- AWS CLI configured with necessary permissions.
- New ECR Repository

## Build and Push Docker Image to ECR (Elastic Container Registry)

**Note: You have already performed these steps manually. Skip this section if you've already built and pushed the Docker image.**

1. **Authenticate Docker with ECR:**

   ```bash
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your-aws-account-number>.dkr.ecr.us-east-1.amazonaws.com
   ```

2. **Build the Docker image:**

   ```bash
   docker build -t supermarket-checkout-app .
   ```

3. **Tag the Docker image:**

   ```bash
   docker tag supermarket-checkout-app:latest <your-aws-account-number>.dkr.ecr.us-east-1.amazonaws.com/supermarket-checkout:latest
   ```

4. **Push the Docker image to ECR:**

   ```bash
   docker push <your-aws-account-number>.dkr.ecr.us-east-1.amazonaws.com/supermarket-checkout:latest
   ```

## Deploy Application on Amazon ECS with Terraform

1. **Create a Terraform variables file (`terraform.tfvars`):**

   Create a file named `terraform.tfvars` and add the following content, replacing the empty quotes (`""`) with your actual values:

   ```ini
   aws_access_key = ""
   aws_secret_key = ""
   aws_region = ""
   docker_image = ""
   app_count = "1"
   ```

   Replace:
   - `aws_access_key`: Your AWS access key.
   - `aws_secret_key`: Your AWS secret key.
   - `aws_region`: Your AWS Region.
   - `docker_image`: Your Docker image url.

2. **Initialize Terraform:**

   ```bash
   terraform init
   ```

3. **Review and apply Terraform changes:**

   ```bash
   terraform apply
   ```

   Confirm changes when prompted.

4. **Access the Application:**

   Once the Terraform apply is successful, you can access the application through the provided CDN URL.