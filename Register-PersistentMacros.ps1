<#
.SYNOPSIS
    Nine sticky PowerShell command slots that survive new sessions.

.DESCRIPTION
    Dot-source from your PowerShell 7 $PROFILE. After you run a command worth
    keeping, smN saves it, rmN replays it, wmN peeks. Slots are 0-9.

    Bindings persist in JSON. Default path is ~/profile/macros.json. Set
    $PersistentMacrosFile to a different path before dot-sourcing if you want.

    Do not set StrictMode or $ErrorActionPreference in this file — it is dotted
    into the caller's session.

.EXAMPLE
    $persistentMacros = Join-Path $env:REPOS 'pwsh-persistent-macros\Register-PersistentMacros.ps1'
    if (Test-Path $persistentMacros) { . $persistentMacros }

.EXAMPLE
    $PersistentMacrosFile = Join-Path $HOME 'OneDrive\profile\macros.json'
    . .\Register-PersistentMacros.ps1
    Get-ChildItem
    sm1
    wm1
    rm1
#>

$macroFile = Join-Path $HOME 'profile\macros.json'
if (Get-Variable -Name PersistentMacrosFile -ErrorAction SilentlyContinue) {
    $candidate = Get-Variable -Name PersistentMacrosFile -ValueOnly
    if (-not [string]::IsNullOrWhiteSpace([string]$candidate)) {
        $macroFile = $candidate
    }
}

$global:PersistentMacrosPath = $macroFile
if (Test-Path -LiteralPath $global:PersistentMacrosPath) {
    $loaded = Get-Content -LiteralPath $global:PersistentMacrosPath -Raw | ConvertFrom-Json -AsHashtable
    $global:PersistentMacros = if ($null -eq $loaded) { @{} } else { $loaded }
}
else {
    $global:PersistentMacros = @{}
}

function global:Save-MacrosToDisk {
    $path = $global:PersistentMacrosPath
    $dir = Split-Path -Parent $path
    if ($dir -and -not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    $toSave = @{}
    $global:PersistentMacros.GetEnumerator() | ForEach-Object { $toSave["$($_.Key)"] = $_.Value }
    $toSave | ConvertTo-Json | Set-Content -LiteralPath $path
}

0..9 | ForEach-Object {
    $n = "$_"
    Set-Item -Path "function:global:sm$n" -Value {
        param(
            [string] $Cmd
        )
        if ($PSBoundParameters.ContainsKey('Cmd')) {
            if ([string]::IsNullOrWhiteSpace($Cmd)) {
                Write-Warning "-Cmd must not be empty."
                return
            }
            $global:PersistentMacros[$n] = $Cmd
        }
        else {
            $last = Get-History -Count 1
            if (-not $last) {
                Write-Warning "No history to save into macro $n."
                return
            }
            $global:PersistentMacros[$n] = $last.CommandLine
        }
        Save-MacrosToDisk
        Write-Host "Macro $n saved." -ForegroundColor Green
    }.GetNewClosure()

    Set-Item -Path "function:global:rm$n" -Value {
        if ($global:PersistentMacros[$n]) {
            Invoke-Expression -Command $global:PersistentMacros[$n]
        }
        else {
            "No macro $n"
        }
    }.GetNewClosure()

    Set-Item -Path "function:global:wm$n" -Value {
        if ($global:PersistentMacros[$n]) {
            $global:PersistentMacros[$n]
        }
        else {
            "No macro $n"
        }
    }.GetNewClosure()
}
