function fish_prompt --description 'write out the prompt'
    set_color green --bold
    printf '%s' (prompt_pwd)
    set_color blue
    printf '%s ' (__fish_git_prompt)
    set_color normal
end
