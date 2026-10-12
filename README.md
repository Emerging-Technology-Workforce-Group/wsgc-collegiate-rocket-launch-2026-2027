# [Project name here]

*Insert section detailing the problem description, problem statement, and brief solution description. All other documentation and design files will be organized categorically within*

### Work item repo contributions with GitHub desktop:
(1) Locate the remote repo and clone to your local machine; if the repo already exists on your desktop, "Pull" from remote repo to update local repo with up-to-date changes.\
(2) Checkout (create) a new branch and name it corresponding to the managed work item matching this format: *ticket-id*_short_name. [^1]\
(3) Change the status of the work item to "In Progress".\
(4) Complete the required tasks on your local machine and add helpful screenshots and comments to the work item (don't forget to @ tag team members when necessary). Save often and plan to "commit" to the repo only once your work is reasonably fleshed out [^2].\
(5) Stage any relevant working files and discard any irrelevant files/folders before committing.\
(6) Commit your work and make sure that the commit title matches this format: "*ticket-id* brief commit description <50 characters". It is generally necessary to include a longer secondary description that details the work done along with its intent so that future contributors can more easily understand the historical development process.\
(7) "Pull" up-to-date changes from the main branch on the remote repo down to your local machine to address potential merge conflicts between your working branch and the main branch later on.\
(8) "Push" the working branch commit(s) from your local machine to the remote repo.\
(9) Make a GitHub "Pull Request" to initiate a review of your work and eventual merge to the main branch. [^3] If the pull request is denied, respond as required.\
(10) Once the pull request is approved, merge the working branch to main on the remote repo. After this, you can "Pull" this newest up-to-date change from the remote repo down to your local repo.\
(11) On the remote repo and in the local repo, delete the working branch.\
(12) Add a sign off comment on the managed work item and update its status to "Done".

[^1]: If you notice the new branch is made with an incorrect name, delete it and try again.
[^2]: If the work item is extensive and/or multifacted (not just one simple, short task) and requires several days and/or commits to complete, repeat steps 4-8 until the work item is ready for a review or to be closed.
[^3]: It can be useful to utilize the pull request to trigger a review process at intermediate stages. Don't forget to @ tag other team members as necessary.

### Work item repo contributions with a CLI:
`$ git clone <remote-url>` [^4]\
`$ git pull origin` [^5]\
`$ git checkout -b <ticket-id>_short_name origin/main` [^6]\
Do work on the feature branch created in the previous step.\
`$ git add <file names>`\
`$ git commit -m "<ticket-id> brief commit description <50 characters"`\
`$ git pull origin main` [^7]\
`$ git push -u origin <feature branch>`\
Go to the remote and make a Compare and Pull Request to submit changes for review.\
In the repo's Pull Request section, respond to the reviewer's comments and update any work as required.\
Merge the pull request to the remote main branch.\
`$ git switch main`
`$ git push origin --delete <feature branch>`\
`$ git branch -d <feature branch>`\
Add a sign off on the work item in your management list and update its status to "Done".

[^4]: When cloning a repo from the remote location, generally use the HTTPS option.
[^5]: If the local repo does not seem to have a link to the remote, verify existing remotes and create a link called 'origin' using the following CLI: `$ git remote -v`\ `$ git remote add origin <remote-url>`
[^6]: If you notice the new branch is made with an incorrect name, use the following CLI: `$ git branch -D <branch-name>`
[^7]: If the local commit history lags the remote's commit history, you want to bring the up-to-date changes on remote down to the local repo in order to proactively deal with potential merge conflicts that might cause a pull request denial later.
