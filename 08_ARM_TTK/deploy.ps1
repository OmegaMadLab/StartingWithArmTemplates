# Get and install ARM TTK
$ttkPath = "$env:TEMP\arm-template-toolkit.zip"
(New-Object Net.WebClient).DownloadFile("https://aka.ms/arm-ttk-latest", $ttkPath)

Install-Module 7Zip4Powershell

Expand-7Zip -ArchiveFileName $ttkPath -TargetPath .\ttkModule

Get-ChildItem *.ps1, *.psd1, *.ps1xml, *.psm1 -Recurse | Unblock-File

Import-Module .\ttkModule\arm-ttk\arm-ttk.psd1

# Test a template
Test-AzTemplate -TemplatePath .\storageAccount.json