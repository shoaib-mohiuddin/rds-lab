resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = "talent-academy-lab"
  subnet_id = data.aws_subnet.public.id

  tags = {
    Name = "Webserver"
  }
}

# resource "aws_eip" "ansible_server_ip" {
#   instance = aws_instance.ansible_server.id
#   vpc      = true
# }