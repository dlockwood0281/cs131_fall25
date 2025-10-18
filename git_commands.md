## Initial Setup

```bash
# Create your main repository
git init class-project-main
cd class-project-main

# Add each student's repository as a submodule
git submodule add https://github.com/student1/project.git student1
git submodule add https://github.com/student2/project.git student2
# ... repeat for each student

git commit -m "Add student1 submodule"
```

## Key Management Tips

### 1. **Create an update script**
Make a simple script to pull all student updates at once:
```bash
#!/bin/bash
# update-all.sh
git submodule foreach git pull origin main
git add .
git commit -m "Update all student submodules $(date +%Y-%m-%d)"
```

### 2. **Clone instructions**
anyone accessing the main repo:
```bash
git clone --recurse-submodules <your-main-repo>
# OR if they already cloned:
git submodule init
git submodule update
```

### 3. **Set Up Useful Aliases**
Add these to your `.gitconfig`:
```bash
[alias]
    supdate = submodule update --remote --merge
    spull = submodule foreach git pull origin main
    sstatus = submodule foreach git status
```

### 4. **Monitor Student Progress**
Check the status across all submodules:
```bash
git submodule foreach 'echo "=== $name ===" && git log --oneline -5'
```

### 5. **Track Specific Commits for Grading**
When it's time to grade, you can lock each submodule to a specific commit:
```bash
cd students/student1
git checkout <commit-hash-at-deadline>
cd ../..
git add students/student1
git commit -m "Lock student1 submission at deadline"
```

## Common Gotchas to Avoid

- **Always commit submodule changes** - After updating submodules, commit the new references in the main repo
- **Consider using branches** in your main repo for different checkpoints (midterm review, final submission, etc.)
- **Use `--remote` flag** when you want to track the latest from student repos: `git submodule update --remote`

## Helpful .gitmodules Configuration

You can edit `.gitmodules` to make management easier:
```ini
[submodule "students/student1"]
    path = students/student1
    url = https://github.com/student1/project.git
    branch = main  # Specify which branch to track
```

