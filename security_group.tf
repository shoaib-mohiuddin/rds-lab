resource "aws_security_group" "database_sg" {
  name        = "Database-SG"
  description = "Enable MySQL/Aurora access on port 3306"
  vpc_id      = data.aws_vpc.talent_academy.id

  ingress {
    description      = "MySQL/Aurora access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.web_sg.id]
  }
  
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-sg"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow web inbound traffic"
  vpc_id      = data.aws_vpc.talent_academy.id

  ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["176.34.130.192/32"]
  }
  
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["176.34.130.192/32"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web-sg"
  }
}