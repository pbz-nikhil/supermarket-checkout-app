variable "ecs_sg_id" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "task_definition_arn" {
  type = string
}

variable "app_count" {
  type = string
}

variable "alb_tg_id" {
  type = string
}

variable "private_subnets" {
  type = list
}

variable "app_name" {
  type = string
}