# Opens a plan exported by Project Plan Builder in Microsoft Project and saves it as .mpp next to it.
# Usage: right-click > Run with PowerShell (uses the newest .xml in Downloads), or pass a path:
#   .\Open-In-Project.ps1 -Path "C:\Users\me\Downloads\My Project.xml"
param([string]$Path)

if (-not $Path) {
    $latest = Get-ChildItem "$env:USERPROFILE\Downloads\*.xml" -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $latest) { Write-Host "No .xml file found in Downloads. Export one from Project Plan Builder first."; exit 1 }
    $Path = $latest.FullName
}
if (-not (Test-Path $Path)) { Write-Host "File not found: $Path"; exit 1 }

$app = New-Object -ComObject MSProject.Application
$app.Visible = $true
if (-not $app.FileOpenEx($Path)) { Write-Host "MS Project could not open $Path"; exit 1 }

$mpp = [System.IO.Path]::ChangeExtension($Path, ".mpp")
$app.FileSaveAs($mpp, 0) | Out-Null
Write-Host "Opened in MS Project and saved as: $mpp"
