module "aws_ecs_service" {
  #count = 2
  source = "./module/service"
  app_name = "service"
  ecs_sg_id = aws_security_group.ecs_sg.id
  cluster_id = aws_ecs_cluster.cluster.id
  app_count = var.app_count
  alb_tg_id = aws_alb_target_group.alb_tg.id
  private_subnets = module.aws_vpc.private_subnets
  task_definition_arn = module.aws_ecs_task.task_definition_arn
}

