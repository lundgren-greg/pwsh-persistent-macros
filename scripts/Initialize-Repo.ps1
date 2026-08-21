<#
.SYNOPSIS
    Fill repo-template placeholders and install the matching CI workflow.

.DESCRIPTION
    Run once after creating a repo from lundgren-greg/repo-template.

    Replaces __PROJECT_NAME__, __PROJECT_DESCRIPTION__, __YEAR__, and __TODAY__
    across text files, copies the stack CI workflow, strips the template intro
    from README.md, and optionally writes a Grok-Context thread.

.EXAMPLE
    .\scripts\Initialize-Repo.ps1 -Name my-project -Description "One-line pitch" -Stack DotNet
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[A-Za-z0-9][A-Za-z0-9._-]*$')]
    [string]$Name,

    [Parameter()]
    [string]$Description = "TODO: one-line project description.",

    [Parameter()]
    [ValidateSet("DotNet", "PowerShell", "Python", "Node", "Rust", "Generic")]
    [string]$Stack = "Generic",

    [Parameter()]
    [string]$Owner = "lundgren-greg",

    [Parameter()]
    [switch]$SkipGrokContext
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$today = Get-Date -Format "yyyy-MM-dd"
$year = Get-Date -Format "yyyy"

$stackFile = @{
    DotNet     = "dotnet.yml"
    PowerShell = "powershell.yml"
    Python     = "python.yml"
    Node       = "node.yml"
    Rust       = "rust.yml"
    Generic    = "generic.yml"
}

$replacements = [ordered]@{
    "__PROJECT_NAME__"        = $Name
    "__PROJECT_DESCRIPTION__" = $Description
    "__GITHUB_OWNER__"        = $Owner
    "__YEAR__"                = $year
    "__TODAY__"               = $today
}

$textExtensions = @(
    ".md", ".yml", ".yaml", ".json", ".ps1", ".cs", ".csproj", ".sln",
    ".props", ".targets", ".xml", ".xaml", ".txt", ".gitignore",
    ".gitattributes", ".editorconfig", ".example"
)

$skipDirNames = @(".git", "node_modules", "bin", "obj", "target", ".venv", "venv")

function Test-IsTextFile {
    param([System.IO.FileInfo]$File)
    if ($textExtensions -contains $File.Extension) { return $true }
    if ($File.Name -in @("LICENSE", "CODEOWNERS", "Dockerfile", "Makefile")) { return $true }
    return $false
}

function Get-RepoTextFile {
    Get-ChildItem -Path $repoRoot -Recurse -File -Force | Where-Object {
        $relative = $_.FullName.Substring($repoRoot.Length)
        $skip = $false
        foreach ($dir in $skipDirNames) {
            if ($relative -match [regex]::Escape([IO.Path]::DirectorySeparatorChar + $dir + [IO.Path]::DirectorySeparatorChar)) {
                $skip = $true
                break
            }
        }
        if ($skip) { return $false }
        if ($_.Name -eq "Initialize-Repo.ps1") { return $false }
        return (Test-IsTextFile -File $_)
    }
}

function Set-FileContent {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [System.IO.FileInfo]$File,

        [Parameter(Mandatory)]
        [scriptblock]$Transform
    )
    $original = [System.IO.File]::ReadAllText($File.FullName)
    $updated = & $Transform $original
    if ($updated -ne $original) {
        if ($PSCmdlet.ShouldProcess($File.FullName, "Update file")) {
            $utf8NoBom = New-Object System.Text.UTF8Encoding $false
            [System.IO.File]::WriteAllText($File.FullName, $updated, $utf8NoBom)
            Write-Output "updated  $($File.FullName.Substring($repoRoot.Length + 1))"
        }
    }
}

Write-Output "Initializing '$Name' ($Stack) in $repoRoot"

