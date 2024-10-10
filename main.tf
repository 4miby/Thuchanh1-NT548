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
  key_name               = aws_key_pair.nhom6.key_name
  public_instance_count  = var.public_instance_count
  private_instance_count = var.private_instance_count
}

resource "aws_key_pair" "nhom6" {
  key_name   = "Nhom6"
  public_key = file("C:/Users/Amiby/.ssh/id_ed25519.pub")
}