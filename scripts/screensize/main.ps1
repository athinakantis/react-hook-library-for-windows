param(
  [string]$lang
)

# ScreenSize Hook
# This script will install a custom react hook useScreenSize
$projectRoot = Get-Location

$hooksFolder = Get-ChildItem -Path $projectRoot -Recurse -Directory | Where-Object { $_.Name -eq "hooks" }
$srcFolder = Get-ChildItem -Path $projectRoot -Recurse -Directory | Where-Object { $_.Name -eq "src" }

function CreateScreenSizeHook([string]$path) {
  $filePath = Join-Path $path "useScreenSize.$($lang)x"
  $templatePath = Join-Path $PSScriptRoot "templates\useScreenSize.$($lang)x"

  if (-not (Test-Path $templatePath)) {
    Write-Host "Template file not found: $templatePath"
    return
  }

  $content = Get-Content -Path $templatePath -Raw
  Set-Content -Path $filePath -Value $content

  Write-Host "Hook Created at $($filePath)"
  Write-Host "ScreenSize hook created! Exiting"
}

if ($hooksFolder) {
  CreateScreenSizeHook $hooksFolder[0].FullName 
}
elseif ($srcFolder) {
  $createdHooksFolder = New-Item -Path $srcFolder[0].FullName -ItemType Directory -Name "hooks"
  Write-Host "New Hooks folder created"
  CreateScreenSizeHook $createdHooksFolder.FullName 
}
else {
  Write-Host "No src folder found. Are you in the right directory?"
  Write-Host "Exiting"
}
