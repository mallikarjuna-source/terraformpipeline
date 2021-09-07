

resource "aws_db_instance" "mysql-db" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.name
  username               = var.username
  password               = var.password
 # parameter_group_name   = aws_db_parameter_group.dbParameterGroup.name
  db_subnet_group_name   = aws_db_subnet_group.dbSubnetGroup.name
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.securityGroup.id]
}

/*resource "aws_db_parameter_group" "dbParameterGroup" {
  name        = "${var.name}-rds-pg"
  family      = var.family
  description = "${var.name} RDS Parameter Group"
}*/

resource "aws_db_subnet_group" "dbSubnetGroup" {
  name       = "${var.name}-rds-sg"
  subnet_ids = [aws_subnet.private-subnets[1].id, aws_subnet.private-subnets[2].id]

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_security_group" "securityGroup" {
  name   = "${var.name}-rds-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = var.port
    protocol    = "TCP"
    to_port     = var.port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
