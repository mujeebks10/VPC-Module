
variable "vpc_cidr" {
  default = "172.16.0.0/16"

}

variable "vpc_tags" {
  type        = string
  default     = "my-three-tier-VPC"
  description = "Tags to apply to the wy-three-tier-VPC "
}
variable "web_subnets" {
  type        = list(string)
  description = "List of CIDR blocks for the web tier subnets"
  default     = ["172.16.0.0/24", "172.16.3.0/24"]

}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"] # explicitly assign AZs
}

variable "app_subnets" {
  type        = list(string)
  description = "List of CIDR blocks for the app tier subnets"
  default     = ["172.16.1.0/24", "172.16.4.0/24"]

}

variable "db_subnets" {
  type        = list(string)
  description = "List of CIDR blocks for the db tier subnets"
  default     = ["172.16.2.0/24", "172.16.5.0/24"]

}

###### Internet Gateway ##########

variable "igw_tags" {
  description = "Tags to apply to the Internet Gateway"
  type        = string
  default     = "my-three-tier-public-igw" # optional default value
}

############# NAT GATEWAY #############

variable "aws_nat_web1_GW1" {
  description = "This NAT gateway for web-tier1"
  type        = string
  default     = "web-tier1-NAT-GW1"

}

variable "aws_nat_web2_GW2" {
  description = "This NAT gateway for web-tier2"
  type        = string
  default     = "web-tier2-NAT-GW2"

}

############# EIP #############

variable "web_tier1_eip1" {
  type        = string
  default     = "web_tier1_eip1"
  description = "This EIP for Web-tier1"
}


variable "web_tier2_eip2" {
  type        = string
  default     = "web_tier2_eip2"
  description = "This EIP for Web-tier2"
}

############ ROUTE TABLES #############

# Web (public) route table
variable "web_tier_RT" {
  description = "Prefix for web route table names"
  type        = string
  default     = "web-rt"
}


#App (private) route tables
# variable "app_tier_rt" {
#   description = "Map of app route table names keyed by subnet"
#   type        = map(string)
#   default = {
#     # "app-subnet-1" = "app-tier1-RT"
#     # "app-subnet-2" = "app-tier2-RT"
#     "172.16.1.0/24" = "app-tier1-RT"
#     "172.16.4.0/24" = "app-tier2-RT"
#   }
# }

variable "app_tier_rt" {
  type = map(string)
  default = {
    "172.16.1.0/24" = "app-tier1-RT"
    "172.16.4.0/24" = "app-tier2-RT"
  }
}
