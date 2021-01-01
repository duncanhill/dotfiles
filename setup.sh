#!/usr/bin/env bash

# ######################################################
# Dotfile Setup Script
# 
# Creates the symbolic links necessary for dotfile usage.
# ######################################################

# Enable xtrace if DEBUG is set.
if [[ ${DEBUG-} =~ ^1|yes|true$ ]]; then
  set -o xtrace
fi

# Set core behavior.
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

# Setup .emacs.d/
if [ -d "~/.emacs.d" ]; then
  echo "Directory already exists; skipping setup."
else
  mkdir ~/.emacs.d
  echo "Created directory ~/.emacs.d/; creating symbolic links:"

  cwd=$(pwd)

  for file in ./emacs/*; do
    base=$(basename $file)
    echo "$file => ~/.emacs.d/$base"

    ln -s $cwd/emacs/$base ~/.emacs.d/$base
  done

  echo "Done."
fi

