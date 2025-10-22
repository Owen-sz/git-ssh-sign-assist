#!/usr/bin/env bash

echo "You have started the git ssh setup script"

echo "Telling git to use autosign commits with ssh..."
git config --global gpg.format ssh
git config --global commit.gpgsign true

SSHKEY=~/.ssh/id_ed25519.pub
if [ -f "${SSHKEY}" ]; then
    echo "${SSHKEY} exists, you do not need to generate an SSH key."
else
    echo "${SSHKEY} does not exist. You will need to generate an SSH key. Do that now? (Y/N)"
    read -r generate
    if [[ ${generate} = "y" ]]; then
        ssh-keygen
    else
        echo "Skipping ssh key generation, you will not be able to sign commits unless you generate a key..."
    fi
fi

echo "Now that you have an SSH key, go to this link: https://github.com/settings/keys, then select 'New SSH key', give the key a name, change 'Key type' to 'Signing Key', and paste the below text into the 'Key' box:"
cat ${SSHKEY}

read -rp "Once completed, press Enter to continue" </dev/tty

echo "pointing git to your SSH key (${SSHKEY})..."
git config --global user.signingkey ~/.ssh/id_ed25519.pub

echo "What is your GitHub username?"
read -r ghuser
echo "What is your email you would like to use?"
read -r email

echo "Configuring git with your information... "
git config --global user.name "${ghuser}"
git config --global user.email "${email}"

echo "All done! Your git commits should be automatically signed with an SSH key now."
