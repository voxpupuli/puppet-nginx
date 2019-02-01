#!/bin/sh

# THIS FILE IS MANAGED BY MODULESYNC

rm -f Gemfile.lock
gem update --system
gem update bundler
bundle --version
