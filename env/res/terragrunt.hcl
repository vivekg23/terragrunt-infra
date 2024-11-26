locals {
  # Setting environment variables directly within terragrunt.hcl
  env = "res"
  aws_account_id = 872515248080
  vpc_id = "vpc-04f771195cc2b72d2"
  ADM_SSOROLE_ARN = "arn:aws:iam::872515248080:role/aws-reserved/sso.amazonaws.com/us-east-2/AWSReservedSSO_ADM-RES_baee00816b4fdc1b"
  DS_SSOROLE_ARN = ""
  SE_SSOROLE_ARN = ""
  cross_account_arn_res = "["arn:aws:iam::342606863765:root", "arn:aws:iam::755666072998:root", "arn:aws:iam::464457062066:root", "arn:aws:iam::088805809104:root", "arn:aws:iam::529088267411:root"]"
}

include "root" {
    path  =  find_in_parent_folders()
}

terraform {
  source = "../../modules"
}

inputs = {
    env = local.env
    aws_account_id = local.aws_account_id
    ADM_SSOROLE_ARN = local.ADM_SSOROLE_ARN
    DS_SSOROLE_ARN = local.DS_SSOROLE_ARN
    SE_SSOROLE_ARN = local.SE_SSOROLE_ARN
    cross_account_arn = local.cross_account_arn_res
    vpc_id = local.vpc_id
    admin_principal_arn = ["${local.ADM_SSOROLE_ARN}"]
    ds-principal-arn = [""]
    /*
    ecr_repositories = ["pcluster-ami-builder-${local.env}"]
    bucket_names = ["rbx-annotations-${local.env}","rbx-assemblies-${local.env}","rbx-patch-logs-${local.env}","rbx-references-${local.env}","rbx-samples-${local.env}","rbx-scratch-${local.env}","rbx-verifications-${local.env}"]  # Add your bucket names here
    security_groups =   [  {
      name        = "${local.env}-base-security-group"
      description = "Security group for application one"
      vpc_id      = "${local.vpc_id}"
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
      ,
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
*/


}