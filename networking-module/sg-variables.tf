# Common
# variable "ingress" {
#   type    = string
#   default = "ingress"
# }

variable "ingress_protocol" {
  description = "Protocol for ingress rules"
  type        = string
  default     = "tcp"
}

variable "ingress_cidr" {
  description = "CIDR block allowed to access the security group"
  type        = string
  default     = "0.0.0.0/0"
}

# External LB
variable "aws_sg_ex_elb" {
  type        = string
  default     = "external_elb_SG"
  description = "External LB Security Group"
}

variable "ingress_from_port" {
  description = "Starting port for external LB ingress"
  type        = number
  default     = 80
}

variable "ingress_to_port" {
  description = "Ending port for external LB ingress"
  type        = number
  default     = 80
}

# Web tier
variable "web_tier_SG" {
  type        = string
  default     = "web_tier_SG"
  description = "Web tier Security Group"
}

# Internal LB
variable "internal_LB_SG" {
  type        = string
  default     = "internal_LB_SG"
  description = "Internal LB Security Group"
}

# App tier
variable "app_tier_SG" {
  type        = string
  default     = "app_tier_SG"
  description = "Application tier Security Group"
}

variable "ingress_app_from_port" {
  description = "Starting port for App tier ingress"
  type        = number
  default     = 4000
}

variable "ingress_app_to_port" {
  description = "Ending port for App tier ingress"
  type        = number
  default     = 4000
}

# DB tier
variable "DB_tier_SG" {
  type        = string
  default     = "DB_tier_SG"
  description = "Database tier Security Group"
}

variable "ingress_DB_from_port" {
  description = "Starting port for DB tier ingress"
  type        = number
  default     = 3306
}

variable "ingress_DB_to_port" {
  description = "Ending port for DB tier ingress"
  type        = number
  default     = 3306
}
