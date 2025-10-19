# Export-ClassReport.ps1
# Generates a comprehensive class report with multiple export formats

param(
    [string]$Format = "HTML",  # HTML, CSV, Markdown, or All
    [switch]$IncludeStats = $true,
    [switch]$IncludeCommitHistory = $false,
    [switch]$OpenWhenDone = $false,
    [int]$RecentCommits = 5
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
    Write-Host "Generating Class Report" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $fileDate = Get-Date -Format "yyyy-MM-dd-HHmm"
    
    # Collect all student data
    $studentData = @()
    
    git submodule foreach --quiet '
        $name = $ENV:name
        $path = $ENV:sm_path
        
        # Basic information
        $lastCommitHash = git rev-parse HEAD
        $shortHash = git rev-parse --short HEAD
        $lastCommitDate = git log -1 --format="%ai"
        $lastCommitRelative = git log -1 --format="%ar"
        $lastMessage = git log -1 --format="%s"
        $authorName = git log -1 --format="%an"
        $authorEmail = git log -1 --format="%ae"
        
        # Statistics
        $totalCommits = git rev-list --count HEAD
        $filesChanged = (git diff --name-only HEAD~1..HEAD 2>$null | Measure-Object).Count
        $additions = git diff --stat HEAD~1..HEAD 2>$null | Select-String -Pattern "(\d+) insertion" | ForEach-Object { $_.Matches[0].Groups[1].Value }
        $deletions = git diff --stat HEAD~1..HEAD 2>$null | Select-String -Pattern "(\d+) deletion" | ForEach-Object { $_.Matches[0].Groups[1].Value }
        
        if (-not $additions) { $additions = 0 }
        if (-not $deletions) { $deletions = 0 }
        
        # Recent activity (last 5 commits)
        $recentCommits = git log --oneline -n 5 --format="%h|%ai|%s|%an"
        
        # Output as JSON-like string for PowerShell to parse
        @{
            Name = $name
            Path = $path
            LastCommitHash = $lastCommitHash
            ShortHash = $shortHash
            LastCommitDate = $lastCommitDate
            LastCommitRelative = $lastCommitRelative
            LastMessage = $lastMessage
            AuthorName = $authorName
            AuthorEmail = $authorEmail
            TotalCommits = [int]$totalCommits
            FilesChanged = [int]$filesChanged
            Additions = [int]$additions
            Deletions = [int]$deletions
            RecentCommits = $recentCommits
        } | ConvertTo-Json -Compress
    ' | ForEach-Object { 
        $studentData += ($_ | ConvertFrom-Json)
    }
    
    # Generate reports based on format
    switch ($Format.ToUpper()) {
        "HTML" { 
            $htmlFile = "class-report-$fileDate.html"
            Export-HTMLReport -Data $studentData -OutputFile $htmlFile -Timestamp $timestamp -IncludeHistory:$IncludeCommitHistory
            Write-Host "HTML report saved to: $htmlFile" -ForegroundColor Green
            if ($OpenWhenDone) { Invoke-Item $htmlFile }
        }
        "CSV" { 
            $csvFile = "class-report-$fileDate.csv"
            Export-CSVReport -Data $studentData -OutputFile $csvFile
            Write-Host "CSV report saved to: $csvFile" -ForegroundColor Green
            if ($OpenWhenDone) { Invoke-Item $csvFile }
        }
        "MARKDOWN" { 
            $mdFile = "class-report-$fileDate.md"
            Export-MarkdownReport -Data $studentData -OutputFile $mdFile -Timestamp $timestamp -IncludeHistory:$IncludeCommitHistory
            Write-Host "Markdown report saved to: $mdFile" -ForegroundColor Green
            if ($OpenWhenDone) { Invoke-Item $mdFile }
        }
        "ALL" {
            $htmlFile = "class-report-$fileDate.html"
            $csvFile = "class-report-$fileDate.csv"
            $mdFile = "class-report-$fileDate.md"
            
            Export-HTMLReport -Data $studentData -OutputFile $htmlFile -Timestamp $timestamp -IncludeHistory:$IncludeCommitHistory
            Export-CSVReport -Data $studentData -OutputFile $csvFile
            Export-MarkdownReport -Data $studentData -OutputFile $mdFile -Timestamp $timestamp -IncludeHistory:$IncludeCommitHistory
            
            Write-Host "Reports saved:" -ForegroundColor Green
            Write-Host "  HTML: $htmlFile" -ForegroundColor Gray
            Write-Host "  CSV: $csvFile" -ForegroundColor Gray
            Write-Host "  Markdown: $mdFile" -ForegroundColor Gray
        }
        Default {
            Write-Host "Invalid format. Use HTML, CSV, Markdown, or All" -ForegroundColor Red
        }
    }
}
catch {
    Write-Host "Error generating report: $_" -ForegroundColor Red
    exit 1
}
finally {
    Pop-Location
}

# Helper Functions (defined in the script)

