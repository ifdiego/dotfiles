function ignore --description "generate gitignore files"
    curl -fLw "\n" https://www.gitignore.io/api/$argv > .gitignore
end
