source "$__fish_config_dir/configs/checkhealth.fish"

source "$__fish_config_dir/configs/variable.fish" # need to load first

source "$__fish_config_dir/configs/path.fish"
source "$__fish_config_dir/configs/alias.fish"
source "$__fish_config_dir/configs/function.fish"
source "$__fish_config_dir/configs/misc.fish"
source "$__fish_config_dir/configs/option.fish"

set --local localconf "$__fish_config_dir/config_local.fish"
if [ -e "$localconf" ]
	source "$localconf"
end
