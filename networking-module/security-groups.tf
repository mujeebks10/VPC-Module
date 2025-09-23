########################
# External LB SG
########################
resource "aws_security_group" "external_LB_SG" {
  name        = var.aws_sg_ex_elb
  description = "Allow traffic from External LB"
  vpc_id      = aws_vpc.my_three_tier_vpc.id

  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = [var.ingress_cidr]
  }

  tags = {
    Name = var.aws_sg_ex_elb
  }
}

########################
# Web Tier SG
########################
resource "aws_security_group" "web_tier_SG" {
  name        = var.web_tier_SG
  description = "Allow traffic from External LB to Web tier"
  vpc_id      = aws_vpc.my_three_tier_vpc.id

  ingress {
    from_port       = var.ingress_from_port
    to_port         = var.ingress_to_port
    protocol        = var.ingress_protocol
    security_groups = [aws_security_group.external_LB_SG.id]
  }

  tags = {
    Name = var.web_tier_SG
  }
}

########################
# Internal LB SG
########################
resource "aws_security_group" "internal_LB_SG" {
  name        = var.internal_LB_SG
  description = "Internal LB Security Group"
  vpc_id      = aws_vpc.my_three_tier_vpc.id

  ingress {
    from_port       = var.ingress_from_port
    to_port         = var.ingress_to_port
    protocol        = var.ingress_protocol
    security_groups = [aws_security_group.web_tier_SG.id]
  }

  tags = {
    Name = var.internal_LB_SG
  }
}

########################
# App Tier SG
########################
resource "aws_security_group" "app_tier_SG" {
  name        = var.app_tier_SG
  description = "Application Tier Security Group"
  vpc_id      = aws_vpc.my_three_tier_vpc.id

  ingress {
    from_port       = var.ingress_app_from_port
    to_port         = var.ingress_app_to_port
    protocol        = var.ingress_protocol
    security_groups = [aws_security_group.internal_LB_SG.id]
  }

  tags = {
    Name = var.app_tier_SG
  }
}

########################
# DB Tier SG
########################
resource "aws_security_group" "DB_tier_SG" {
  name        = var.DB_tier_SG
  description = "Database Tier Security Group"
  vpc_id      = aws_vpc.my_three_tier_vpc.id

  ingress {
    from_port       = var.ingress_DB_from_port
    to_port         = var.ingress_DB_to_port
    protocol        = var.ingress_protocol
    security_groups = [aws_security_group.app_tier_SG.id]
  }

  tags = {
    Name = var.DB_tier_SG
  }
}
