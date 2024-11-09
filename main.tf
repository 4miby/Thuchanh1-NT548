provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "nat_gateway" {
  source            = "./modules/nat_gateway"
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "route_tables" {
  source              = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_ids     = module.nat_gateway.nat_gateway_ids
}

//test
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

module "ec2" {
  source                 = "./modules/ec2"
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  public_subnet_ids      = module.vpc.public_subnet_ids
  private_subnet_ids     = module.vpc.private_subnet_ids
  public_sg_id           = module.security_groups.public_sg_id
  private_sg_id          = module.security_groups.private_sg_id
  key_name               = aws_key_pair.ec2_keypair.key_name
  public_instance_count  = var.public_instance_count
  private_instance_count = var.private_instance_count
}


resource "local_file" "private_ec2_key" {
    filename                = "private_ec2_key.pem"
    file_permission         = "600"
    directory_permission    = "700"
    content                 = tls_private_key.ssh.private_key_pem
}

resource "aws_key_pair" "ec2_keypair" {
  key_name   = "ec2_keypair"
  public_key = tls_private_key.ssh.public_key_openssh
}
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
