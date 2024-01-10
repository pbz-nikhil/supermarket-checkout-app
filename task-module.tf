module "aws_ecs_task" {
  source = "./module/task"
  docker_image = var.docker_image
  app_name = "task"
  aws_region = var.aws_region
}
