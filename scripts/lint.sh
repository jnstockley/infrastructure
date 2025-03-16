#!/usr/bin/env bash

# Run linter
yamllint -s .
npx dclint -r --max-warnings 0 docker/
find . -type f \( -name '*.sh' -o -name '*.bash' -o -name '*.ksh' -o -name '*.bashrc' -o -name '*.bash_profile' -o -name '*.bash_login' -o -name '*.bash_logout' \) -print0 | xargs -0 shellcheck -x -S style
shfmt --diff -i 4 -ci .
tofu validate
tofu fmt -recursive
uvx ruff check
uvx ruff format --check
