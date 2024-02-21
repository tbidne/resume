#!/usr/bin/env bash

del_exists () {
  if [[ -e $1 ]]; then
    echo "Deleting $1"
    rm -rf $1
  fi
}

del_exists "build"
del_exists "result"