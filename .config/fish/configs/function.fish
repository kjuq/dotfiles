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

if command --search --quiet nvim
    function nvimcopy --description="Open nvim for copying text"
        set --local tmp "/tmp/clip_tmp_nae18aA6ARaiOF"
        if [ (uname) = "Darwin" ]
            set --function head "ghead"
        else
            set --function head "head"
        end
        nvim -c "startinsert" "$tmp"; and [ -e "$tmp" ]; and "$head" -c -1 "$tmp" | pbcopy; and command rm "$tmp"
    end
end

function acw --description="View a problem on AtCoder"
    if not command --search --quiet w3m
        echo "Error: `w3m` not found"
        return 1
    end
    if test (count $argv) -ne 2
        echo -e "Error: Invalid argument.\nUsage: `acw abc290 a`"
        return 1
    end
    set --local sed_str          "s/\\\leq/<=/g;"
    set --local sed_str $sed_str "s/\\\geq/>=/g;"
    set --local sed_str $sed_str "s/\\\dots/.../g;"
    set --local sed_str $sed_str "s/\\\ldots/.../g;"
    w3m "https://atcoder.jp/contests/$argv[1]/tasks/$argv[1]_$argv[2]" | sed "$sed_str" | less
end

function cplus --description="Compile and execute a cpp file"
	set --local output "/tmp/cplus_output"
	cpl -o "$output" "$argv"; and "$output"; and command rm "$output"
end

if command --search --quiet oj
    function cpp-test --description="Test a cpp file with oj"
        if test (count $argv) -ne 1
            echo -e "Error: Invalid argument.\nUsage: `oj-test-cpp main.cpp`"
            return 1
        end
        cpl "$argv[1]"; and oj test --directory "tests/"; and command rm ./a.out
    end
    function python-test --description="Test a python file with oj"
        if test (count $argv) -ne 1
            echo -e "Error: Invalid argument.\nUsage: `oj-test-python main.py`"
            return 1
        end
        oj test --directory "tests/" -c "python3 $argv[1]"
    end
    if command --search --quiet acc
        function cpp-submit --description="Test then submit a cpp file"
            if test (count $argv) -ne 1
                echo -e "Error: Invalid argument.\nUsage: `oj-submit-cpp main.cpp`"
                return 1
            end
            cpp-test "$argv[1]"; and acc submit "$argv[1]"
        end
        function python-submit --description="Test then submit a python file in CPython"
            if test (count $argv) -ne 1
                echo -e "Error: Invalid argument.\nUsage: `oj-submit-python main.py`"
                return 1
            end
            python-test "$argv[1]"; and acc submit "$argv[1]" -- --language 5055
        end
        function pypy-submit --description="Test then submit a python file in PyPy"
            if test (count $argv) -ne 1
                echo -e "Error: Invalid argument.\nUsage: `oj-submit-pypy main.py`"
                return 1
            end
            python-test "$argv[1]"; and acc submit "$argv[1]" -- --guess-python-interpreter pypy
        end
    end
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
