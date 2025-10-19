# Lock-StudentSubmissions.ps1
# Locks all submodules to their current commit (for grading)

param(
    [string]$Message = "Lock all submissions for grading",
    [switch]$UpdateFirst = $true,  # Pull latest before locking
    [string]$Branch = "main"
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
    Write-Host "Locking Student Submissions" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    
    $date = Get-Date -Format "yyyy-MM-dd HH:mm"
    
    if ($UpdateFirst) {
        Write-Host "Updating to latest submissions first..." -ForegroundColor Yellow
        git submodule foreach "git pull origin $Branch"
        Write-Host ""
    }
    
    # Record current commits
    Write-Host "Recording current commit states..." -ForegroundColor Yellow
    $submissions = @()
    
    git submodule foreach --quiet '
        $currentCommit = git rev-parse HEAD
        $shortCommit = git rev-parse --short HEAD
        $commitDate = git log -1 --format="%ai"
        $commitMessage = git log -1 --format="%s"
        Write-Host "$name locked at: $shortCommit" -ForegroundColor Green
        "$name,$currentCommit,$commitDate,`"$commitMessage`""
    ' | ForEach-Object { $submissions += $_ }
    
    # Save submission record
    $recordFile = "submissions-$(Get-Date -Format 'yyyy-MM-dd-HHmm').csv"
    "Student,Commit Hash,Commit Date,Last Message" | Out-File $recordFile
    $submissions | Out-File $recordFile -Append
    
    # Add and commit the specific commits
    git add .
    git commit -m "$Message - $date"
    
    Write-Host ""
    Write-Host "All submissions locked at current commits" -ForegroundColor Green
    Write-Host "Timestamp: $date" -ForegroundColor Yellow
    Write-Host "Submission record saved to: $recordFile" -ForegroundColor Yellow
}
catch {
    Write-Host "Error locking submissions: $_" -ForegroundColor Red
    exit 1
}
finally {
    Pop-Location
}