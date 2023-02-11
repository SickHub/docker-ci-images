#!/bin/bash

set -e

[ "latest" == "$1" ] && {
  shift
  . .venv/bin/activate
}
[ "11" == "$1" ] && {
  shift
  . .venv-ansible11/bin/activate
}
[ "12" == "$1" ] && {
  shift
  . .venv-ansible12/bin/activate
}
[ "13" == "$1" ] && {
  shift
  . .venv-ansible13/bin/activate
}

$@
