data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "talent_academy" {

  filter {
    name   = "tag:Name"
    values = ["lab-vpc"]
  }
}

data "aws_subnet" "public" {

  filter {
    name   = "tag:Name"
    values = ["Public"]
  }
}

data "aws_subnet" "private" {

  filter {
    name   = "tag:Name"
    values = ["Private"]
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

data "aws_secretsmanager_secret" "mysql_passwd" {
  name = "mysql_db_passwd"
}

data "aws_secretsmanager_secret_version" "mysql_passwd_version" {
  secret_id = data.aws_secretsmanager_secret.mysql_passwd.id
}