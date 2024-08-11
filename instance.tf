data "aws_key_pair" "my_key" {
  key_name = "my_key"
}


resource "aws_instance" "my_public_instance" {
  ami                         = "ami-0ad21ae1d0696ad58"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.my_public_sg.id]
  key_name                    = data.aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  tags = {
    Name = "PUBLIC_INSTANCE_${terraform.workspace}"
  }
  depends_on = [aws_subnet.public_subnet, aws_security_group.my_public_sg, data.aws_key_pair.my_key]
}