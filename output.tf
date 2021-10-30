output "aws_iam_instance_profile_arn_info" {
  value       = aws_iam_instance_profile.ec2_instance_profile.arn
  description = "Instance Profile ARN"
}

output "aws_iam_instance_profile_id_info" {
  value       = aws_iam_instance_profile.ec2_instance_profile.id
  description = "Instance Profile ID"
}

output "aws_iam_role_info" {
  value       =  aws_iam_role.ec2_iam_role.arn
  description = "IAM Role ARN"
}

output "aws_iam_role_policy_info" {
  value       = aws_iam_role_policy.ec2_iam_policy.id 
  description = "IAM Policy"
}

output "aws_s3_bucket_info" {
  value       = var.resource_or_module_bucket == "resource" ? aws_s3_bucket.bucket_html[0].arn : null
  description = "Bucket ARN"
}

output "aws_s3_module_info" {
  value       = var.resource_or_module_bucket == "module" ? module.s3_bucket[0] : null
}
output "aws_instance_arn_info" {
  value       = aws_instance.debian01.arn
  description = "Instance ARN"
}

output "aws_instance_id_info" {
  value       = aws_instance.debian01.id
  description = "Instance ID"
}

output "aws_eip_ec2_id_info" {
  value       = aws_eip.ec2_elastic_ip.id
  description = "Elastic IP ID"
}
output "aws_eip_ec2_pub_info" {
  value       = aws_eip.ec2_elastic_ip.public_ip
  description = "Public IP"
}
output "aws_eip_ec2_priv_info" {
  value       = aws_eip.ec2_elastic_ip.private_ip
  description = "Private IP"
}

output "aws_db_instance_address_info" {
  value = aws_db_instance.rds_db_instance.address
  description = "Database Address"
}

output "aws_db_instance_endpoint_info" {
  value = aws_db_instance.rds_db_instance.endpoint
  description = "Database Endipoint"
}

output "aws_db_instance_arn_info" {
  value = aws_db_instance.rds_db_instance.arn
  description = "Database ARN"
}
