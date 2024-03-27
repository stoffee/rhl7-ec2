data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
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

resource "aws_instance" "rhel7_vault" {
 ami =  data.aws_ami.rhel7.id
 #ami =  data.aws_ami.ubuntu.id

   instance_type = var.instance_type
   vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  key_name = var.ssh_key_name

  #network_interface {
  #  network_interface_id = aws_network_interface.rhel7.id
  #  device_index         = 0
  #}

  tags = {
    Name = random_pet.server.id
    Owner = "chrisd"
    TTL   = "24"
  }
  user_data = data.template_file.cloud-init.rendered
}

data "template_file" "cloud-init" {
  template = file("cloud-init.tpl")

  vars = {
    #boinc_project_id = var.boinc_project_id
  }
}