Ta sẽ thực hiện tạo ssh key pair bằng câu lệnh sau:
ssh-keygen -t ed25519
Sau khi tạo key xong ta sẽ thay đường dẫn đến key ở file main.tf (Thư mục chính)
Thực hiện chạy các lệnh sau:
Terraform init
Terraform plan
Terraform apply -auto-approve
