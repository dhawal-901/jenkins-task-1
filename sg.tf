resource "aws_security_group" "my_public_sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "my_public_sg_Jenkins"
  description = "Allow ssh only"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    NAme = "PUBLIC_SG_Jenkins"
  }
}