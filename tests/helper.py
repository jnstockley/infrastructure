import os

import yaml
from testcontainers.core.container import DockerContainer
from testcontainers.core.waiting_utils import wait_container_is_ready


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
            delay = wait_container_is_ready()
            return container
    except Exception as e:
        raise e
