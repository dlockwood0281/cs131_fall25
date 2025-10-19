# Generate HTML report (default)
```powershell
.\scripts\Export-ClassReport.ps1
```

# Generate all formats
```powershell
.\scripts\Export-ClassReport.ps1 -Format All
```

# Generate Markdown with commit history and open when done
```powershell
.\scripts\Export-ClassReport.ps1 -Format Markdown -IncludeCommitHistory -OpenWhenDone
```

# Generate CSV for data analysis
```powershell
.\scripts\Export-ClassReport.ps1 -Format CSV
```