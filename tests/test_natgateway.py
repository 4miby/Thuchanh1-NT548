# tests/test_nat_gateway.py

import pytest

@pytest.mark.terraform("nat_gateway", directory="../modules/nat_gateway")
def test_nat_gateway_creation(tf_test):
    # Lấy outputs từ Terraform
    nat_gateway_id = tf_test.output("nat_gateway_id")
    
    # Kiểm tra rằng NAT Gateway ID không trống
    assert nat_gateway_id is not None, "NAT Gateway ID should not be empty"
