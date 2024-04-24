import pytest
import toml

from helper import get_docker_image_from_file, start_container

containers = toml.load("resources/config.toml")['Docker']['files'].split(',')


@pytest.mark.parametrize("container", containers)
class TestContainers:

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, container: str):
        self.path = None
        if container.endswith('.yml') and container.startswith('docker/racknerd/'):
            self.path = container

    def test_container(self):
        if self.path is not None:
            try:
                image = get_docker_image_from_file(self.path)
            except Exception as e:
                assert False, e

            try:
                start_container(image)
            except Exception as e:
                assert False, e
