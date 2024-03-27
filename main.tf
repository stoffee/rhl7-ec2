provider "aws" {
  region = "us-west-2"
}

//*module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.rhel7.id

  name = random_pet.server.id

  instance_type          = "t2.medium"
  key_name               = "cdunlap-sandbox-aws"
  monitoring             = false
  vpc_security_group_ids = ["sg-0381b141d26f97c58"]
  subnet_id              = "subnet-09d65c88eea40de1b"
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}*//
resource "random_pet" "server" {
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.rhel7.id
  instance_type = "t3.medium"
  name = data.random_pet.server.id

  tags = {
    Name = "cdunlap"
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
