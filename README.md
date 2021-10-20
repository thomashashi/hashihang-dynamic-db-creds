# hashihang-dynamic-db-creds
Securing Databases with Dynamic Credentials and HashiCorp Vault

Presented by Thomas Kula, Sr. Solutions Engineer

6 February 2019

## Recording Link

[Solutions Engineering Hangout: Securing Databases with Dynamic Credentials and HashiCorp Vault](https://www.youtube.com/watch?v=kW0Vi3RvbvA)

## Contents

This repository consists of two parts:

 * The scripts ran in the HashiHang which demonstrate some basic functionality of
   Vault's database secrets engine
 * some [Terraform](https://www.terraform.io/) configuration to provision the
   resources used by the demo

The demo is geared towards running on an Amazon Linux system using an AWS RDS MySQL
database, but with slight modification should be usable on any Unix-like system
talking to any MySQL database engine.

## Setup

### Using Terraform

**NOTE**: Using this will resources in AWS which will have a small but non-existent
cost.

If you wish to replicate the demo environment, the Terraform code in the `terraform`
directory will allow you to do so. 

1. Set the appropriate [environment variables](https://www.terraform.io/docs/providers/aws/index.html#environment-variables)
   which give Terraform access to your AWS account
2. Copy `terraform.auto.tfvars.example` to `terraform.auto.tfvars` and set the
   appropriate values in there
3. `terraform init`
4. `terraform plan -out=tf.plan`
5. `terraform apply tf.plan`

This will create an AWS RDS MySQL database and a small Amazon Linux EC2 instance
on which to run the demo. It will create a `demo_env.sh` file in the home
directory of the `ec2-user` user, which will be used in the 'Running' section.

### Manual Setup

You will need a Linux system and a MySQL database. Edit the `demo_env.sh` file
in this repository to point at your MySQL database, and copy it to the home
directory of the user on the machine you will be running the demo.

## Running

### Preparation

1. Check out this repository, and switch to the `demo-scripts` directory
2. `cp ~/demo_env.sh .` from either the 'Using Terraform' or 'Manual Setup' sections

### 001-setup

This script:

 1. Updates the Amazon Linux system
 2. Installs the `mysql` client and `jq` utility
 3. Downloads `vault` and `consul-template` and puts them in the `bin` directory
    in `demo-scripts`

If you do a manual setup, you can skip these steps, but the rest of the demo 
assumes that steps 2 and 3 have been done.

To run:

 1. `./001-setup`

### 002-setup-database

This script:

 1. Downloads the [Sakila Test Database](https://dev.mysql.com/doc/sakila/en/) just so
    we have some data to work with
 2. Creates a `.my-admin.cnf` file for the database administrative user

To run:

 1. `./002-setup`

### 003-start-vault

This script:

 1. Starts Vault in dev mode, putting the PID into `vault.pid` and the Vault log into `vault.log`.

To run:

 1. `./003-setup`

### 004-setup-database-secrets-engine

This script:

 1. Sets up the Vault database secrets engine
 2. Configures it to talk to our test database
 3. Creates two roles with different grants for use with that test database

To run:
 1. `./004-setup-database-secrets-engine`
 2. The script will print what it's doing and pause, to continue hit <enter>

### 005-basic-credentials

This script:

 1. Generates basic credentials for both roles created in '004-setup-database-secrets-engine'
    and demonstrates their usage

To run:
 1. `./005-basic-credentials`
 2. The script will print what it's doing and pause, to continue hit <enter>

### 006-policy-enforcement

This script:

 1. Shows how Vault policy enforces which entities can generate credentials for
    the two created database roles

To run:

 1. `./006-policy-enforcement`
 2. The script will print what it's doing and pause, to continue hit <enter>

### 007-consul-template

Previous scripts used either the Vault CLI or directly called Vault's RESTful
API. Many existing applications do not have that integration, so we demonstrate
how [consul-template](https://github.com/hashicorp/consul-template) can be
used to pull dynamic secrets out of Vault and render them in a file which
existing applications can read just like any other configuration file.

To run:
 1. `./007-consul-template`
 2. The script will print what it's doing and pause, to continue hit <enter>

### 008-lease-expiration

This script shows some of the advantages of using *dynamic credentials*: short lived,
per-instance secrets. We show a scenario where a single instance was affected, perhaps
it accidentially logged its database credentials, and how you can revoke that single
instance's access while still leaving the rest of your infrastructure unaffected. We
then show how you can revoke an entire class of secrets as a kind of emergency,
'break glass' process.

To run:
 1. `./008-lease-expiration`
 2. The script will print what it's doing and pause, to continue hit <enter>

### 999-cleanup

This script stops the Vault dev instance.

To run:

 1. `./999-cleanup`
