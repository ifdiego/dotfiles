function setup-ssh-gpg --description "gpg and ssh setup"
    chmod 700 ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_rsa
    ssh -T git@github.com
    chmod 700 ~/.gnupg
    gpg --list-secret-keys --keyid-format=long
end
