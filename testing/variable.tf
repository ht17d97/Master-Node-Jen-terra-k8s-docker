variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "image_name" {
  type = string
}
variable "instance_type" {
    type = string
}
variable "ingress_ports" {
    type = list(number)
}

#############################################################
#############################################################
#############################################################
#############################################################


# variable "aws_region" {
#   type        = string
#   default     = "us-east-1"
# }

variable "vpc_cidr" {
  type        = string
}
variable "public_subnets" {
  type        = list(string)
}
variable "private_subnets" {
  type        = list(string)
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}
