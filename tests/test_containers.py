import os

import pytest
import toml
import yaml
from testcontainers.core.container import DockerContainer
from testcontainers.core.waiting_utils import wait_container_is_ready

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


def get_docker_image_from_file(path: str) -> str | None:
    if not os.path.isfile(path):
        raise Exception(f"Unable to find file: {path}")

    with open(path) as f:
        data: list[dict] = [yaml.load(f, Loader=yaml.SafeLoader)]
        while data:
            d = data.pop()
            if 'image' in d:
                return d['image']
            for k, v in d.items():
                if isinstance(v, dict):
                    data.append(v)

    raise Exception(f"Unable to find image in file: {path}")


def start_container(image: str):
    if image is None:
        raise Exception("Image can't be none")

    try:
        with DockerContainer(image) as container:
            wait_container_is_ready()
            return container
    except Exception as e:
        raise e
