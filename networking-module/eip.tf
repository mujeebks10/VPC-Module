resource "aws_eip" "web_tier1_eip1" {
  domain = "vpc"

  tags = {
    Name = var.web_tier1_eip1
  }
}



resource "aws_eip" "web_tier2_eip2" {
  domain = "vpc"

  tags = {
    Name = var.web_tier2_eip2
  }
}

############ OR EIP ##########
resource "aws_eip" "web_tier" {
  for_each = toset(var.web_subnets)
  domain   = "vpc"
  tags = {
    Name = each.key == var.web_subnets[0] ? var.web_tier1_eip1 : var.web_tier2_eip2
  }
}

