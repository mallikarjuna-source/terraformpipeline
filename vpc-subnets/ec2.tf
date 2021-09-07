resource "aws_instance" "public-subnet-01" {
  ami                    = var.ami_id
  count                  = 1
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public-subnet.id
  key_name               = var.key_name
  user_data              = file("jenkins.sh")
  vpc_security_group_ids = aws_security_group.my-sg.*.id
  root_block_device {
    volume_size           = var.volume_size
    delete_on_termination = true
  }
  tags = {
    Name = "${var.environment}-Bastionhost"
  }
}

resource "aws_instance" "private-subnet-04" {
  ami                    = var.ami_id
  count                  = 1
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private-subnets[3].id
  key_name               = var.key_name
  user_data              = file("jenkins.sh")
  vpc_security_group_ids = aws_security_group.my-sg.*.id
  root_block_device {
    volume_size           = var.volume_size
    delete_on_termination = true
  }
  tags = {
    Name = "${var.environment}-Jenkins-server"
  }
}




resource "aws_security_group" "my-sg" {
  name        = "my-securitygroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name        = "my-securitygroup"
    Environment = "Dev"
  }
}