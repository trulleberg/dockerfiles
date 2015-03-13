#!/bin/bash

__create_user() {
# Create a user to SSH into as.
useradd user -G wheel
SSH_USERPASS="Passw0rd"
echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin user)
echo ssh user password: $SSH_USERPASS
}


__adjust_sshd() {
# Enable SSHD Password Auth
    sed -i \
        -e 's/^#*\(PasswordAuthentication\) .*/\1 yes/' \
        -e 's/^#*\(UsePAM\) .*/\1 no/' \
        /etc/ssh/sshd_config
}


# Call all functions
__create_user
__adjust_sshd
