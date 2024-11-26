# Configure the remote backend (S3)
remote_state {
    backend = "s3"
    config = {
        bucket      = "terragrunt-state-${path_relative_to_include()}"
        key         = "terragrunt-${path_relative_to_include()}.tfstate"
        region      = "us-east-2"
        encrypt     = true
    }
}

generate "provider" {
    path  =  "provider.tf"
    if_exists  =  "overwrite_terragrunt"

    contents = <<EOF
provider "aws" {
     region  =  "us-east-2"
}
EOF
}