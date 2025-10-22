# git-ssh-sign-assist

This is a simple utility to assist with setting up SSH signing with git/GitHub, because I always forget how to do it lol.
This is a 'run once' script typically meant for a freshly installed system, but it can also detect and use an existing SSH key (~/.ssh/id_ed25519.pub) if you already have one present.

## Usage

Clone this repo:

`git clone https://github.com/Owen-sz/git-ssh-sign-assist.git`

cd into the folder:

`cd git-ssh-sign-assist`

Run `setup.sh`:

`bash setup.sh`

Catch-all script:

`git clone https://github.com/Owen-sz/git-ssh-sign-assist.git && cd git-ssh-sign-assist && bash setup.sh`

## Why would you go out of your way to script such a simple thing?

Because I have so many computers that this will actually save me time.
