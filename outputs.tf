output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_instance_ips" {
  value = module.ec2.public_instance_ips
}

output "private_instance_ips" {
  value = module.ec2.private_instance_ips
}