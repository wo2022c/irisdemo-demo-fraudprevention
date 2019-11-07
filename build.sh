#!/bin/bash

set -e

printf "\nUpdating sub modules...\n"
git submodule init
git submodule update

make