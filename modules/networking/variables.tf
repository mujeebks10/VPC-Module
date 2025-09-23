##########################
# VPC Variables
##########################
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "vpc_tags" {
  description = "Tag name for the VPC"
  type        = string
  default     = "my-three-tier-VPC"
}

##########################
# Availability Zones
##########################
variable "azs" {
  description = "List of availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

##########################
# Subnet Variables
##########################
variable "web_subnets" {
  description = "List of CIDR blocks for web tier subnets"
  type        = list(string)
  default     = ["172.16.0.0/24", "172.16.3.0/24"]
}

variable "app_subnets" {
  description = "List of CIDR blocks for app tier subnets"
  type        = list(string)
  default     = ["172.16.1.0/24", "172.16.4.0/24"]
}

variable "db_subnets" {
  description = "List of CIDR blocks for db tier subnets"
  type        = list(string)
  default     = ["172.16.2.0/24", "172.16.5.0/24"]
}

##########################
# Internet Gateway
##########################
variable "igw_tags" {
  description = "Tags to apply to the Internet Gateway"
  type        = string
  default     = "my-three-tier-public-igw" # optional default
}


##########################
# NAT Gateway Variables
##########################
variable "aws_nat_web1_GW1" {
  description = "Name for NAT gateway in web-tier1"
  type        = string
  default     = "web-tier1-NAT-GW1"
}

variable "aws_nat_web2_GW2" {
  description = "Name for NAT gateway in web-tier2"
  type        = string
  default     = "web-tier2-NAT-GW2"
}

##########################
# Elastic IP Variables
##########################
variable "web_tier1_eip1" {
  description = "Elastic IP for Web-tier1 NAT gateway"
  type        = string
  default     = "web_tier1_eip1"
}

variable "web_tier2_eip2" {
  description = "Elastic IP for Web-tier2 NAT gateway"
  type        = string
  default     = "web_tier2_eip2"
}

##########################
# Security Groups
##########################
# External LB
variable "aws_sg_ex_elb" {
  description = "External LB Security Group"
  type        = string
  default     = "external_elb_SG"
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

variable "ingress_protocol" {
  description = "Protocol for ingress rules"
  type        = string
  default     = "tcp"
}

variable "ingress_cidr" {
  description = "CIDR allowed for external LB ingress"
  type        = string
  default     = "0.0.0.0/0"
}

# Web Tier
variable "web_tier_SG" {
  description = "Web tier Security Group"
  type        = string
  default     = "web_tier_SG"
}

# Internal LB
variable "internal_LB_SG" {
  description = "Internal LB Security Group"
  type        = string
  default     = "internal_LB_SG"
}

# App Tier
variable "app_tier_SG" {
  description = "App tier Security Group"
  type        = string
  default     = "app_tier_SG"
}

variable "ingress_app_from_port" {
  description = "App tier ingress start port"
  type        = number
  default     = 4000
}

variable "ingress_app_to_port" {
  description = "App tier ingress end port"
  type        = number
  default     = 4000
}

# DB Tier
variable "DB_tier_SG" {
  description = "DB tier Security Group"
  type        = string
  default     = "DB_tier_SG"
}

variable "ingress_DB_from_port" {
  description = "DB tier ingress start port"
  type        = number
  default     = 3306
}

variable "ingress_DB_to_port" {
  description = "DB tier ingress end port"
  type        = number
  default     = 3306
}

##########################
# Route Tables
##########################
# Web tier route table
# variable "web_tier-RT" {
#   description = "Prefix for web route table names"
#   type        = string
#   default     = "web_tier-RT"
# }

variable "web_tier_RT" {
  description = "Prefix for web route table names"
  type        = string
  default     = "web-rt"
}

variable "app_tier_rt" {
  type = map(string)
  default = {
    "app-subnet-1" = "app-tier1-RT"
    "app-subnet-2" = "app-tier2-RT"
  }
}




