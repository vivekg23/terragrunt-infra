# Create Security Groups
resource "aws_security_group" "sg" {
  for_each = {
    "base-sg" = {
      name        = "${var.env}-base-security-group"
      description = "Base Security group for ${var.env}"
      vpc_id      = "${var.vpc_id}"
      ingress = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["50.238.225.232/29"]
          description = "Ferring Local"
        },
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["3.132.130.170/32"]
          description = "gitlab-runner-new"
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allow all outbound traffic"
        }
      ]
      tags = {
        "Name" = "${var.env}-Base-SecurityGroup"
      }
    }
/*
    ,
    "db-sg" = {
      name        = "db-sg"
      description = "Database Security Group"
      vpc_id      = "vpc-xxxxxx"
      ingress = [
        {
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_blocks = ["10.0.0.0/16"]
          description = "Allow MySQL"
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allow all outbound traffic"
        }
      ]
      tags = {
        "Name" = "Database Security Group"
      }
    }
*/
}

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  # Loop through the ingress rules defined for each security groups
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  # Loop through the egress rules defined for each security group
  dynamic "egress" {
    for_each = each.value.egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  # Tags for resource identification
  tags = each.value.tags
}

/*
# Create Security Groups
resource "aws_security_group" "sg" {
  for_each = { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  # Loop through the ingress rules defined for each security group
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
}
*/