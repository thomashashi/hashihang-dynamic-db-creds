# Cross-module variables 

variable "ssh_key_name" {
  type = "string"
  description = "SSH key to use for EC2 resources"
}

variable "tags" {
  type = "map"
  description = "Tags to add to all resources"
}

# Variables for terraform-aws-vpc

variable "database_subnet_tags" {
  type = "map"
  description = "Tags to apply to terraform-aws-vpc database subnets"
}

variable "database_subnets" {
  type = "list"
  description = "List of database subnets for terraform-aws-vpc"
}

variable "default_vpc_name" {
  type = "string"
  description = "Name for default subnet in terraform-aws-vpc"
}

variable "default_vpc_tags" {
  type = "map"
  description = "Tags to add to terraform-aws-vpc default subnet"
}

variable "private_subnets" {
  type = "list"
  description = "Private subnet CIDR blocks for terraform-aws-vpc"
}

variable "private_subnet_tags" {
  type = "map"
  description = "Tags to add to private subnets in terraform-aws-vpc"
}

variable "public_subnets" {
  type = "list"
  description = "Public subnet CIDR blocks for terraform-aws-vpc"
}

variable "public_subnet_tags" {
  type = "map"
  description = "Tags to add to public subnets in terraform-aws-vpc"
}

variable "vpc_cidr" {
  type = "string"
  description = "CIDR block for terraform-aws-vpc"
}

# Database variables

variable "db_allocated_storage" {
  description = "Size in GB for database storage"
  type = "string"
  default = "10"
}

variable "db_storage_type" {
  description = "Storage type for database"
  type = "string"
  default = "gp2"
}

variable "db_engine" {
  description = "Database engine"
  type = "string"
  default = "mysql"
}

variable "db_engine_version" {
  description = "Version of the database engine"
  type = "string"
  default = "5.7"
}

variable "db_instance_class" {
  description = "Instance class to use for database"
  type = "string"
  default = "db.t2.micro"
}

variable "db_name" {
  description = "Database name"
  type = "string"
  default = "vault_test_db"
}

variable "db_username" {
  description = "Database administrative user"
  type = "string"
  default = "vault"
}

variable "db_parameter_group_name" {
  description = "Parameter group for database"
  type = "string"
  default = "default.mysql5.7"
}

# Vault

variable "vault_instance_type" {
  description = "Instance type for vault server"
  type = "string"
  default = "t2.micro"
}

variable "ami_name" {
    type = "string"
    description = "Name of Amazon Linux AMI to use"
    default = "amzn-ami-hvm-2017.09.0.20170930-x86_64-ebs"
}
