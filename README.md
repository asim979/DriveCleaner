# DriveCleaner
DriveCleaner.ps1 is a lightweight and effective PowerShell script designed to help you clean up temporary files, log files, and backup files from any folder on your system.
It scans the specified folder for files with extensions .tmp, .log, and .bak, lists them with their sizes, and asks for your confirmation before deleting.
After cleaning, it generates a detailed HTML report of all deleted files for your review.

This script is useful for freeing up disk space and improving system performance by removing unnecessary temporary files.


How to Use
Download or clone the DriveCleaner.ps1 script to your computer.

Open PowerShell with appropriate permissions (Run as Administrator is recommended).

Navigate to the folder where the script is saved using the cd command. For example:
cd C:\Path\To\Script

Run the script by typing:


.\DriveCleaner.ps1




-Enter the full path of the folder you want to scan when prompted for examble:  C:\Users\YourName\AppData\Local\Temp


Review the list of temporary, log, and backup files found.

Confirm deletion by typing Y to delete the files or N to cancel.

After deletion, an HTML report will be saved in the script’s folder for your review.

