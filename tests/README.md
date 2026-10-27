# Container image smoke checks

[Repository overview](../README.md) · [Docker guide](../docker/README.md)

[test_containers.py](test_containers.py) reads Compose YAML, selects one
image from each supplied file, and uses Testcontainers to try starting
that image. This catches some unavailable or immediately failing images;
it is not a Compose integration or application readiness test.

## Run locally

Use Python 3.14 with `uv`, a working Docker daemon, network access to image
registries, and authentication for any private images:

```bash
uv sync
FILES=docker/racknerd/api/compose.yml uv run pytest tests/test_containers.py
```

For multiple files, use a comma-separated value without spaces:

```bash
FILES=docker/racknerd/api/compose.yml,docker/photo-server/immich/compose.yml uv run pytest tests/test_containers.py
```

`FILES` is read during test collection and must be set. Only `.yml` paths
starting with `docker/racknerd/` or `docker/photo-server/` are exercised.
Other paths, including Synology, pass through without starting an image;
a green result for such a path does not establish coverage.

## What the check actually does

The helper walks nested dictionaries and returns the first `image` value
it encounters. For a multi-service Compose file, it tests one selected
image, not every service. It does not resolve images inherited only
through a Compose runtime model beyond what the YAML loader reads.

The container starts without the Compose project's environment files,
networks, bind mounts, capabilities, ports, service dependencies, or
application-specific credentials. No explicit application readiness
assertion is made. A successful run does not prove that the stack starts
or that a database migration is safe.

Pair this smoke check with Compose configuration validation using the
intended host environment:

```bash
docker compose -f docker/racknerd/api/compose.yml config --quiet
```

Then verify health and real access paths after an authorized deployment.
Configuration validation alone does not start containers.

## CI and maintenance

[The compatibility workflow](../.github/workflows/docker-compatibility.yml)
runs for PRs to `beta` touching the two covered hosts' `compose.yml` files.
It obtains the file list through `diffs-no-merge.sh`. Main-branch PRs and
Synology changes do not independently trigger this workflow.

Add or update tests when changing deployment logic, image selection, or
validation scripts. **Review this guide with every testing change** and
update its scope, prerequisites, examples, and limitations in the same
change. Follow [the documentation checklist](../docs/documentation.md).
