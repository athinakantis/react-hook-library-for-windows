param(
  [string]$lang
)

# Debouncer
# This script will install a custom react hook useDebouncedValue(arg)
$projectRoot = Get-Location

Write-Host "Language selected: $lang"

$srcFolder = Get-ChildItem -Path $projectRoot -Recurse -Directory | Where-Object { $_.Name -eq "src" }

function CreateTheme([string]$path) {
  $themeProvider = Join-Path $path "ThemeProvider.$($lang)x"
  $themeContext = Join-Path $path "themeContext.$($lang)x"
  $themeHook = Join-Path $path "useTheme.$($lang)"

  $themeProviderPath = Join-Path $PSScriptRoot "templates\themeProvider.$($lang)x"
  $themeContextPath = Join-Path $PSScriptRoot "templates\themeContext.$($lang)x"
  $themeHookPath = Join-Path $PSScriptRoot "templates\useTheme.js"

  $themeProviderContent = Get-Content -Path $themeProviderPath -Raw
  $themeContextContent = Get-Content -Path $themeContextPath -Raw
  $themeHookContent = Get-Content -Path $themeHookPath -Raw

  Set-Content -Path $themeProvider -Value $themeProviderContent
  Set-Content -Path $themeContext -Value $themeContextContent
  Set-Content -Path $themeHook -Value $themeHookContent

  Write-Host "Hook created at src/theme"
  Write-Host "Theme hook created! Exiting"
}

if ($srcFolder -eq $false) {
  Write-Host "No src folder found. Are you in the right directory?"
  Exit
}
else {
  $createdThemeFolder = New-Item -Path $srcFolder -ItemType Directory -Name "theme"
  Write-Host "New Theme folder created"
  CreateTheme $createdThemeFolder.FullName
}

function AddToMain() {
  $mainFile = Get-ChildItem -Path . -Recurse -File |
  Where-Object {
    $_.FullName -match "src\\main\.(tsx|jsx)$"
  } |
  Select-Object -First 1

  if (-not $mainFile) {
    Write-Host "src/main.tsx or src/main.jsx not found"
    return
  }

  $content = Get-Content -Path $mainFile.FullName -Raw

  # Check if App component exists
  if ($content -notmatch "<App\s*/?>") {
    Write-Host "<App /> component not found in $($mainFile.Name)"
    return
  }

  # Prevent duplicate wrapping
  if ($content -match "<ThemeProvider>") {
    Write-Host "ThemeProvider already exists in $($mainFile.Name)"
    return
  }

  # Add ThemeProvider import
  $content = $content -replace (
    "import App from ['""]\.\/App['""]",
    "`$0`nimport { ThemeProvider } from './theme/ThemeProvider'"
  )

  # Wrap App
  $content = $content -replace (
    "<App\s*/>",
    "<ThemeProvider>`n    <App />`n  </ThemeProvider>"
  )

  Set-Content -Path $mainFile.FullName -Value $content

  Write-Host "ThemeProvider added to $($mainFile.FullName)"
}