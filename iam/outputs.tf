output "instance_profile_name" {
  value = aws_iam_instance_profile.emr_ec2_instance_profile.name
}

output "service_role_name" {
  value = aws_iam_role.emr_service_role.name
}
