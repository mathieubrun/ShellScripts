# Usage

Assuming you cloned this repository in `Documents/Github` folder.
## Bash

Edit .bash_profile and add :

```` sh
. ~/Documents/github/ShellScripts/bashrc.sh
````

## Powershell

Execute the following to open your profile file :

```` powershell
if (!(Test-Path $Profile)) {
    New-Item -Type file -Path $Profile -Force }
notepad $Profile
````

And add :

```` powershell
. "$([Environment]::GetFolderPath('MyDocuments'))\Github\ShellScripts\profile.ps1"
````