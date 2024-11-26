locals {
  permission_boundary = file("./policy/AwsPermisisonBoundary.json")
  assume_role_ssm = file("./policy/assume_ssm_policy.json")
  kmsforssm = file("./policy/kmskeyforssm.json")
}

# Create a Permissions Boundary Policy
resource "aws_iam_policy" "permission_boundary_policy" {
  name        = "AwsPermisisonBoundary"
  description = "Permissions boundary for gitlab user limiting actions"
  policy = local.permission_boundary
}

# Create IAM Role for SSM
resource "aws_iam_role" "SSMRole" {
  name                = var.SSM_Role
  assume_role_policy  = local.assume_role_ssm
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"]
    inline_policy {
    name   = "kmskeyforssm"
    policy = local.kmsforssm
  }
}