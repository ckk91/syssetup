#!/usr/bin/env bash
# Prepare Ubuntu VM for vbox guest addition installation

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install -y build-essential dkms linux-headers-$(uname-r)