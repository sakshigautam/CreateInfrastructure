variable "cluster_name" {}
variable "namespace" {}
variable "aws_region" {}
variable "subnets" {
  type = list(string)
}
variable "vpc_id" {}
