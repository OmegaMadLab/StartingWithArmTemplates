Write-Output "Running on $($env:COMPUTERNAME)."
Try {
    Write-Output "Trying to read file..."
    $FileContent = Get-Content .\TestFile.txt
    Write-Output $FileContent
}
catch {
    Write-Output "Error while reading file."
}