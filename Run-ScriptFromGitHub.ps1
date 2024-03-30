# https://tomtalks.blog/run-powershell-scripts-directly-github-two-lines/


$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/tomarbuthnot/Run-PowerShell-Directly-From-GitHub/master/Run-FromGitHub-SamplePowerShell.ps1
Invoke-Expression $($ScriptFromGitHub.Content)