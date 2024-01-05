# MacOS

Use `pinentry-mac` to store passphrase in keychain

```bash
brew install pinentry-mac
bash -c 'echo "pinentry-program $(which pinentry-mac)" > $HOME/.gnupg/gpg-agent.conf'
```

# Restart gpg-agent

```bash
gpgconf --kill gpg-agent; and gpgconf --reload gpg-agent; and echo "done"
```
