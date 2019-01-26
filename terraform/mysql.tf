resource "aws_security_group" "database_sg" {
  description = "Traffic allowed to database hosts"
  vpc_id      = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "db_sgr_allow_mysql" {
  security_group_id = "${aws_security_group.database_sg.id}"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  cidr_blocks       = ["${module.vpc.vpc_cidr_block}"]
  protocol          = "tcp"
}

resource "random_string" "vault_test_pw" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "vault_test" {
  allocated_storage    = "${var.db_allocated_storage}"
  storage_type         = "${var.db_storage_type}"
  engine               = "${var.db_engine}"
  engine_version       = "${var.db_engine_version}"
  instance_class       = "${var.db_instance_class}"
  name                 = "${var.db_name}"
  username             = "${var.db_username}"
  password             = "${random_string.vault_test_pw.result}"
  parameter_group_name = "${var.db_parameter_group_name}"
  db_subnet_group_name = "${module.vpc.database_subnet_group}"
  skip_final_snapshot  = true

  vpc_security_group_ids = ["${aws_security_group.database_sg.id}"]

  tags = "${var.tags}"
}

output "database_username" {
  value = "${aws_db_instance.vault_test.username}"
}

output "database_password" {
  value = "${aws_db_instance.vault_test.password}"
}

output "database_hostname" {
  value = "${aws_db_instance.vault_test.address}"
}

output "database_port" {
  value = "${aws_db_instance.vault_test.port}"
}

output "database_name" {
  value = "${aws_db_instance.vault_test.name}"
}
