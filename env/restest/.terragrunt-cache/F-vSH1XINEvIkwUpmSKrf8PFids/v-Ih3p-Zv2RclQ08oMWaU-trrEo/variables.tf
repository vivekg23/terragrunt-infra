
# List of security group names and inbound rules
/*
variable "security_groups" {
  type = list(object({
    name        = string
    description = string
    vpc_id      = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = string
    }))
  }))
  default = [
    {
      name        = ""
      description = ""
      vpc_id      = ""
      ingress     = [
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
    },
    {
      name        = "Security Group 2"
      description = "Security group for application two"
      vpc_id      = "$(var.vpc)"
      ingress     = [
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
    }
  ]
}
*/

# List of S3 bucket names
#variable "bucket_names" {
#  type    = list(string)
#}

# List of ECR repository names
#variable "ecr_repositories" {
#  type    = list(string)
#}

variable "vpc_id" {
  description = "VPC ID for AWS accounts"
  type = string
}

# IAM Role for SSM
variable "SSM_Role" {
  type    = string
  default = "AWSSystemsManagerDefaultEC2InstanceManagementRole"
}

variable "kms_alias" {
  description = "KMS Alias name"
  type = string
  default = "alias/KMSForSSM"
}

variable "env" {
  description = "AWS Environment Name"
  type = string
}

variable "aws_account_id" {
  description = "AWS Account Number"
  type = number
}

variable "admin_principal_arn" {
  description = "AWS Account Number"
  type = list(string)
}

variable "ds-principal-arn" {
  description = "AWS Account Number"
  type = list(string)
}

variable "cross_account_arn" {
  description = "S3 Cross Account Access ARN for Restest"
  type = list(string)
}