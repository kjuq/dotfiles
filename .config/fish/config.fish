if not status is-interactive
	exit 1
end

if [ -e "$__fish_config_dir/configs/localpre.fish"  ]
	source "$__fish_config_dir/configs/localpre.fish"
end

source "$__fish_config_dir/configs/variable.fish" # need to load first
source "$__fish_config_dir/configs/path.fish"
source "$__fish_config_dir/configs/alias.fish"
source "$__fish_config_dir/configs/misc.fish"
source "$__fish_config_dir/configs/prompt.fish"
source "$__fish_config_dir/configs/c.fish"

if [ -e "$__fish_config_dir/configs/localpost"  ]
	source "$__fish_config_dir/configs/localpost.fish"
end

if ! [ "$_KJUQ_FISH_CONFIG_LOADED" = '0' ];
	set --export _KJUQ_FISH_CONFIG_LOADED 1
end
