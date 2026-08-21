#Requires -Version 7
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }

Describe 'Register-PersistentMacros' {
    BeforeAll {
        $script:scriptPath = (Resolve-Path (Join-Path $PSScriptRoot '..\Register-PersistentMacros.ps1')).Path
        $script:macroFile = Join-Path $TestDrive 'macros.json'
        $PersistentMacrosFile = $script:macroFile
        . $script:scriptPath
    }

    It 'registers sm, rm, and wm for slots 1-9' {
        1..9 | ForEach-Object {
            Get-Command -Name "sm$_" -CommandType Function -ErrorAction Stop | Should -Not -BeNullOrEmpty
            Get-Command -Name "rm$_" -CommandType Function -ErrorAction Stop | Should -Not -BeNullOrEmpty
            Get-Command -Name "wm$_" -CommandType Function -ErrorAction Stop | Should -Not -BeNullOrEmpty
        }
    }

    It 'peeks an empty slot without throwing' {
        wm8 | Should -Be 'No macro 8'
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
