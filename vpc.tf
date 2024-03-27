resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "rhel7" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_network_interface" "rhel7" {
  subnet_id   = aws_subnet.rhel7.id
  private_ips = ["172.16.10.100"]
}