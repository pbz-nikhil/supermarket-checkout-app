resource "aws_ecs_task_definition" "task" {
  family = var.app_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  cpu    = 256
  memory = 512
  container_definitions = jsonencode([
    {
      name      = "container1"
      image     = var.docker_image
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "/ecs/${var.app_name}",
          "awslogs-region"        = var.aws_region,
          "awslogs-stream-prefix" = "ecs",
        }
      }
    }
  ])
}
