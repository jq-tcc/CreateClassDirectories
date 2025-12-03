# PowerShell script to create course directory structure in OneDrive

# --- Refresh the environment variable for OneDrive ---
$env:ONEDRIVE = [System.Environment]::GetEnvironmentVariable("ONEDRIVE", "User")
if ([string]::IsNullOrEmpty($env:ONEDRIVE)) {
    $env:ONEDRIVE = [System.Environment]::GetEnvironmentVariable("ONEDRIVE", "Machine")
}

# --- Configuration ---
$DONE = "done"
$SEMESTERS = @("Spring", "Summer", "Fall")

Write-Host "=== Course Directory Creator ===" -ForegroundColor Cyan
Write-Host "=== by Jim Quinn ===" -ForegroundColor Cyan
Write-Host ""

# Get the year
$YEAR = Read-Host "Enter the year"


# make sure the synced and local folders exist. If not, create them.
# Ask whether to use OneDrive or specify a different parent directory
$choice = Read-Host "Press 'O' to use OneDrive, or 'S' to specify a parent directory"

if ($choice -match '^[Oo]') {
    if (-not (Test-Path -Path $env:ONEDRIVE)) {
        Write-Host "OneDrive folder not found at $env:ONEDRIVE" -ForegroundColor Yellow
        $directoryPath = Read-Host "Enter the full path to the directory you want to use instead"
        try {
            New-Item -Path $directoryPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
            $env:ONEDRIVE = $directoryPath
            Write-Host "Using specified folder: $directoryPath" -ForegroundColor Green
        } catch {
            Write-Host "Error: Could not create specified folder. Exiting." -ForegroundColor Red
            exit 1
        }
    } else {
        $directoryPath = $env:ONEDRIVE
        Write-Host "Using OneDrive at $env:ONEDRIVE" -ForegroundColor Green
    }
}
elseif ($choice -match '^[Ss]') {
    $directoryPath = Read-Host "Enter the full path to the parent directory where you want to create the folder"
    try {
        New-Item -Path $directoryPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
        $env:ONEDRIVE = $directoryPath
        Write-Host "Using specified folder: $directoryPath" -ForegroundColor Green
    } catch {
        Write-Host "Error: Could not create specified folder. Exiting." -ForegroundColor Red
        exit 1
    }
}
else {
    Write-Host "Invalid selection. Exiting." -ForegroundColor Red
    exit 1
}

# check the synced and local folder names exist, and if not, create them
if( -not (Test-Path -Path "$directoryPath\Synced")) {
    try {
        New-Item -Path "$directoryPath\Synced" -ItemType Directory -Force -ErrorAction Stop | Out-Null
        Write-Host "Created Synced folder in specified directory." -ForegroundColor Green
    } catch {
        Write-Host "Error: Could not create Synced folder. Exiting." -ForegroundColor Red
        exit 1
    }
}
if( -not (Test-Path -Path "$directoryPath\Local")) {
    try {
        New-Item -Path "$directoryPath\Local" -ItemType Directory -Force -ErrorAction Stop | Out-Null
        Write-Host "Created Local folder in specified directory." -ForegroundColor Green
    } catch {
        Write-Host "Error: Could not create Local folder. Exiting." -ForegroundColor Red
        exit 1
    }
}

Write-Host "Course directories will be added to: $directoryPath" -ForegroundColor Green
Write-Host ""

# --- Set up the directory structure --- 
# --- see conceptDiagram.png, insideClassSyncedDirectories.png, and insideClassLocalDirectories.png ---
Write-Host "Setting up the directory structure..." -ForegroundColor Cyan

# --- Create a directory for the year in both Synced and Local folders ---
$ROOT_DIR_SYNCED = Join-Path "$directoryPath\Synced" $YEAR
$ROOT_DIR_LOCAL = Join-Path "$directoryPath\Local" $YEAR    

# Create the directory for the year in Synced folder
try {   
    New-Item -Path $ROOT_DIR_SYNCED -ItemType Directory -Force -ErrorAction Stop | Out-Null
    Write-Host "Created year directory in Synced folder: $ROOT_DIR_SYNCED" -ForegroundColor Green
} catch {
    Write-Host "Error: Could not create main directory $ROOT_DIR_SYNCED. Exiting." -ForegroundColor Red
    exit 1
}

# Create the directory for the year in Local folder
try {   
    New-Item -Path $ROOT_DIR_LOCAL -ItemType Directory -Force -ErrorAction Stop | Out-Null
    Write-Host "Created year directory in Local folder: $ROOT_DIR_LOCAL" -ForegroundColor Green
} catch {
    Write-Host "Error: Could not create main directory $ROOT_DIR_LOCAL. Exiting." -ForegroundColor Red
    exit 1
}