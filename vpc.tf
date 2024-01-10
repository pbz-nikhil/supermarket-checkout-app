module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ecs_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway  = true
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.aws_vpc.vpc_id

  ingress {
    description      = "http allow"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Allow HTTP inbound traffic from alb_sg"
  vpc_id      = module.aws_vpc.vpc_id

  ingress {
    description      = "http allow"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}