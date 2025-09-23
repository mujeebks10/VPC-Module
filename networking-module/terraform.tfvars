vpc_cidr = "172.16.0.0/16"
vpc_tags = "my-three-tier-VPC"

web_tier_SG       = "web_tier_SG"
internal_LB_SG    = "internal_LB_SG"
aws_sg_ex_elb     = "external_elb_SG"
ingress_from_port = 80
ingress_to_port   = 80
ingress_protocol  = "tcp"
ingress_cidr      = "0.0.0.0/0"

azs = ["us-east-1a", "us-east-1b"]

app_subnets = ["172.16.1.0/24", "172.16.4.0/24"]

web_subnets = ["172.16.0.0/24", "172.16.3.0/24"]

aws_nat_web1_GW1 = "web-tier1-NAT-GW1"
aws_nat_web2_GW2 = "web-tier2-NAT-GW2"

web_tier1_eip1 = "web_tier1_eip1"
web_tier2_eip2 = "web_tier2_eip2"

web_tier_rt_name = "web-tier-RT"


app_tier_rt_names = {
  "app-subnet-1" = "app-tier1-RT"
  "app-subnet-2" = "app-tier2-RT"
}

app_tier_SG           = "app_tier_SG"
ingress_app_from_port = 4000
ingress_app_to_port   = 4000

db_subnets = ["172.16.2.0/24", "172.16.5.0/24"]

DB_tier_SG           = "DB_tier_SG"
ingress_DB_from_port = 3306
ingress_DB_to_port   = 3306


igw-tags = "my-three-tier-public-igw"

app_route_table_names = {
  "172.16.1.0/24" = "app-tier1-RT"
  "172.16.4.0/24" = "app-tier2-RT"
}
