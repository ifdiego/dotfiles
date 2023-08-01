function temp --description "pops into a temporary directory"
    pushd (mktemp -d)
end
