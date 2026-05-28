param(
  [string]$lang
)

# Debouncer
# This script will install a custom react hook useDebouncedValue
$projectRoot = Get-Location

$templatePath = Join-Path $PSScriptRoot "templates\useDebouncedValue.$($lang)x"
$hooksFolder = Get-ChildItem -Path $projectRoot -Recurse -Directory | Where-Object { $_.Name -eq "hooks" }
$srcFolder = Get-ChildItem -Path $projectRoot -Recurse -Directory | Where-Object { $_.Name -eq "src" }

function CreateDebouncer([string]$path) {
  $filePath = Join-Path $path "useDebouncedValue.$($lang)x"
  $templatePath = Join-Path $PSScriptRoot "templates\useDebouncedValue.$($lang)x"

  if (-not (Test-Path $templatePath)) {
    Write-Host "Template file not found: $templatePath"
    return
  }

  $content = Get-Content -Path $templatePath -Raw

  Set-Content -Path $filePath -Value $content

  Write-Host "Hook created at $filePath"
  Write-Host "Debouncer hook created! Exiting" -ForegroundColor Green
}

if ($hooksFolder) {
  CreateDebouncer $hooksFolder[0].FullName
}
elseif ($srcFolder) {
  $createdHooksFolder = New-Item -Path $srcFolder[0].FullName -ItemType Directory -Name "hooks"
  Write-Host "New Hooks folder created"
  CreateDebouncer $createdHooksFolder.FullName 
}
else {
  Write-Host "No src folder found. Are you in the right directory?"
  Write-Host "Exiting"
}
