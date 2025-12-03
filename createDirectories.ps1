# PowerShell script to create course directory structure in OneDrive

# --- Configuration ---
$DONE = "done"
$SEMESTERS = @("Spring", "Summer", "Fall")

Write-Host "=== Course Directory Creator ===" -ForegroundColor Cyan
Write-Host "=== by Jim Quinn ===" -ForegroundColor Cyan
Write-Host ""

# make sure the synced and local folders exist. If not, create them.
if( -not (Test-Path -Path $env:ONEDRIVE)) {
    Write-Host "OneDrive folder not found at $env:ONEDRIVE" -ForegroundColor Red
    Write-Host "Please ensure OneDrive is installed and synced before running this script." -ForegroundColor Red
    exit 1
}


# Get the year
$YEAR = Read-Host "Enter the year"

# check the synced and local folder names exist, and if not, create them
if( -not (Test-Path -Path "$env:ONEDRIVE\Synced")) {
    New-Item -Path "$env:ONEDRIVE\Synced" -ItemType Directory -Force | Out-Null
    Write-Host "Created Synced folder in OneDrive." -ForegroundColor Green
}
if( -not (Test-Path -Path "$env:ONEDRIVE\Local")) {
    New-Item -Path "$env:ONEDRIVE\Local" -ItemType Directory -Force | Out-Null
    Write-Host "Created Local folder in OneDrive." -ForegroundColor Green
}