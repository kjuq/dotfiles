#!/usr/bin/env bash

brew install amar1729/formulae/browserpass
cd /opt/homebrew/lib/browserpass/ || exit
make PREFIX=/opt/homebrew hosts-vivaldi-user
make PREFIX=/opt/homebrew policies-vivaldi-user # install browser extension by cli
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> "$HOME/.gnupg/gpg-agent.conf"
