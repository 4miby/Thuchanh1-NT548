region               = "us-east-1"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]
// Thay đổi thành ip, dải ip cụ thể
my_ip                = "0.0.0.0/0"
ami_id               = "ami-0866a3c8686eaeeba"
instance_type        = "t2.micro"
public_instance_count  = 1
private_instance_count = 1