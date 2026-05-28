$scriptsPath = Join-Path $PSScriptRoot "scripts"
$scripts = Get-ChildItem -Path $scriptsPath -Directory

$validLangs = @("js", "ts")
$validHooks = $scripts.BaseName

$lang = $null
$hook = $null

for ($i = 0; $i -lt $args.Count; $i++) {
  switch ($args[$i]) {
    { $_ -in @("-l", "-lang") } {
      $lang = $args[$i + 1]
      $i++
    }

    { $_ -in @("-h", "-hook") } {
      $hook = $args[$i + 1]
      $i++
    }

    default {
      Write-Host "Unknown argument: $($args[$i])"
    }
  }
}

function PromptForLang() {
  $value = Read-Host "Choose language [js/ts]"

  if ($validLangs -notcontains $value) {
    Write-Host "Invalid language. Use js or ts. Exiting." -ForegroundColor Red
    exit
  }

  return $value
}

function PromptForHook() {
  Write-Host "React Hook Library" -ForegroundColor Cyan
  Write-Host "Select what you would like to install below"
  Write-Host "1: debounce"
  Write-Host "2: screensize"
  Write-Host "3: theme"

  [int]$number = Read-Host "Press the number to select a hook"

  switch ($number) {
    1 { return "debounce" }
    2 { return "screensize" }
    3 { return "theme" }
    default {
      Write-Host "Invalid selection. Exiting." -ForegroundColor Red
      exit
    }
  }
}

if (-not $hook) {
  $hook = PromptForHook
}

if (-not $lang) {
  $lang = PromptForLang
}

if ($validHooks -notcontains $hook) {
  Write-Host "Invalid hook: $hook. Exiting." -ForegroundColor Red
  Write-Host "Valid values: debounce, screensize, theme"
  exit
}

if ($validLangs -notcontains $lang) {
  Write-Host "Invalid language: $lang. Exiting." -ForegroundColor Red
  Write-Host "Valid values: js, ts"
  exit
}

$chosenPath = $scripts | Where-Object {
  $_.BaseName -eq $hook
}

if (-not $chosenPath) {
  Write-Host "Script folder not found: $hook"
  exit
}

$mainScript = Join-Path $chosenPath.FullName "main.ps1"

if (-not (Test-Path $mainScript)) {
  Write-Host "main.ps1 not found in $hook"
  exit
}

Write-Host "Running $hook with language $lang ..."

& $mainScript -lang $lang