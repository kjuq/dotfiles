#!/usr/bin/env bash

brew install amar1729/formulae/browserpass
PREFIX='/opt/homebrew/opt/browserpass' make hosts-vivaldi-user -f '/opt/homebrew/opt/browserpass/lib/browserpass/Makefile'
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" # >> "$XDG_CONFIG_HOME/gnupg/gpg-agent.conf"