foreach ($file in Get-RepoTextFile) {
    Set-FileContent -File $file -Transform {
        param($content)
        foreach ($pair in $replacements.GetEnumerator()) {
            $content = $content.Replace($pair.Key, $pair.Value)
        }
        return $content
    }
}

$readmePath = Join-Path $repoRoot "README.md"
if (Test-Path $readmePath) {
    $readmeFile = Get-Item $readmePath
    Set-FileContent -File $readmeFile -Transform {
        param($content)
        return [regex]::Replace(
            $content,
            '(?s)<!-- TEMPLATE-INTRO:START -->.*?<!-- TEMPLATE-INTRO:END -->\r?\n*',
            ""
        )
    }
}

$sourceCi = Join-Path $repoRoot "templates\ci\$($stackFile[$Stack])"
$destCi = Join-Path $repoRoot ".github\workflows\ci.yml"
if (-not (Test-Path $sourceCi)) {
    throw "Missing stack CI template: $sourceCi"
}
if ($PSCmdlet.ShouldProcess($destCi, "Install $Stack CI workflow")) {
    Copy-Item -Path $sourceCi -Destination $destCi -Force
    Write-Output "installed CI  templates/ci/$($stackFile[$Stack]) -> .github/workflows/ci.yml"
}

$templateDoc = Join-Path $repoRoot "TEMPLATE.md"
if (Test-Path $templateDoc) {
    if ($PSCmdlet.ShouldProcess($templateDoc, "Remove template-only doc")) {
        Remove-Item $templateDoc -Force
        Write-Output "removed  TEMPLATE.md"
    }
}

if (-not $SkipGrokContext) {
    $contextRoot = if ($env:GROK_CONTEXT_ROOT) { $env:GROK_CONTEXT_ROOT } else { "C:\Repos\Grok-Context" }
    if (Test-Path $contextRoot) {
        $slug = $Name.ToLowerInvariant()
        $threadDir = Join-Path $contextRoot "threads\$slug"
        if ($PSCmdlet.ShouldProcess($threadDir, "Create Grok-Context thread")) {
            New-Item -ItemType Directory -Force -Path $threadDir | Out-Null
            $briefSource = Join-Path $repoRoot "templates\grok-context\brief.md"
            $metaSource = Join-Path $repoRoot "templates\grok-context\meta.json"
            $brief = Get-Content $briefSource -Raw
            $meta = Get-Content $metaSource -Raw
            foreach ($pair in $replacements.GetEnumerator()) {
                $brief = $brief.Replace($pair.Key, $pair.Value)
                $meta = $meta.Replace($pair.Key, $pair.Value)
            }
            $utf8NoBom = New-Object System.Text.UTF8Encoding $false
            [System.IO.File]::WriteAllText((Join-Path $threadDir "brief.md"), $brief, $utf8NoBom)
            [System.IO.File]::WriteAllText((Join-Path $threadDir "meta.json"), $meta, $utf8NoBom)
            Write-Output "grok-context  $threadDir"
        }
    } else {
        Write-Output "grok-context  skipped (no $contextRoot)"
    }
}

$remaining = Select-String -Path (Get-RepoTextFile | ForEach-Object { $_.FullName }) -Pattern "__[A-Z0-9_]+__" -CaseSensitive -ErrorAction SilentlyContinue |
    Where-Object { $_.Path -notmatch '\\templates\\' }
if ($remaining) {
    Write-Warning "Unresolved placeholders remain:"
    $remaining | ForEach-Object { Write-Warning ("  {0}:{1} {2}" -f $_.Filename, $_.LineNumber, $_.Line.Trim()) }
} else {
    Write-Output "placeholders  none remaining outside templates/"
}

Write-Output ""
Write-Output "Next:"
Write-Output "  1. Edit README.md and PROJECT.md Goal / Why this project"
Write-Output "  2. Put the first slice in src/ with tests in tests/"
Write-Output "  3. git add -A && git commit -m `"Initialize $Name from repo-template`""
Write-Output "  4. git push"
