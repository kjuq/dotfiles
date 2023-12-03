set -q XDG_CONFIG_HOME; or set --export XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME; or set --export XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_DATA_HOME; or set --export XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME; or set --export XDG_STATE_HOME "$HOME/.local/state"

# Check if fisher is installed
if not functions -q fisher
    echo "========================="
    echo " Fisher is not installed"
    echo "  Execute `fisher_init`"
    echo "========================="
end
