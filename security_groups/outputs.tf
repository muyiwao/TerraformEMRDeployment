output "master_security_group_id" {
  value = aws_security_group.emr_master_sg.id
}

output "slave_security_group_id" {
  value = aws_security_group.emr_slave_sg.id
}
