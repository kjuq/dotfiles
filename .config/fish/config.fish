set --local localinitpre "$__fish_config_dir/configs/local/initpre.fish"
if [ -e "$localinitpre" ]
	source "$localinitpre"
end

source "$__fish_config_dir/configs/checkhealth.fish"

source "$__fish_config_dir/configs/variable.fish" # need to load first

source "$__fish_config_dir/configs/path.fish"
source "$__fish_config_dir/configs/alias.fish"
source "$__fish_config_dir/configs/function.fish"
source "$__fish_config_dir/configs/misc.fish"
source "$__fish_config_dir/configs/option.fish"

set --local localinitpost "$__fish_config_dir/configs/local/initpost.fish"
if [ -e "$localinitpost" ]
	source "$localinitpost"
end
