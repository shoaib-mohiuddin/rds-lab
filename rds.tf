resource "aws_db_instance" "ta-rds-mysql" {
  identifier = "mysqldb"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "movies_db"
  username             = var.username
  password             = var.password
  #parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.ta-rds-subnets.name
  multi_az = true
  backup_retention_period = 1
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.database-sg.id]
}

resource "aws_db_subnet_group" "ta-rds-subnets" {
  name       = "db-subnet-group"
  subnet_ids = [data.aws_subnet.data-a.id, data.aws_subnet.data-b.id]

  tags = {
    Name = "DB Subnet Group"
  }
}