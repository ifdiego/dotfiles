function fish_prompt
    set_color green
    printf '%s' (basename $PWD)
    set_color normal
    printf '%s' (__fish_git_prompt) ' $ '
end
