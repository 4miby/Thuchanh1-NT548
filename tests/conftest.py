# tests/conftest.py

import pytest
from tftest import TerraformTest as Tftest

@pytest.fixture(scope="function")
def tf_test(request):
    """
    Fixture để thiết lập và dọn dẹp Terraform test cho một module cụ thể.
    Sử dụng `pytest` markers để truyền tham số module_name và directory.
    """
    marker = request.node.get_closest_marker("terraform")
    if marker is None:
        pytest.skip("No terraform marker provided")
    
    module_name = marker.args[0]
    directory = marker.kwargs.get("directory", f"../modules/{module_name}")
    
    tf = Tftest(module_name, directory)
    tf.setup()
    yield tf
    tf.destroy()
