# Test-StudentRepositories.ps1
# Checks the status of all student repositories

param(
    [switch]$ShowClean = $false,    # Show repositories with no changes
    [switch]$CheckRemote = $false   # Also check for unpushed commits
)

# Navigate to repository root
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptPath
Push-Location $repoRoot

try {
    # Check if we're in a git repository
    if (!(Test-Path .git)) {
        Write-Host "Error: Not in a git repository!" -ForegroundColor Red
        exit 1
    }

    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Checking Student Repository Status" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    $hasIssues = $false
    
    git submodule foreach --quiet '
        $status = git status --porcelain
        $ahead = ""
        
        if ($CheckRemote) {
            git fetch origin --quiet
            $aheadBehind = git rev-list --left-right --count HEAD...origin/$(git branch --show-current)
            $ahead = $aheadBehind -split "`t"
        }
        
        if ($status -or ($CheckRemote -and [int]$ahead[0] -gt 0)) {
            Write-Host "=== $name ===" -ForegroundColor Yellow
            
            if ($status) {
                Write-Host "  Local changes:" -ForegroundColor Red
                $status | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }
            }
            
            if ($CheckRemote -and [int]$ahead[0] -gt 0) {
                Write-Host "  Unpushed commits: $($ahead[0])" -ForegroundColor Magenta
            }
            
            if ($CheckRemote -and [int]$ahead[1] -gt 0) {
                Write-Host "  Behind remote: $($ahead[1])" -ForegroundColor Cyan
            }
            
            git log --oneline -1 | ForEach-Object { 
                Write-Host "  Latest: $_" -ForegroundColor Gray 
            }
            Write-Host ""
            
            "has_issues"
        }
        elseif ($ShowClean) {
            Write-Host "=== $name ===" -ForegroundColor Green
            Write-Host "  Status: Clean" -ForegroundColor Green
            git log --oneline -1 | ForEach-Object { 
                Write-Host "  Latest: $_" -ForegroundColor Gray 
            }
            Write-Host ""
        }
    ' | ForEach-Object { if ($_ -eq "has_issues") { $hasIssues = $true } }
    
    if (-not $hasIssues -and -not $ShowClean) {
        Write-Host "All repositories are clean!" -ForegroundColor Green
    }
}
catch {
    Write-Host "Error checking repository status: $_" -ForegroundColor Red
    exit 1
}
finally {
    Pop-Location
}