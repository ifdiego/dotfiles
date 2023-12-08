function fish_prompt
	set_color white
	printf '%s' "["(date "+%H:%M")"] "
    set_color blue --bold
	printf '%s' (prompt_pwd)
    set_color normal
	printf '%s' (__fish_git_prompt)
	printf ' > '
	set_color normal
end
