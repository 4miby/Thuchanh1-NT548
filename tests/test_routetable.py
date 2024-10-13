# tests/test_route_tables.py

import pytest

@pytest.mark.terraform("route_tables", directory="../modules/route_tables")
def test_route_tables_creation(tf_test):
    # Lấy outputs từ Terraform
    public_route_table_id = tf_test.output("public_route_table_id")
    private_route_table_id = tf_test.output("private_route_table_id")
    
    # Kiểm tra rằng Route Tables IDs không trống
    assert public_route_table_id is not None, "Public Route Table ID should not be empty"
    assert private_route_table_id is not None, "Private Route Table ID should not be empty"
