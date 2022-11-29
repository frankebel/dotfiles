#!/bin/sh
git config filter.ignore_geometry.smudge 'sed "s/geometry=.*/geometry={random string}/"'
git config filter.ignore_geometry.clean 'sed "s/geometry=.*/geometry={random string}/"'
