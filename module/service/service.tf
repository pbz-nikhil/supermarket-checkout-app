resource "aws_ecs_service" "service" {
  name            = var.app_name
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [var.ecs_sg_id]
    subnets          = var.private_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_tg_id
    container_name   = "container1"
    container_port   = "8080"
  }

  #depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}