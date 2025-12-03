# PowerShell script to create course directory structure in OneDrive

# --- Configuration ---
$DONE = "done"
$SEMESTERS = @("Spring", "Summer", "Fall")

Write-Host "=== Course Directory Creator ===" -ForegroundColor Cyan
Write-Host "=== by Jim Quinn ===" -ForegroundColor Cyan
Write-Host ""

# make sure the synced and local folders exist. If not, create them.
if( -not (Test-Path -Path "$env:ONEDRIVE\Synced")) {
    Write-Host "OneDrive folder not found at $env:ONEDRIVE" -ForegroundColor Red
    Write-Host "Please ensure OneDrive is installed and synced before running this script." -ForegroundColor Red
    exit 1
}

# Get the year
$YEAR = Read-Host "Enter the year"


# Check if ONEDRIVE environment variable exists
if ([string]::IsNullOrEmpty($env:ONEDRIVE)) {
    Write-Host "ONEDRIVE environment variable not found." -ForegroundColor Yellow
    $OneDrivePath = Read-Host "Enter the full path to your OneDrive folder"
} else {
    $OneDrivePath = $env:ONEDRIVE
}

$ROOT_DIR = Join-Path $OneDrivePath $YEAR

Write-Host "Course directories will be added to: $ROOT_DIR" -ForegroundColor Green
Write-Host ""

# --- Set up the directory structure ---
Write-Host "Setting up the directory structure..." -ForegroundColor Cyan

# Create the directory for the year
try {
    New-Item -Path $ROOT_DIR -ItemType Directory -Force -ErrorAction Stop | Out-Null
    Write-Host "Created year directory: $ROOT_DIR" -ForegroundColor Green
} catch {
    Write-Host "Error: Could not create main directory $ROOT_DIR. Exiting." -ForegroundColor Red
    exit 1
}

# Create the semester directories
foreach ($semester in $SEMESTERS) {
    $semesterPath = Join-Path $ROOT_DIR $semester
    New-Item -Path $semesterPath -ItemType Directory -Force | Out-Null
}

Write-Host "Base directories created: $ROOT_DIR\{Spring, Summer, Fall}" -ForegroundColor Green
Write-Host ""

# --- Select the semester to add class folders ---
Write-Host "Select a semester to add classes:" -ForegroundColor Cyan
Write-Host ""

for ($i = 0; $i -lt $SEMESTERS.Count; $i++) {
    Write-Host "  $($i + 1). $($SEMESTERS[$i])"
}
Write-Host ""

do {
    $selection = Read-Host "Please select a semester number (1-$($SEMESTERS.Count))"
    $selectionIndex = [int]$selection - 1
    
    if ($selectionIndex -ge 0 -and $selectionIndex -lt $SEMESTERS.Count) {
        $selected_semester = $SEMESTERS[$selectionIndex]
        $TARGET_DIR = Join-Path $ROOT_DIR $selected_semester
        Write-Host "You have selected the '$selected_semester' directory, in the $YEAR folder" -ForegroundColor Green
        Write-Host ""
        break
    } else {
        Write-Host "Invalid selection. Please enter a number between 1 and $($SEMESTERS.Count)." -ForegroundColor Red
    }
} while ($true)

# --- Create the course directories for the selected semester ---
Write-Host "Enter the names of the courses you will be teaching." -ForegroundColor Cyan
Write-Host "Type 'done' when all courses have been added" -ForegroundColor Cyan
Write-Host ""

while ($true) {
    $DIR_NAME = Read-Host "Enter the course directory name (or 'done' to exit)"
    
    # Check if user wants to exit
    if ($DIR_NAME -eq $DONE) {
        Write-Host "Exit command received. Finishing up and exiting script." -ForegroundColor Yellow
        break
    }
    
    # Check if directory name is empty or whitespace
    if ([string]::IsNullOrWhiteSpace($DIR_NAME)) {
        Write-Host "Directory name cannot be empty. Try again." -ForegroundColor Red
        continue
    }
    
    # Create the course directory
    $coursePath = Join-Path $TARGET_DIR $DIR_NAME
    
    try {
        Write-Host "Creating $coursePath..." -ForegroundColor Cyan
        New-Item -Path $coursePath -ItemType Directory -Force -ErrorAction Stop | Out-Null
        Write-Host "$coursePath created." -ForegroundColor Green
        
        # Create subdirectories
        Write-Host "Adding Assignments and InClass directories..." -ForegroundColor Cyan
        
        $assignmentsPath = Join-Path $coursePath "assignments"
        New-Item -Path $assignmentsPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
        Write-Host "  Added assignments directory." -ForegroundColor Green
        
        $inClassPath = Join-Path $coursePath "in_class"
        New-Item -Path $inClassPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
        Write-Host "  Added in_class directory." -ForegroundColor Green
        
        Write-Host ""
    } catch {
        Write-Host "Error creating directory: $DIR_NAME" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "✅ Script execution complete." -ForegroundColor Green
