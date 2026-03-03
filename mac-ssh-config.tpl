cat << EOF >> ~/Users/taborg/SSH/config

Host ${hostname}
    HostName ${hostname}
    User ${user}
    IdentityFile ${IdentityFile}
    EOF