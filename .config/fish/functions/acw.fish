function acw --description='Usage: acw abc290 a'
    if test (count $argv) -ne 2
        echo "Not enough arguments. Usage: acw abc290 a"
        return 1
    end
    set --local sed_str          "s/\\\leq/<=/g;"
    set --local sed_str $sed_str "s/\\\geq/>=/g;"
    set --local sed_str $sed_str "s/\\\dots/.../g;"
    set --local sed_str $sed_str "s/\\\ldots/.../g;"
    w3m "https://atcoder.jp/contests/$argv[1]/tasks/$argv[1]_$argv[2]" | sed "$sed_str" | less
end
