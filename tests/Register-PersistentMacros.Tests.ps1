#Requires -Version 7
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }

Describe 'Register-PersistentMacros' {
    BeforeAll {
        $script:scriptPath = (Resolve-Path (Join-Path $PSScriptRoot '..\Register-PersistentMacros.ps1')).Path
        $script:macroFile = Join-Path $TestDrive 'macros.json'
        $PersistentMacrosFile = $script:macroFile
        . $script:scriptPath
    }

    It 'registers sm, rm, and wm for slots 0-90' {
        foreach ($n in 0, 1, 9, 33, 90) {
            Get-Command -Name "sm$n" -CommandType Function -ErrorAction Stop | Should -Not -BeNullOrEmpty
            Get-Command -Name "rm$n" -CommandType Function -ErrorAction Stop | Should -Not -BeNullOrEmpty
            Get-Command -Name "wm$n" -CommandType Function -ErrorAction Stop | Should -Not -BeNullOrEmpty
        }
        { Get-Command -Name 'wm91' -CommandType Function -ErrorAction Stop } | Should -Throw
    }

    It 'peeks an empty slot without throwing' {
        wm8 | Should -Be 'No macro 8'
        wm33 | Should -Be 'No macro 33'
        wm90 | Should -Be 'No macro 90'
    }

    It 'reports an empty slot when replaying' {
        rm7 | Should -Be 'No macro 7'
    }

    It 'saves the last history command and persists JSON' {
        Add-History -InputObject ([pscustomobject]@{
                CommandLine        = "Write-Output 'macro-probe'"
                ExecutionStatus    = 'Completed'
                StartExecutionTime = (Get-Date).AddSeconds(-1)
                EndExecutionTime   = Get-Date
            })
        sm4
        wm4 | Should -Be "Write-Output 'macro-probe'"
        Test-Path -LiteralPath $script:macroFile | Should -BeTrue
        Get-Content -LiteralPath $script:macroFile -Raw | Should -Match 'macro-probe'
    }

    It 'saves a macro via -Cmd without requiring history' {
        sm3 -Cmd 'Get-Date -Format "yyyy-MM-dd"'
        wm3 | Should -Be 'Get-Date -Format "yyyy-MM-dd"'
        Get-Content -LiteralPath $script:macroFile -Raw | Should -Match 'Get-Date'
    }

    It 'keeps edge slots 0 and 90 independent' {
        sm0 -Cmd 'Write-Output slot-zero'
        sm90 -Cmd 'Write-Output slot-ninety'
        wm0 | Should -Be 'Write-Output slot-zero'
        wm90 | Should -Be 'Write-Output slot-ninety'
        rm90 | Should -Be 'slot-ninety'
        $saved = Get-Content -LiteralPath $script:macroFile -Raw | ConvertFrom-Json -AsHashtable
        $saved['0'] | Should -Be 'Write-Output slot-zero'
        $saved['90'] | Should -Be 'Write-Output slot-ninety'
    }

    It 'warns and does not save when -Cmd is empty' {
        $warning = sm2 -Cmd '' 3>&1
        $warning | Should -Match 'empty'
        wm2 | Should -Be 'No macro 2'
    }

    It 'replays a saved slot' {
        Add-History -InputObject ([pscustomobject]@{
                CommandLine        = '$global:PersistentMacroProbe = 42'
                ExecutionStatus    = 'Completed'
                StartExecutionTime = (Get-Date).AddSeconds(-1)
                EndExecutionTime   = Get-Date
            })
        sm5
        rm5
        $global:PersistentMacroProbe | Should -Be 42
    }
}
