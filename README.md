 # CS 131: Discrete Structures for Computer Science

## Instructions for Creating a Git Repository and Sharing It

### Part 1: Create a Local Git Repository

  1. Navigate to your project folder

  `cd C:\Users\username\Documents\dlockwood_cs131`

  2. Initialize a Git repository

  `git init`

  3. Add your files to the repository

  `git add .`

  4. Create your first commit

  `git commit -m "Initial commit"`

###  Part 2: Push to Github

  5. Create a remote repository

    - Log in to GitHub.com 

    - Click "New repository" or the "+" icon

    - Give it a name (e.g., "my-project")

    - Do NOT initialize with README, .gitignore, or license

    - Make repository public

    - Click "Create repository"

    - add a file to the repository - something like test.txt that contains some text.

  6. Link your local repository to the remote

  `git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git`

  7. Replace YOUR-USERNAME and YOUR-REPO-NAME with your actual values

  8. Push your code to the remote

  `git branch -M main`

  `git push -u origin main`

###  Part 3: Share the Repository URL

  9. Copy the repository URL

    - The URL format is: https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
