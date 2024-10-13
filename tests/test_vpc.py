import os
import tftest
import pytest

@pytest.fixture(scope="module")
def terraform():
    tf = tftest.Terraform()
    yield tf
    tf.destroy()

def test_vpc_creation(terraform):
    module_path = os.path.join(os.path.dirname(__file__), '../modules/vpc')
    terraform.plan(module_path)
    terraform.apply(module_path)

    assert terraform.output('vpc_id') is not None
