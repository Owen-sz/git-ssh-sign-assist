#!/usr/bin/env bash

BOLD='\033[1m'
RESET='\033[0m'

echo -e "${BOLD}You have started the git ssh setup script${RESET}"

echo ""

echo -e "${BOLD}First, let's set up git. What is your GitHub username?${RESET}"
read -r ghuser
echo "your GitHub username is ${ghuser}"
echo -e "${BOLD}What is your email you would like to use?${RESET}"
read -r email
echo "your email that git will use is ${email}"

echo ""

echo -e "${BOLD}Configuring git with your information...${RESET}"
git config --global user.name "${ghuser}"
git config --global user.email "${email}"

echo -e "${BOLD}Telling git to use autosign commits with ssh...${RESET}"
git config --global gpg.format ssh
git config --global commit.gpgsign true

echo ""

SSHKEY=~/.ssh/id_ed25519.pub
if [ -f "${SSHKEY}" ]; then
    echo -e "${BOLD}${SSHKEY} exists, you do not need to generate an SSH key.${RESET}"
else
    echo -e "${BOLD}${SSHKEY} does not exist. You will need to generate an SSH key. Do that now (note that SSH itself will run you through the keygen. Typically, you can just leave everything blank and press Enter)? (Y/N)${RESET}"
    read -r generate
    if [[ ${generate} = "y" ]]; then
        ssh-keygen
    else
        echo -e "${BOLD}Skipping ssh key generation, you will not be able to sign commits unless you generate a key...${RESET}"
    fi
fi

echo ""

echo -e "${BOLD}Now that you have an SSH key, go to this link: https://github.com/settings/keys, then select 'New SSH key', give the key a name, and paste the below text into the 'Key' box. NOTE: You will need to add this key to the settings again, but this time change 'Key type' to 'Authentication Key'.${RESET}"
cat ${SSHKEY}

echo ""

echo -e "${BOLD}Once completed, press Enter to continue${RESET}"
read completed

echo ""

echo -e "${BOLD}pointing git to your SSH key (${SSHKEY})...${RESET}"
git config --global user.signingkey ~/.ssh/id_ed25519.pub

echo ""

echo -e "${BOLD}All done! Your git commits should be automatically signed with an SSH key now.${RESET}"
