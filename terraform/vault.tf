data "aws_ami" "amazon_linux_ami" {
    most_recent = true

    filter {
        name   = "owner-alias"
        values = ["amazon"]
    }

    filter {
        name   = "name"
        values = ["${var.ami_name}"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_security_group" "vault_sg" {
    description = "Traffic allowed to Vault hosts"
    vpc_id      = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "vault_sgr_egress_everything" {
    security_group_id = "${aws_security_group.vault_sg.id}"
    type              = "egress"
    protocol          = "-1"
    from_port         = 0
    to_port           = 0
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "vault_allow_internal_traffic" {
    security_group_id = "${aws_security_group.vault_sg.id}"
    type              = "ingress"
    from_port         = 0
    to_port           = 65535
    cidr_blocks       = ["${module.vpc.vpc_cidr_block}"]
    protocol          = "tcp"
}

resource "aws_security_group_rule" "vault_sgr_allow_ssh" {
    security_group_id = "${aws_security_group.vault_sg.id}"
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    cidr_blocks       = ["0.0.0.0/0"]
    protocol          = "tcp"
}

resource "aws_instance" "vault" {
    ami                    = "${data.aws_ami.amazon_linux_ami.id}"
    instance_type          = "${var.vault_instance_type}"
    vpc_security_group_ids = ["${aws_security_group.vault_sg.id}"]
    subnet_id              = "${module.vpc.public_subnets[0]}"
    key_name               = "${var.ssh_key_name}"

    associate_public_ip_address    = true

    tags = "${merge(map("Name", "vault-server"), var.tags)}"

    provisioner "file" {
        destination = "/home/ec2-user/demo_env.sh"
        content = <<-EOT
export DB_USERNAME="${aws_db_instance.vault_test.username}"
export DB_PASSWORD="${aws_db_instance.vault_test.password}"
export DB_HOSTNAME="${aws_db_instance.vault_test.address}"
export DB_PORT="${aws_db_instance.vault_test.port}"
export DB_NAME="${aws_db_instance.vault_test.name}"
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_ROOT_TOKEN=vault-root-token
	EOT
        connection {
            type = "ssh"
            user = "ec2-user"
        }
    }
}

output "vault_host" {
  value = "${aws_instance.vault.public_dns}"
}
