resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"
}