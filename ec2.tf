#aws-key
resource "aws_key_pair" "key_pair" {
  key_name   = "${var.env}-new-key"
  public_key = file("yourkey")
}

#vpc
resource "aws_default_vpc" "my-vpc" {
}

#security group
resource "aws_security_group" "my-sg-1" {
  name        = "my-sg-1-${var.env}"
  description = "Allow SSH and HTTP and flask"
  vpc_id      = aws_default_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "flask access"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all outbound access"
  }

  tags = {
    Name = "my-sg-1"
  }
}


resource "aws_instance" "my-ec2" {
  for_each = {
    SDO  = "t3.micro"
    SDO1 = "t3.micro"
  }
  ami                    = var.ami_id
  instance_type          = each.value
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my-sg-1.id]


  root_block_device {
    volume_size = var.storage_size
    volume_type = "gp3"
  }
  user_data = file("nginx.sh")
  tags = {
    Name = each.key
  }
}
