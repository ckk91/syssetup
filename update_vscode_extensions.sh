#!/usr/bin/env bash

set -e

code --list-extensions >> vscode_extensions.list
sort vscode_extensions.list | uniq > vscode_extensions.list.tmp
mv vscode_extensions.list.tmp vscode_extensions.list