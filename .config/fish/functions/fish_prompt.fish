function fish_prompt --description 'write out the prompt'
    set_color blue --bold
    printf '%s' (prompt_pwd)
    set_color magenta
    printf '%s ' (__fish_git_prompt)
    set_color normal
end
