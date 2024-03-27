module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.rhel7_5.id

  name = random_pet.server.id

  instance_type          = "t2.medium"
  key_name               = "cdunlap-sandbox-aws"
  monitoring             = false
  vpc_security_group_ids = ["sg-0381b141d26f97c58"]
  subnet_id              = "vpc-0b1e9d40163ab59fc"
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
resource "random_pet" "server" {
}

data "aws_ami" "rhel7_5" {
  most_recent = true

  owners = ["309956199498"] // Red Hat's account ID.

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["RHEL-7.5*"]
  }
}
