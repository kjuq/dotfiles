#!/usr/bin/env bash

script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$script_dir" || exit 1

cat cli.json.template > cli.json
cat opencode.jsonc.template | tail -n +4 | jq --arg key "$(pass sakura.ad.jp/llm_token)" '.providers.sakura.settings.apiKey = $key' > opencode.jsonc
