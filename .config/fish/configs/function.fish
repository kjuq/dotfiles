function fisher_init
    # The deletion below may be unnecessary when setting up a completely new environment
    set --local fisher_completions_path "$XDG_CONFIG_HOME/fish/completions/fisher.fish"
    if [ -f $fisher_completions_path ]
        command rm $fisher_completions_path
    end

    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; \
        and fisher install jorgebucaran/fisher

    fisher install rafaelrinaldi/pure
    fisher install decors/fish-colored-man
    fisher install kjuq/fish-pip-completion
    fisher install PatrickF1/fzf.fish

    set --export pure_color_current_directory normal # fisher_init to take effect
end

function po --description="Copy password from password-store (OSC52 compatible)"
	command pass show -c "$argv"; and pbpaste | osc52
end

# po completion

set -l PROG "po"

function __fish_pass_get_prefix
    if set -q PASSWORD_STORE_DIR
        realpath -- "$PASSWORD_STORE_DIR"
    else
        echo "$HOME/.password-store"
    end
end

function __fish_pass_needs_command
    [ (count (commandline -opc)) -eq 1 ]
end

function __fish_pass_uses_command
    set -l cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

function __fish_pass_print
    set -l ext $argv[1]
    set -l strip $argv[2]
    set -l prefix (__fish_pass_get_prefix)
    set -l matches $prefix/**$ext
    printf "%s\n" $matches | sed "s#$prefix/\(.*\)$strip#\1#"
end

function __fish_pass_print_entries
    __fish_pass_print ".gpg" ".gpg"
end

complete -c $PROG -f -n "__fish_pass_needs_command" -s c -l clip -d "Put password in clipboard"
complete -c $PROG -f -n "__fish_pass_needs_command" -a "(__fish_pass_print_entries)"
complete -c $PROG -f -n "__fish_pass_uses_command -c" -a "(__fish_pass_print_entries)"
complete -c $PROG -f -n "__fish_pass_uses_command --clip" -a "(__fish_pass_print_entries)"
