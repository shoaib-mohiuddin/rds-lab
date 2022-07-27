resource "aws_security_group" "database-sg" {
  name        = "Database SG"
  description = "Enable MySQL/Aurora access on port 3306"
  vpc_id      = data.aws_vpc.talent_academy.id

  ingress {
    description      = "MySQL/Aurora access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [data.aws_security_group.ansible-sg.id]
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