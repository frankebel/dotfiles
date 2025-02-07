#!/bin/sh

# qt5ct
git config filter.ignore_geometry.smudge 'sed "s/geometry=.*/geometry={random string}/"'
git config filter.ignore_geometry.clean 'sed "s/geometry=.*/geometry={random string}/"'

# Ignore changes in the following files.
# Track again with `git update-index --no-skip-worktree`.
git update-index --skip-worktree home/.config/btop/btop.conf
