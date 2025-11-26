if not status is-interactive
	exit 1
end

source "$__fish_config_dir/configs/variable.fish" # need to load first
source "$__fish_config_dir/configs/path.fish"
source "$__fish_config_dir/configs/alias.fish"
source "$__fish_config_dir/configs/function.fish"
source "$__fish_config_dir/configs/misc.fish"
source "$__fish_config_dir/configs/option.fish"
source "$__fish_config_dir/configs/prompt.fish"

if ! [ "$_KJUQ_FISH_CONFIG_LOADED" = '0' ];
	set --export _KJUQ_FISH_CONFIG_LOADED 1
end
