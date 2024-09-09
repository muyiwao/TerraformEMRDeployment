output "emr_cluster_id" {
  value = module.emr.emr_cluster_id
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "subnet_id" {
  value = module.network.subnet_id
}
