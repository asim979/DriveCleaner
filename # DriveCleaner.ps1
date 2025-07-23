Clear-Host
Write-Host "=== Drive Cleaner ===`n"

$folder = Read-Host "Enter the full path of the folder to scan (e.g., C:\Temp)"
if (-not (Test-Path $folder)) {
    Write-Host "Folder does not exist. Exiting."
    exit
}

$extensions = @("*.tmp", "*.log", "*.bak")

$files = @()
foreach ($ext in $extensions) {
    $files += Get-ChildItem -Path $folder -Recurse -Include $ext -File -ErrorAction SilentlyContinue
}

if ($files.Count -eq 0) {
    Write-Host "No .tmp, .log, or .bak files found."
    exit
}

$files = $files | Sort-Object Length -Descending

Write-Host "`nFound $($files.Count) files:`n"
foreach ($file in $files) {
    "{0,8} MB - {1}" -f ([math]::Round($file.Length / 1MB, 2)), $file.FullName
}

$confirm = Read-Host "`nDo you want to delete these files? (Y/N)"
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "Operation canceled. No files were deleted."
    exit
}

$totalSize = 0
$deletedList = @()

foreach ($file in $files) {
    try {
        $deletedList += [PSCustomObject]@{
            Name = $file.Name
            SizeMB = [math]::Round($file.Length / 1MB, 2)
            FullPath = $file.FullName
            DeletedAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        }
        $totalSize += $file.Length
        Remove-Item $file.FullName -Force -ErrorAction SilentlyContinue
    } catch {
        Write-Host "Failed to delete: $($file.FullName)"
    }
}

Write-Host "`nDeleted $($deletedList.Count) files. Total size: $([math]::Round($totalSize / 1MB, 2)) MB"

$reportPath = Join-Path -Path $PSScriptRoot -ChildPath "DriveCleaner_Report.html"
$deletedList | ConvertTo-Html -Property Name, SizeMB, FullPath, DeletedAt -Title "DriveCleaner Report" |
    Out-File -FilePath $reportPath -Encoding utf8

Write-Host "`nReport saved to: $reportPath"
    