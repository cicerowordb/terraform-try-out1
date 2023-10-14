variable "aws_region" {
    default = "us-east-1"
}
variable "database_name" {
    default = "db1"
}
variable "database_storage" {
    default = [10, 50]
}
variable "database_instance" {
    default = ["db.t3.micro","db.t3.small"]
}
variable "sec_group_ids" {
    default = ["sg-ee6a9fff"]
    description = "using my default sec group"
}
variable "subnet_id" {
    default     = "subnet-10cfe376"
    description = "check your own subnet"
}
variable "ec2_instance" {
    default = ["t2.micro","t2.small","t2.medium"]
}
variable "bucket_name" {
    default = "bucket-s3-with-html-files-to-deploy-001100"
}
variable "resource_or_module_bucket" {
    default     = "resource"
    description = "fill with resource or module to create bucket"
}