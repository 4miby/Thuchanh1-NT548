# tests/test_ec2.py
import tftest
import pytest

@pytest.fixture(scope="module")
def terraform():
    tf = tftest.TerraformTest("ec2", "d:/TaiLieu/HKVII/devsecops/lab/lab01-collaboration/Thuchanh1-NT548/modules/ec2")  # Ensure this path is correct
    yield tf
    tf.destroy()

def test_ec2_instances_creation(terraform):
    plan = terraform.plan()
    assert 'No changes. Infrastructure is up-to-date.' not in plan
    terraform.apply()
    instance_ids = terraform.output('instance_id')
    assert instance_ids is not None
