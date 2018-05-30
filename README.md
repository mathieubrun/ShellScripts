# Usage

Assuming you cloned this repository in `Documents/Github` folder.
## Bash

Edit .bash_profile and add :

```` sh
. ~/github/shell-scripts/bash_profile.sh
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
. "$home\github\shell-scripts\profile.ps1"
````