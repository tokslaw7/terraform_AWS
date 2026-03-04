cat >> ~/SSH/config << EOF

Host ${hostname}
    HostName ${hostname}
    User ${user}
    IdentityFile ${IdentityFile}
EOF
