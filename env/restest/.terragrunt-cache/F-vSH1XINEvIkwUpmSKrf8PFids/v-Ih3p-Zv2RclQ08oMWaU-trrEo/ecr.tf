# Create ECR Repos
resource "aws_ecr_repository" "repos" {
  for_each = toset(["pcluster-ami-builder-${var.env}"])
  #for_each = var.branch_name == "master" ? toset(var.ecr_repositories"-res") : toset(var.ecr_repositories-var.branch_name)
  name = each.key

  image_tag_mutability = "MUTABLE"  # Set to IMMUTABLE if you want to prevent overwriting tags
  encryption_configuration {
    encryption_type = "AES256"  # You can also use KMS if needed
  }
}

/*
# Create ECR Repos
resource "aws_ecr_repository" "repos" {
  for_each = toset(var.ecr_repositories)
  #for_each = var.branch_name == "master" ? toset(var.ecr_repositories"-res") : toset(var.ecr_repositories-var.branch_name)
  name = each.key

  image_tag_mutability = "MUTABLE"  # Set to IMMUTABLE if you want to prevent overwriting tags
  encryption_configuration {
    encryption_type = "AES256"  # You can also use KMS if needed
  }
}
*/
