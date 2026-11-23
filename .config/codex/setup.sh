cd "$XDG_CONFIG_HOME/codex" || exit 1

cat config.toml.template | envsubst > config.toml

[ -e '/etc/codex' ] || sudo mkdir /etc/codex
envsubst < requirements.toml.template | sudo tee /etc/codex/requirements.toml > /dev/null
