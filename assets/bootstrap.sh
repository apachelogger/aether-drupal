#!/bin/sh

set -ex

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
echo "keyboard-configuration keyboard-configuration/layout select 'English (US)'" | debconf-set-selections
echo "keyboard-configuration keyboard-configuration/layoutcode select 'us'" | debconf-set-selections

apt update
apt install -y ruby sudo vim ruby-god

exec /tmp/assets/bootstrap.rb
