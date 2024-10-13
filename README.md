# Sử dụng Terraform để quản lý cơ sở hạ tầng trên AWS

## Giới thiệu

Sử dụng Terraform để triển khai VPC - Virtual Private Cloud trên cơ sở hạ tầng AWS, bao gồm các EC2 instances trong public và private subnet, NAT gateway, Internet Gateway cũng như các rule, security groups cần thiết để đảm bảo tính bảo mật cho các thành phần trong VPC.

## Cấu trúc file

```plaintext
.
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── route_tables/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── nat_gateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security_groups/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf
├── variables.tf
└── outputs.tf
```

## Hướng dẫn cài đặt
1. **Cài đặt Terraform**: Cài đặt Terraform từ trang chủ Terraform.
2. **Cấu hình AWS Credentials**: Cài đặt AWS CLI và sử dụng lệnh ```aws configure ``` để cấu hình cho phép Terraform tương tác với các tài nguyên của AWS
3. **Clone Github Project và chạy code Terraform**:
  ```
  git clone https://github.com/4miby/Thuchanh1-NT548
  cd Thuchanh1-NT548
  ```
4. **Chạy code Terraform**:
   1. Thực hiện chỉnh sửa các biến nếu cần thiết trong file ``terraform.tfvars``
   2. Khởi tạo Terraform Project
      ```
      terraform init
      ```
   3. Kiểm tra các tài nguyên mà Terraform sẽ tạo trước khi triển khai
      ```
      terraform plan
      ```
      *Ở sau bước này các tài nguyên được tạo sẽ hiển thị trên CLI*
   4. Triển khai lên AWS
      ```
      terraform apply
      ```
      *Ở bước này, có thể sử dụng option ``-auto-approve`` để quá trình triển khai diễn ra tự động, bỏ qua bước xác thực bằng tay*
   5. Dọn dẹp tài nguyên
      ```
      terraform destroy
      ```
