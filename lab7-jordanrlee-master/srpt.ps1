#!/usr/bin/env pwsh
# Jordan Lee
# Lab 7 - PowerShell Search and Report
# CS 3030 - Scripting Languages

# check to see if the file path is correct
if ($args.count -ne 1) {
Write-Host "Usage: srpt.ps1 <PATH>"

exit 1
}

$path = $args[0]

# create variables to store the information into
$startTime = (GET-DATE)
$files = Get-ChildItem -Path $path -recurse
$numFiles = 0
$numDirectories = 0
$numSymlinks = 0
$numOldFiles = 0
$numLarge = 0
$numGraphic = 0
$numExecutable = 0
$numTemp = 0
$totalSize = 0
foreach ($file in ($files)) {
$filePath = $file.FullName
$len = (Get-Item -Path $filePath).length
# cehck the Directory Count
if( ((Get-Item -Path $filePath) -is [System.IO.DirectoryInfo] )) {
$numDirectories = $numDirectories + 1
}
# next do the Symbolic Links 
elseif ((Get-Item -Path $filePath).LinkType -eq "SymbolicLink") {
$numSymlinks = $numSymlinks + 1
}
else {
# next check File Count 
$numFiles = $numFiles + 1
# then next Total size
$totalSize = $totalSize + $len
# then Graphic Files 
if (($filePath -Like "*.jpg") -or ($filePath -Like "*.gif") -or 
($filePath -Like "*.bmp")) {
$numGraphic = $numGraphic + 1
}
# then ExecutableFiles with .bat or .ps1 or .exe
if (($filePath -Like "*.bat") -or ($filePath -Like "*.ps1") -or 
($filePath -Like "*.exe")) {
$numExecutable = $numExecutable + 1
}
# then Temporary Files like .o
if ($filePath -Like "*.o") {
$numTemp = $numTemp + 1
}
}
# now do Large Files which are greater than 500,000 bytes
if ($len -gt 500000) {
$numLarge = $numLarge + 1
}
$fileCreated = (Get-Item -Path $filePath).CreationTime
# and then Old Files that are greater than 365 days ago
if (($startTime - $fileCreated).Days -gt 365) {
$numOldFiles = $numOldFiles + 1
}
}
$endTime = (GET-DATE)
$executionTime = ($endTime - $startTime)
$todaysDate = & date
$hostname = & hostname
# output the the report file 

Write-Host "SearchReport" $hostname $path $todaysDate
Write-Host "ExecutionTime" $executionTime.ToString("ss")
Write-Host "Directories" $numDirectories.ToString('N0')
Write-Host "Files" $numFiles.ToString('N0')
Write-Host "Sym links" $numSymlinks.ToString('N0')
Write-Host "Old files" $numOldFiles.ToString('N0')
Write-Host "Large files" $numLarge.ToString('N0')
Write-Host "Graphics files" $numGraphic.ToString('N0')
Write-Host "Temporary files" $numTemp.ToString('N0')
Write-Host "Executable files" $numExecutable.ToString('N0')
Write-Host "TotalFileSize" $totalSize.ToString('N0')

exit 0
# stand up and cheer because its over!
# end code
