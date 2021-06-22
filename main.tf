data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "nvibert-organization"
    workspaces = {
      name = "terraform-aws-sentinel"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_eip" "eip" {
  instance = data.terraform_remote_state.vpc.outputs.instance_ami_id
  vpc      = true
}

output "eip" {
  value = aws_eip.eip.public_ip
}
