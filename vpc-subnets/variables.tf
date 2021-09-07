variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "Region details"
}

variable "environment" {
  type    = string
  default = "Dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_cidr" {
  type    = string
  default = "10.0.5.0/24"
}

variable "private_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  type    = list(any)
  default = ["eu-west-1a", "eu-west-1b"]
}


variable "public_subnet_name" {
  type    = string
  default = "public-subnet-1"
}

variable "private_subnet_names" {
  type    = list(any)
  default = ["private-01", "private-02", "private-03", "private-04"]
}

variable "ami_id" {
  type    = string
  default = "ami-0a8e758f5e873d1c1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "volume_size" {
  type    = number
  default = 20
}

variable "key_name" {
  type    = string
  default = "ireland2"
}









variable "username" {
  type    = string
  default = "admin"

}

variable "password" {
  type    = string
  default = "mysql123"

}

variable "name" {
  type    = string
  default = "mydb"
}

variable "family" {
  type    = string
  default = "mysql8.0.23"
}



variable "port" {
  type    = number
  default = 3306
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0.23"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}