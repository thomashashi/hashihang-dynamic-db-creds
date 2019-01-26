module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.53.0"

  # Optional variables
  azs = "${data.aws_availability_zones.available.names}"
  cidr = "${var.vpc_cidr}"
  create_elasticache_subnet_group = false
  create_redshift_subnet_group = false
  database_subnet_tags = "${var.database_subnet_tags}"
  database_subnets = "${var.database_subnets}"
  default_vpc_name = "${var.default_vpc_name}"
  default_vpc_tags = "${var.default_vpc_tags}"
  enable_dns_hostnames = true
  name = "${var.default_vpc_name}"
  private_subnets = "${var.private_subnets}"
  private_subnet_tags = "${var.private_subnet_tags}"
  public_subnets = "${var.public_subnets}"
  public_subnet_tags = "${var.public_subnet_tags}"
  tags = "${var.tags}"
}
