provider "aws" {
  region = "us-west-2"
}

resource "random_pet" "server" {
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.rhel7.id
  instance_type = "t3.medium"
  key_name = "cdunlap-sandbox-aws"
  #name = random_pet.server.id
associate_public_ip_address = true

  tags = {
    Name = random_pet.server.id
  }
}

data "aws_ami" "rhel7" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-7.*_HVM-*x86_64*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["309956199498"] # Red Hat
}
