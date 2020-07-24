#!/usr/bin/env zsh

# first, install sdk manually :(
# https://sdkman.io/install
source "$HOME/.sdkman/bin/sdkman-init.sh"

main() {
  sdk list java
  sdk install java 8.0.262.hs-adpt

  sdk list sbt
  sdk install sbt 1.3.13
}

main

