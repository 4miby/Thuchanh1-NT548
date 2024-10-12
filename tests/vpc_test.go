// project/test/vpc_test.go
package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVPC(t *testing.T) {
	t.Parallel()

	// Cấu hình Terraform options
	terraformOptions := &terraform.Options{
		// Đường dẫn đến thư mục chứa Terraform code (ở đây là thư mục gốc)
		TerraformDir: "../",

		// Các biến được truyền vào Terraform
		Vars: map[string]interface{}{
			"region":             "us-east-1",
			"vpc_cidr":           "10.0.0.0/16",
			"vpc_name":           "test-vpc",
			"public_subnets":     []string{"10.0.1.0/24", "10.0.2.0/24"},
			"private_subnets":    []string{"10.0.3.0/24", "10.0.4.0/24"},
			"availability_zones": []string{"us-east-1a", "us-east-1b"},
			"tags": map[string]string{
				"Environment": "test",
				"Project":     "Terraform Testing",
			},
		},

	}

	// Đảm bảo rằng Terraform sẽ dọn dẹp tài nguyên sau khi test hoàn thành
	defer terraform.Destroy(t, terraformOptions)

	// Khởi tạo và áp dụng cấu hình Terraform
	terraform.InitAndApply(t, terraformOptions)

	// Lấy output từ Terraform
	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	assert.NotEmpty(t, vpcID, "VPC ID should not be empty")

	// Kiểm tra CIDR của VPC
	actualVPCCIDR := terraform.Output(t, terraformOptions, "vpc_cidr")
	assert.Equal(t, "10.0.0.0/16", actualVPCCIDR, "VPC CIDR should match")
}
