#requires -Version 3 -Modules posh-git

function Write-Theme {
  param(
    [bool]
    $lastCommandFailed,
    [string]
    $with
  )

  #check the last command state and indicate if failed
  $promtSymbolColor = $sl.Colors.PromptSymbolColor
  If ($lastCommandFailed) {
    $promtSymbolColor = $sl.Colors.WithForegroundColor
  }

  # Writes the postfixes to the prompt
  $prompt = Write-Prompt -Object $sl.PromptSymbols.StartSymbol -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor

  #check for elevated prompt
  If (Test-Administrator) {
    $prompt += Write-Prompt -Object "$($sl.PromptSymbols.ElevatedSymbol) " -ForegroundColor $sl.Colors.AdminIconForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
  }

  $user = $sl.CurrentUser
  $computer = [System.Environment]::MachineName
  if (Test-NotDefaultUser($user)) {
    $prompt += Write-Prompt -Object "$user@$computer " -ForegroundColor $sl.Colors.SessionInfoForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
  }

  # Writes the drive portion
  $drive = $sl.PromptSymbols.HomeSymbol
  if ($pwd.Path -ne $HOME) {
    $drive = "$(Split-Path -path $pwd -Leaf)"
  }
  $prompt += Write-Prompt -Object $drive -ForegroundColor $sl.Colors.DriveForegroundColor

  $status = Get-VCSStatus
  if ($status) {
    $prompt += Write-Prompt -Object " git:(" -ForegroundColor $sl.Colors.PromptHighlightColor
    $prompt += Write-Prompt -Object "$($status.Branch)" -ForegroundColor $sl.Colors.WithForegroundColor
    $prompt += Write-Prompt -Object ")" -ForegroundColor $sl.Colors.PromptHighlightColor
    if ($status.Working.Length -gt 0) {
      $prompt += Write-Prompt -Object (" " + $sl.PromptSymbols.GitDirtyIndicator) -ForegroundColor $sl.Colors.GitDefaultColor
    }
  }

  $timeStamp = Get-Date -UFormat %R
  $timestamp = "[$timeStamp]"

  $prompt += Set-CursorForRightBlockWrite -textLength ($timestamp.Length + 1)
  $prompt += Write-Prompt $timeStamp -ForegroundColor $sl.Colors.PromptForegroundColor

  $prompt += Set-Newline
  $prompt += Write-Prompt -Object ($sl.PromptSymbols.PromptIndicator + "  ") -ForegroundColor $promtSymbolColor

  $prompt += ' '
  $prompt
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x279C)
$sl.Colors.PromptSymbolColor = [ConsoleColor]::Green
$sl.Colors.PromptHighlightColor = [ConsoleColor]::Blue
$sl.Colors.DriveForegroundColor = [ConsoleColor]::Cyan
$sl.Colors.WithForegroundColor = [ConsoleColor]::Red
$sl.PromptSymbols.GitDirtyIndicator = [char]::ConvertFromUtf32(10007)
$sl.Colors.GitDefaultColor = [ConsoleColor]::Yellow
