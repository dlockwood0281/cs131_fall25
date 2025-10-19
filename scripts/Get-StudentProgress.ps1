# Get-StudentProgress.ps1
# Generates a summary of student activity and progress

param(
    [switch]$SaveToFile = $false,  # Save report to file
    [switch]$Detailed = $false      # Include more details
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

    Write-Host "Student Progress Report" -ForegroundColor Cyan
    Write-Host "======================" -ForegroundColor Cyan
    $date = Get-Date -Format "yyyy-MM-dd HH:mm"
    Write-Host "Generated: $date" -ForegroundColor Gray
    Write-Host ""

    $report = @()
    
    # Collect progress data
    git submodule foreach --quiet '
        $lastCommit = git log -1 --format="%ar"
        $lastCommitDate = git log -1 --format="%ai"
        $commitCount = git rev-list --count HEAD
        $lastMessage = git log -1 --format="%s"
        $authorName = git log -1 --format="%an"
        
        $output = "$name"
        Write-Host "$name" -ForegroundColor Yellow
        Write-Host "  Last commit: $lastCommit" -ForegroundColor Gray
        Write-Host "  Total commits: $commitCount" -ForegroundColor Gray
        
        if ($Detailed) {
            Write-Host "  Last message: $lastMessage" -ForegroundColor Gray
            Write-Host "  Author: $authorName" -ForegroundColor Gray
        }
        Write-Host ""
        
        # Store for file output
        "$name,$lastCommitDate,$commitCount,$authorName,`"$lastMessage`""
    ' | ForEach-Object { $report += $_ }
    
    # Save to file if requested
    if ($SaveToFile) {
        $filename = "progress-report-$(Get-Date -Format 'yyyy-MM-dd-HHmm').csv"
        $header = "Student,Last Commit Date,Total Commits,Author,Last Message"
        $header | Out-File $filename
        $report | Out-File $filename -Append
        Write-Host "Report saved to: $filename" -ForegroundColor Green
    }
}
catch {
    Write-Host "Error generating progress report: $_" -ForegroundColor Red
    exit 1
}
finally {
    Pop-Location
}