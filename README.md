# pwsh-persistent-macros

[![CI](https://github.com/lundgren-greg/pwsh-persistent-macros/actions/workflows/ci.yml/badge.svg)](https://github.com/lundgren-greg/pwsh-persistent-macros/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Nine sticky PowerShell command slots that survive closing the terminal. After you run a command worth keeping, `sm3` saves it. `rm3` replays it in any later session. `wm3` shows what’s in the slot without running it.

This is for commands that are too specific to become a permanent alias, but too annoying to retype. `Ctrl+R` history is chronological and full of near-misses. These are nine sticky slots you choose.

## Load from `$PROFILE`

PowerShell 7. Clone this repo, then dot-source the script (same pattern as other profile helpers):

```powershell
$persistentMacros = Join-Path $env:REPOS 'pwsh-persistent-macros\Register-PersistentMacros.ps1'
if (-not (Test-Path $persistentMacros)) {
    $persistentMacros = Join-Path $HOME 'repos\pwsh-persistent-macros\Register-PersistentMacros.ps1'
}
if (Test-Path $persistentMacros) {
    . $persistentMacros
}
```

Optional: set `$PersistentMacrosFile` to a JSON path **before** the dot-source. Default is `~/profile/macros.json`.

```powershell
$PersistentMacrosFile = Join-Path $HOME 'OneDrive\profile\macros.json'
```

Do not pipe this file through `iex`. It runs in every shell; copy or clone it, then dot-source.

## Why it helps

A test filter you just got right. You don’t want that as a forever alias, and you don’t want to hunt it in history tomorrow.

```powershell
dotnet test .\tests\Foo.Tests --filter "FullyQualifiedName~Portage" -v n
sm1          # save the last command into slot 1
# close the terminal, come back next day
wm1          # peek first if you’re not sure what’s in the slot
rm1          # replay it
```

A one-liner for the repo you’re in this week.

```powershell
gh pr checks --watch
sm2
rm2          # later, same watch, no retyping
```

A long remote or container command.

```powershell
ssh user@build-box 'cd /srv/app && docker compose logs -f --tail 100 api'
sm3
```

Overwrite a slot by running a new command and `smN` again.

| | Save last command | Replay | Peek |
| --- | --- | --- | --- |
| Slot 1 | `sm1` | `rm1` | `wm1` |
| Slot 2 | `sm2` | `rm2` | `wm2` |
| … | … | … | … |
| Slot 9 | `sm9` | `rm9` | `wm9` |

## Requirements

- PowerShell 7+ (`pwsh`)
- Windows is the primary target; the script is ordinary PowerShell

## Test

```powershell
Invoke-Pester ./tests
```

## Security

`rmN` runs the saved text with `Invoke-Expression`. Treat `macros.json` as executable config: only save commands you ran yourself, and do not import someone else’s file. Details in [SECURITY.md](SECURITY.md).

## License

MIT. See [LICENSE](LICENSE).
