resource "aws_vpc" "my_three_tier_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_tags
  }
}


########### SUBNETS ##########

resource "aws_subnet" "web" {
  for_each                = toset(var.web_subnets)
  vpc_id                  = aws_vpc.my_three_tier_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = each.value

  availability_zone = element(var.azs, index(var.web_subnets, each.value))

  tags = {
    Name = "web-${index(var.web_subnets, each.value) + 1}"
  }
}


resource "aws_subnet" "app" {
  for_each   = toset(var.app_subnets)
  vpc_id     = aws_vpc.my_three_tier_vpc.id
  cidr_block = each.value

  availability_zone = element(var.azs, index(var.app_subnets, each.value))

  tags = {
    Name = "app-${index(var.app_subnets, each.value) + 1}"
  }
}


resource "aws_subnet" "db" {
  for_each          = toset(var.db_subnets)
  vpc_id            = aws_vpc.my_three_tier_vpc.id
  cidr_block        = each.value
  availability_zone = element(var.azs, index(var.db_subnets, each.value))
  tags = {
    Name = "db-${index(var.db_subnets, each.value) + 1}"
  }
}

########## INTERNET GATEWAY ##########
resource "aws_internet_gateway" "my_three_tier_igw" {
  vpc_id = aws_vpc.my_three_tier_vpc.id

  tags = {
    Name = var.igw_tags
  }
}

########### NAT GATEWAYS ##########
resource "aws_nat_gateway" "web_tier" {
  for_each      = aws_subnet.web
  allocation_id = aws_eip.web_tier[each.key].id
  subnet_id     = each.value.id

  tags = {
    Name = each.key == var.web_subnets[0] ? var.aws_nat_web1_GW1 : var.aws_nat_web2_GW2
  }
}


########## OR NAT ###########

resource "aws_nat_gateway" "web_tier1" {
  allocation_id = aws_eip.web_tier1_eip1.id
  subnet_id     = aws_subnet.web[var.web_subnets[0]].id
  tags          = { Name = var.aws_nat_web1_GW1 }
}

resource "aws_nat_gateway" "web_tier2" {
  allocation_id = aws_eip.web_tier2_eip2.id
  subnet_id     = aws_subnet.web[var.web_subnets[1]].id
  tags          = { Name = var.aws_nat_web2_GW2 }
}

########## ROUTE TABLES ##########

# Create one route table per subnet
resource "aws_route_table" "web" {
  for_each = aws_subnet.web

  vpc_id = aws_vpc.my_three_tier_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_three_tier_igw.id
  }

  tags = {
    Name = "${var.web_tier_RT}-${index(var.web_subnets, each.value.cidr_block) + 1}"
  }
}

# Associate each subnet with its route table
resource "aws_route_table_association" "web" {
  for_each = aws_subnet.web

  subnet_id      = each.value.id
  route_table_id = aws_route_table.web[each.key].id
}

####### APP ROUTE TABLES ##########
resource "aws_route_table" "app" {
  for_each = aws_subnet.app

  vpc_id = aws_vpc.my_three_tier_vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = each.key == var.app_subnets[0] ? aws_nat_gateway.web_tier1.id : aws_nat_gateway.web_tier2.id
  }

tags = {
    #Name = var.app_tier_rt[each.value]
  }
}

########### ROUTE TABLE ASSOCIATIONS ##########
resource "aws_route_table_association" "app" {
  for_each = aws_subnet.app

  subnet_id      = each.value.id
  route_table_id = aws_route_table.app[each.key].id
}
