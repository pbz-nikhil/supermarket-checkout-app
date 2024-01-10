  resource "aws_alb_target_group" "alb_tg" {
    depends_on = [aws_security_group.alb_sg]
    name     = "alb-tg"
    port     = 8080
    protocol = "HTTP"
    target_type = "ip"
    vpc_id   = module.aws_vpc.vpc_id
    health_check {
      enabled             = true
      interval            = 60  
      path                = "/"
      port                = "traffic-port"
      protocol            = "HTTP"
      timeout             = 5
      healthy_threshold   = 3
      unhealthy_threshold = 10
    }
  }

  resource "aws_alb" "app_alb" {
    name               = "supermarket-checkout-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = module.aws_vpc.public_subnets
  }

  resource "aws_alb_listener" "alb_listner" {
    load_balancer_arn = aws_alb.app_alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_alb_target_group.alb_tg.arn
    }
  }

  data "aws_alb" "app_alb_info" {
    name = aws_alb.app_alb.name
  }

  output "alb_url" {
    value = data.aws_alb.app_alb_info.dns_name
  }