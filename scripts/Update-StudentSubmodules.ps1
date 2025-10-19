# Update-StudentSubmodules.ps1
# Updates all student submodules to their latest commits

param(
    [switch]$Push = $false,  # Automatically push after update
    [switch]$Silent = $false, # Suppress detailed output
    [string]$Branch = "main"  # Branch to pull from (default: main)
)

# Navigate to repository root
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptPath
Push-Location $repoRoot

try {
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Updating all student submodules..." -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan

    # Check if we're in a git repository
    if (!(Test-Path .git)) {
        Write-Host "Error: Not in a git repository!" -ForegroundColor Red
        exit 1
    }

    # Initialize submodules if needed
    git submodule init
    
    # Update each submodule
    if ($Silent) {
        git submodule foreach --quiet "git pull origin $Branch"
    } else {
        git submodule foreach "echo 'Updating `$name...' && git pull origin $Branch"
    }
    
    # Check if there are changes to commit
    $status = git status --porcelain
    
    if ($status) {
        # Stage all changes
        git add .
        
        # Create commit message with timestamp
        $date = Get-Date -Format "yyyy-MM-dd HH:mm"
        $commitMsg = "Update all student submodules $date"
        
        git commit -m $commitMsg
        
        Write-Host "`nChanges committed successfully!" -ForegroundColor Green
        
        # Push if requested
        if ($Push) {
            Write-Host "Pushing to remote..." -ForegroundColor Yellow
            git push
            Write-Host "Pushed to remote successfully!" -ForegroundColor Green
        }
    } else {
        Write-Host "`nNo changes to commit - all submodules are up to date!" -ForegroundColor Yellow
    }
    
    Write-Host "`nUpdate complete!" -ForegroundColor Green
}
catch {
    Write-Host "Error updating submodules: $_" -ForegroundColor Red
    exit 1
}
finally {
    Pop-Location
}