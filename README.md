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

###  Part 2: Push to a Remote Repository

  5. Create a remote repository

    - Log in to GitHub.com (or GitLab/Bitbucket)

    - Click "New repository" or the "+" icon

    - Give it a name (e.g., "my-project")

    - Do NOT initialize with README, .gitignore, or license

    - Click "Create repository"

  6. Link your local repository to the remote

  `git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git`

  7. Replace YOUR-USERNAME and YOUR-REPO-NAME with your actual values

  8. Push your code to the remote

  `git branch -M main`

  `git push -u origin main`

###  Part 3: Share the Repository URL

  9. Copy the repository URL

    - The URL format is: https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git

    - Or use SSH format: git@github.com:YOUR-USERNAME/YOUR-REPO-NAME.git

  10. Share this URL with others

    - Send them the full URL

    - Example: "The repository is at https://github.com/johndoe/my-library.git"

---

## for Admin use
 
###  Part 4: How Others Add It as a Submodule

  When someone receives your repository URL, they can add it as a submodule:

  `git submodule add https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git path/to/submodule`

 `git commit -m "Add submodule"``

  ---

## Key Information to Share:

  - Repository URL (e.g., https://github.com/username/repo-name.git)

  - Optionally: a specific branch name if they should use something other than main

  - Optionally: a specific commit/tag if they need a particular version

  That's it! The most important thing is the repository URL from step 8.

----

## Syllabus

  Fall 2025 - Section #15735
  Los Angeles Pierce College

  Course Information

  - Instructor: Y. Yuen
  - Email: yueny@laccd.edu

  Course Description

  This course provides students with knowledge of discrete structures theory used in Computer Science, with emphasis on applications. Topics include Sets, Functions, Sequences, Sums, Matrices, Algorithms, Number Theory and Cryptography, Recursion, Counting, Probability, Relations, Graphs, Trees, Boolean Algebra, and Modeling Computation.

  Required Textbook

  Discrete Mathematics and its Applications, 8th Edition
  By Kenneth H. Rosen

  - ISBN-13: 1260501752 / ISBN-10: 9781260501759
  - eBook: ISBN-13: 9781260091991 / ISBN-10: 1260091996

  Learning Outcomes

  Upon successful completion, students will be able to:

  - Describe logic and discrete structures fundamentals
  - Explain differences between Sets, Functions, Sequences, Sums, and Matrices
  - Analyze Number Theory and Cryptography applications
  - Apply Recursion, Counting, and Probability concepts
  - Work with Recurrence Relations, Graphs, and Trees
  - Understand Boolean Algebra and Computation Models
  - Utilize discrete logic concepts in various programming languages
  - Develop programs using discrete logic principles

  Grading Breakdown

  | Category | Points  | Percentage |
  |---|---|---|
  | Homework Assignments (14-15)| 168-180 | 16.8%-18%  |
  | Others (Project, Presentation, Reviews, Participation, Discussions) | 50-62   | 5.0%-6.2%  |
  | Quiz 1  | 120     | 12%        |
  | Midterm Exam 1 | 200     | 20%        |
  | Midterm Exam 2 | 225     | 22.5%      |
  | Final Exam     | 225     | 22.5%      |
  | Total          | 1000    | 100%       |

  Course Schedule

  | Date       | Topics | Assignments/Exams |
  |---|---|---|
  | 09/08/2025 | Chapter 1: Logic and Proof |                                    |
  | 09/15/2025 | Chapter 1: Logic and Proof |                                    |
  | 09/22/2025 | Chapter 2: Set, Function, Sequence, Sums, Matrices | HW Assignment 1                    |
  | 09/29/2025 | Chapter 3: Algorithms                              | HW Assignment 2                    |
  | 10/06/2025 | Chapter 3 & 4: Algorithms                          | HW Assignment 3, Quiz 1            |
  | 10/13/2025 | Chapter 4: Number Theory                           | HW Assignment 4                    |
  | 10/20/2025 | Chapter 4: Cryptography                            | HW Assignment 5                    |
  | 10/27/2025 | Chapter 5: Induction & Recursion                   | HW Assignment 6, Midterm Exam 1    |
  | 11/03/2025 | Chapter 6: Counting                                | HW Assignment 7                    |
  | 11/10/2025 | Chapter 7: Probability                             | HW Assignment 8                    |
  | 11/17/2025 | Chapter 8: Advanced Counting                       | HW Assignment 9                    |
  | 11/24/2025 | Chapter 9: Relations                               | HW Assignment 10, Midterm Exam 2   |
  | 12/01/2025 | Chapter 10: Graphs                                 | HW Assignment 11                   |
  | 12/08/2025 | Chapter 11 & 13: Tree, Finite-State Machines       | HW Assignment 12, Project Due      |
  | 12/15/2025 | Final Exam                                         | HW Assignments 13 & 14, Final Exam |

  Important Policies

  Homework Submissions

  - Format: Hand-written, scanned, and submitted as a single PDF file
  - Must be legible and organized (digitally written assignments not accepted)
  - Each page must have your full name in the top-right corner
  - Answers should be thorough with complete reasoning
  - Present responses in numerical order, vertically on each page (3-4 responses per page)
  - Include question numbers for omitted questions
  - No late submissions accepted
  - No plagiarism - copying from textbook or other sources results in zero points

  Attendance

  - Mandatory attendance for all online live sessions
  - Roll call taken once per class at random times
  - Students may be dropped for extended absences (>10 days)
  - Log in to Canvas at least once weekly

  Exams

  - All exams conducted online during class time
  - 2-3 hours duration per exam
  - Use of AI or other forms of academic dishonesty strictly prohibited
  - Cheating, plagiarism, or collaboration violations will result in disciplinary action

  Project

  - Choose a topic related to discrete logic
  - Submit presentation video
  - Project files submitted to class GitHub repository

  Academic Integrity

  Academic dishonesty is prohibited and includes:
  - Cheating on exams
  - Plagiarism
  - Unauthorized collaboration
  - Submitting same work to multiple instructors
  - Impersonation

  Violations result in zero points, possible dismissal from class, and college disciplinary action.

  Important Notes

  - No extra credit assignments offered
  - No incomplete status allowed at semester end
  - Webcam use in Zoom sessions is optional
  - Respect and professionalism required in all interactions

  Contact

  For questions or concerns, contact the instructor immediately via Canvas Inbox or email. All emails answered within 24 hours.

  ---
  This syllabus is subject to change. Students will be notified of any modifications.
