# Class Management Scripts

Run these from the repository root:
- `.\scripts\Update-StudentSubmodules.ps1` - Pull all student updates
- `.\scripts\Get-StudentProgress.ps1` - Generate progress report
- 
## Usage

Save any of these scripts as .ps1 files in your main repository
Run them from PowerShell:

```powershell
# Basic update
.scripts\Update-ClassSubmodules.ps1


# Update and push
.scripts\Update-ClassSubmodules.ps1 -Push

# Update from different branch
.\scripts\Update-ClassSubmodules.ps1 -Branch develop
```

If you get execution policy errors, run this once:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```