function Export-HTMLReport {
    param($Data, $OutputFile, $Timestamp, $IncludeHistory)
    
    $html = @"
<!DOCTYPE html>
<html>
<head>
    <title>Class Report - $Timestamp</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f5f5f5; }
        h1 { color: #333; border-bottom: 3px solid #4CAF50; padding-bottom: 10px; }
        .summary { background: white; padding: 15px; margin: 20px 0; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .student { background: white; margin: 20px 0; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .student h2 { color: #4CAF50; margin-top: 0; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 10px; margin: 15px 0; }
        .stat { background: #f8f9fa; padding: 10px; border-radius: 4px; }
        .stat-label { font-size: 12px; color: #666; }
        .stat-value { font-size: 20px; font-weight: bold; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { background: #4CAF50; color: white; padding: 10px; text-align: left; }
        td { padding: 8px; border-bottom: 1px solid #ddd; }
        .recent { color: #4CAF50; }
        .stale { color: #ff9800; }
        .inactive { color: #f44336; }
    </style>
</head>
<body>
    <h1>Class Project Report</h1>
    <div class="summary">
        <p><strong>Generated:</strong> $Timestamp</p>
        <p><strong>Total Students:</strong> $($Data.Count)</p>
        <p><strong>Total Commits:</strong> $($Data.TotalCommits | Measure-Object -Sum | Select-Object -ExpandProperty Sum)</p>
    </div>
"@
    
    foreach ($student in $Data) {
        # Determine activity status
        $daysAgo = (New-TimeSpan -Start ([DateTime]::Parse($student.LastCommitDate)) -End (Get-Date)).Days
        $activityClass = if ($daysAgo -le 3) { "recent" } elseif ($daysAgo -le 7) { "stale" } else { "inactive" }
        
        $html += @"
    <div class="student">
        <h2>$($student.Name)</h2>
        <p class="$activityClass"><strong>Last Activity:</strong> $($student.LastCommitRelative) - $($student.LastCommitDate)</p>
        <p><strong>Last Commit:</strong> [$($student.ShortHash)] $($student.LastMessage)</p>
        <p><strong>Author:</strong> $($student.AuthorName)</p>
        
        <div class="stats">
            <div class="stat">
                <div class="stat-label">Total Commits</div>
                <div class="stat-value">$($student.TotalCommits)</div>
            </div>
            <div class="stat">
                <div class="stat-label">Files Changed</div>
                <div class="stat-value">$($student.FilesChanged)</div>
            </div>
            <div class="stat">
                <div class="stat-label">Additions</div>
                <div class="stat-value" style="color: #4CAF50;">+$($student.Additions)</div>
            </div>
            <div class="stat">
                <div class="stat-label">Deletions</div>
                <div class="stat-value" style="color: #f44336;">-$($student.Deletions)</div>
            </div>
        </div>
"@
        
        if ($IncludeHistory -and $student.RecentCommits) {
            $html += "<h3>Recent Commits</h3><table><tr><th>Hash</th><th>Date</th><th>Message</th><th>Author</th></tr>"
            foreach ($commit in $student.RecentCommits) {
                if ($commit) {
                    $parts = $commit.Split('|')
                    if ($parts.Count -ge 4) {
                        $html += "<tr><td>$($parts[0])</td><td>$($parts[1])</td><td>$($parts[2])</td><td>$($parts[3])</td></tr>"
                    }
                }
            }
            $html += "</table>"
        }
        
        $html += "</div>"
    }
    
    $html += "</body></html>"
    $html | Out-File $OutputFile -Encoding UTF8
}

function Export-CSVReport {
    param($Data, $OutputFile)
    
    $csvData = $Data | Select-Object @(
        'Name',
        'LastCommitDate',
        'LastCommitRelative',
        'ShortHash',
        'LastMessage',
        'AuthorName',
        'TotalCommits',
        'FilesChanged',
        'Additions',
        'Deletions'
    )
    
    $csvData | Export-Csv -Path $OutputFile -NoTypeInformation
}

function Export-MarkdownReport {
    param($Data, $OutputFile, $Timestamp, $IncludeHistory)
    
    $md = @"
# Class Project Report

**Generated:** $Timestamp  
**Total Students:** $($Data.Count)  
**Total Commits:** $($Data.TotalCommits | Measure-Object -Sum | Select-Object -ExpandProperty Sum)

## Student Progress

"@
    
    foreach ($student in $Data) {
        $md += @"

### $($student.Name)

- **Last Activity:** $($student.LastCommitRelative) - ``$($student.LastCommitDate)``
- **Last Commit:** [$($student.ShortHash)] $($student.LastMessage)
- **Author:** $($student.AuthorName)
- **Statistics:**
  - Total Commits: **$($student.TotalCommits)**
  - Files Changed: **$($student.FilesChanged)**
  - Lines Added: **+$($student.Additions)**
  - Lines Deleted: **-$($student.Deletions)**

"@
        
        if ($IncludeHistory -and $student.RecentCommits) {
            $md += "`n#### Recent Commits`n`n"
            $md += "| Hash | Date | Message | Author |`n"
            $md += "|------|------|---------|--------|`n"
            
            foreach ($commit in $student.RecentCommits) {
                if ($commit) {
                    $parts = $commit.Split('|')
                    if ($parts.Count -ge 4) {
                        $md += "| $($parts[0]) | $($parts[1]) | $($parts[2]) | $($parts[3]) |`n"
                    }
                }
            }
        }
    }
    
    $md | Out-File $OutputFile -Encoding UTF8
}