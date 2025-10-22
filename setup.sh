#!/usr/bin/env bash

BOLD='\033[1m'
RESET='\033[0m'

echo -e "${BOLD}You have started the git ssh setup script${RESET}"

echo ""

while true; do

    echo -e "${BOLD}First, let's set up git. What is your GitHub username? ${RESET}"
    read -r ghuser
    echo -e "${BOLD}What email you would like to use to sign commits? ${RESET}"
    read -r email
    echo ""
    echo -e "${BOLD}Username:${RESET} ${ghuser} \n${BOLD}Email:${RESET} ${email}\n${BOLD}Is this correct? (Y/N): ${RESET}"
    read -r confirm

    case "$confirm" in
        [Yy]* ) break ;;
        [Nn]* ) echo "Let's try again." ;;
        * ) echo "Please answer Y or N." ;;
    esac
done

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
    echo ""
    echo -e "${BOLD}Since you already have an SSH key, follow these steps to add it to your GitHub account:\n (1)${RESET} Go to this link: https://github.com/settings/keys\n ${BOLD}(2)${RESET} Select 'New SSH key'\n ${BOLD}(3)${RESET} Give the key a name\n ${BOLD}(4)${RESET} Paste the entire SSH key down below into the 'Key' box\n ${BOLD}(5)${RESET} Follow the previous steps again to add a second key, but this time change 'Key type' to 'Authentication Key' after naming it on Step 3\n\n${BOLD}SSH Key (copy the entire non-bold text below, refer to Step 4 above):${RESET}"
    cat ${SSHKEY}
    echo ""
else
    echo -e "${BOLD}${SSHKEY} does not exist. You will need to generate an SSH key. Do that now (note that SSH itself will run you through the keygen. Typically, you can just leave everything blank and press Enter)? (Y/N)${RESET}"
    read -r generate
    echo ""
    if [[ ${generate} = "y" ]]; then
        ssh-keygen
        echo -e "${BOLD}Now that you have an SSH key, follow these steps to add it to your GitHub account:\n (1)${RESET} Go to this link: https://github.com/settings/keys\n ${BOLD}(2)${RESET} Select 'New SSH key'\n ${BOLD}(3)${RESET} Give the key a name\n ${BOLD}(4)${RESET} Paste the entire SSH key down below into the 'Key' box\n ${BOLD}(5)${RESET} Follow the previous steps again to add a second key, but this time change 'Key type' to 'Authentication Key' after naming it on Step 3\n\n${BOLD}SSH Key (copy the entire non-bold text below, refer to Step 4 above):${RESET}"
        cat ${SSHKEY}
        echo ""
    else
        echo -e "${BOLD}Skipping SSH key generation, you will not be able to sign commits unless you generate a key...${RESET}"
        echo ""
    fi
fi

echo -e "${BOLD}Once completed, press Enter to continue${RESET}"
read completed

echo ""

echo -e "${BOLD}pointing git to your SSH key (${SSHKEY})...${RESET}"
git config --global user.signingkey ~/.ssh/id_ed25519.pub

echo ""

echo -e "${BOLD}All done! Your git commits should be automatically signed with an SSH key now.${RESET}"
