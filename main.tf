### Provider configures the service we will access
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.21.0"
    }
  }
}

provider "aws" {
  region       = var.aws_region
  # access_key = "ACCESS_KEY"
  # secret_key = "SECRET_KEY"
  # token      = "ACCESS_TOKEN"
}

### RDS Instance for Database
resource "aws_db_instance" "rds_db_instance" {
  # name                    = var.database_name #DEPRECATED
  allocated_storage       = var.database_storage[0]
  max_allocated_storage   = var.database_storage[1]
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = var.database_instance[0]
  username                = "databaseadmin"
  password                = "123qweasdzxc123qweasdzxc"
  skip_final_snapshot     = true
  vpc_security_group_ids  = var.sec_group_ids
}

### IAM Role Policy has the permission to an AWS service
resource "aws_iam_role_policy" "ec2_iam_policy" {
  name = "EC2-IAM-Policy-Cicerow"
  role = aws_iam_role.ec2_iam_role.id
  policy = "${file("permission.json")}"
}

### IAM Role is a permission apply to an AWS Service
resource "aws_iam_role" "ec2_iam_role" {
  name = "EC2-IAM-Role-Cicerow"
  assume_role_policy = "${file("assumerole.json")}"
}

### IAM Instance Profile is a configuration to a EC2 Instance
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2-Instance-Profile-Cicerow"
  role = aws_iam_role.ec2_iam_role.name
}

### Configuration with a private IP
resource "aws_network_interface" "ec2_private_ip" {
  subnet_id   = var.subnet_id
  private_ips = ["172.31.0.100"]
}

### Elastic IP to EC2 Instance
resource "aws_eip" "ec2_elastic_ip" {
  # vpc           = true #DEPRECATED
  instance      = aws_instance.debian01.id
  tags = {
    Name        = "Debian01-EP-Cicerow"
    Environment = "Production"
    Project     = "TerraformTest"
  }
}

### AWS Instance is the instance itself
resource "aws_instance" "debian01" {
  ami                  = "ami-07d02ee1eeb0c996c" #Image Debian in North Virginia
  instance_type        = var.ec2_instance[0]
  key_name             = "terraform-try-out"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  network_interface {
    network_interface_id = aws_network_interface.ec2_private_ip.id
    device_index         = 0
  }
  tags = {
    Name               = "Debian01-Cicerow"
    Environment        = "Production"
    Contact            = "Cicero Woshington <cicerow.ordb@gmail.com>"
    Project            = "TerraformTest"
  }
  user_data = "${replace(file("init-server.sh"), "---DATABASE---", "${aws_db_instance.rds_db_instance.address}")}"
}

### AWS S3 Bucket is the bucket itself
resource "aws_s3_bucket" "bucket_html" {
  count = var.resource_or_module_bucket == "resource" ? 1 : 0
  bucket        = var.bucket_name
  #acl           = "private" #DEPRECATED
  force_destroy =  true
}
### Or use templates in ./s3-templates
module "s3_bucket" {
  count = var.resource_or_module_bucket == "module" ? 1 : 0
  # Use one of these only, they use same bucket name
  #source = "./s3-templates/public-website"
  source = "./s3-templates/version-lifecycle"
}