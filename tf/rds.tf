#AWS RDS Setup
#Private subnets for RDS
resource "aws_subnet" "rds-1-private" {
        vpc_id = "${aws_vpc.main_vpc.id}"
        cidr_block = "10.0.6.0/24"
        map_public_ip_on_launch = "false"
        availability_zone = "us-west-2a"

        tags = {
                Name = "rds-1-private"
        }
}

resource "aws_subnet" "rds-2-private" {
        vpc_id = "${aws_vpc.main_vpc.id}"
        cidr_block = "10.0.7.0/24"
        map_public_ip_on_launch = "false"
        availability_zone = "us-west-2b"

        tags = {
                Name = "rds-2-private"
        }
}

resource "aws_db_subnet_group" "rds-private-subnet" {
  name = "rds-private-subnet-group"
  subnet_ids = ["${aws_subnet.rds-1-private.id}","${aws_subnet.rds-1-private.id}"]
}

resource "aws_security_group" "rds-sg" {
  name   = "my-rds-sg"
  vpc_id = "${aws_vpc.main_vpc.id}"

}

# Ingress Security Port 3306
resource "aws_security_group_rule" "mysql_inbound_access" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = "${aws_security_group.rds-sg.id}"
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

data "aws_kms_secrets" "rds-secret" {
  secret {
    name = "master-password"
    payload = "AQICAHhD9OU1o7S55854syOEEzE5zt7RzKbivSsSZTwdORTksAHq0shJgfWwCyLC9ExwUTPCAAAAcDBuBgkqhkiG9w0BBwagYTBfAgEAMFoGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMFwLFa3hEMRSbAva3AgEQgC02LaQGtB77ingDYPyQzG25XYmhbs5rqnjeASay3/bnMkDIfkfi0OypSkhlFmA="
  }
}

resource "aws_db_instance" "nova-db" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t2.micro"
  name                        = "nova-db"
  username                    = "admin"
  password                    = "${data.aws_kms_secrets.rds-secret.plaintext["master-password"]}"
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = "${aws_db_subnet_group.rds-private-subnet.name}"
  vpc_security_group_ids      = ["${aws_security_group.rds-sg.id}"]
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = true
  skip_final_snapshot         = true
}
