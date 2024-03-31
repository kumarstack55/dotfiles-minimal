#!/bin/bash

die() {
  echo "$1"
  exit 1
}

[[ ! -f $HOME/.vimrc ]] || die ".vimrc exists."
cp dot.vimrc $HOME/.vimrc
