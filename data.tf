data "aws_vpc" "talent_academy" {

  filter {
    name   = "tag:Name"
    values = ["lab-vpc"]
  }
}

data "aws_subnet" "data-a" {

  filter {
    name   = "tag:Name"
    values = ["Data-a"]
  }
}

data "aws_subnet" "data-b" {

  filter {
    name   = "tag:Name"
    values = ["Data-b"]
  }
}

data "aws_security_group" "ansible-sg" {

  filter {
    name   = "tag:Name"
    values = ["ansible-server"]
  }
}