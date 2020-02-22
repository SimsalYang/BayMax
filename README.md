# BayMax

A oh-my-posh Theme

## Set Font

Download and install Sarasa-Gothic from https://github.com/be5invis/Sarasa-Gothic .

Download zip package from release, then uppack and install all the font with prefix `sarasa-monoT-sc`.

set your terminal font to `Sarasa Mono T SC`

## Install

### Install posh-git and oh-my-posh

```powershell
Install-Module posh-git -Scope CurrentUser 
Install-Module oh-my-posh -Scope CurrentUser
```

### Create and modify your PowerShell profile

if this is your first time to use oh-my-posh, you need to create a profile as command like this:

```powershell
if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }
```

then use your favorite code editor to edit your profile, as most people use Visual Studio Code, your can use the command like this:

```powershell
code $PROFILE
```

edit the file and add contents:

```powershell
Import-Module posh-git 
Import-Module oh-my-posh 
Set-Theme Paradox
```

last line `Set-Theme Paradox` is the oh-my-posh theme.

save the profile then reopen the powershell, if everything is ok, you will see the new theme is running.

## Use my theme or create your own theme

open your oh-my-posh theme folder (~\Documents\WindowsPowerShell\Modules\oh-my-posh\<version>\Themes\), then create a file like `mytheme.psm1`, you can also copy my theme `BayMax.psm1` to this folder.

more about create your own theme please look up oh-my-posh (README.md)[https://github.com/JanDeDobbeleer/oh-my-posh].

use the command `Set-Theme mytheme` in PowerShell to test the output, if everything is done, edit the profile and modify `Set-Theme mytheme`, then reopen Powershell.

Congratulations! Your own theme is running.

---

## One more thing

This is my first time try writing in English, if you have any questions about my writing, please don't hesitate to submit a issue.
