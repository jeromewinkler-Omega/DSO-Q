# Clone

# Git Workflow: Other User's Repo → Own Repo → Feature Branch → Pull Request

This guide walks through taking another user's repository, moving it into your own repository as `main`, cloning it onto your own PC, making all changes in a feature branch, and finishing with a pull request for review and approval.

---

## 1. Clone the other user's repo and push it to your own repo

> First, create a **new, empty repository** on GitHub/GitLab (no README, no `.gitignore`, no license).

```bash
git clone https://github.com/other-user/project.git
cd project

# Rename remotes: the original becomes "upstream", your repo becomes "origin"
git remote rename origin upstream
git remote add origin https://github.com/YOUR-USER/project.git

# Push the default branch as main (in case it is called "master", for example)
git branch -M main
git push -u origin main
```

Check your remotes:

```bash
git remote -v
```

---

## 2. Get the repo onto your own PC

> Only needed if step 1 was done on a different machine.

```bash
git clone https://github.com/YOUR-USER/project.git
cd project

# Later, to update your local main:
git pull origin main
```

---

## 3. Create a feature branch and make your changes

```bash
git switch -c feature/my-feature

# ... make your changes ...
git add .
git commit -m "Describe the change"

# Repeat as often as needed, then push
git push -u origin feature/my-feature
```

---

## 4. Update before the pull request (optional, but recommended)

```bash
git switch main
git pull origin main
git switch feature/my-feature
git merge main          # or: git rebase main
git push                # after a rebase: git push --force-with-lease
```

---

## 5. Create the pull request (review / approval)

**Via web UI:** GitHub will show a **"Compare & pull request"** button.
- Base (target): `main`
- Compare (source): `feature/my-feature`

**Via CLI (GitHub CLI):**

```bash
gh pr create --base main --head feature/my-feature \
  --title "My feature" \
  --body "For review and approval"
```

---

## 6. After approval and merge: clean up

```bash
git switch main
git pull origin main
git branch -d feature/my-feature
git push origin --delete feature/my-feature   # if the remote branch was not auto-deleted
```

---

## Tip: Pull in new changes from the original author

```bash
git fetch upstream
git switch main
git merge upstream/main   # or upstream/master
git push origin main
```

---

## Quick Reference

| Step | Command |
|------|---------|
| Clone other repo | `git clone <other-repo-url>` |
| Original → upstream | `git remote rename origin upstream` |
| Add own repo | `git remote add origin <your-repo-url>` |
| Rename branch to main | `git branch -M main` |
| Push to own repo | `git push -u origin main` |
| Clone to own PC | `git clone <your-repo-url>` |
| Create feature branch | `git switch -c feature/my-feature` |
| Commit changes | `git add . && git commit -m "..."` |
| Push feature branch | `git push -u origin feature/my-feature` |
| Create pull request | `gh pr create --base main --head feature/my-feature` |
| Sync with original | `git fetch upstream && git merge upstream/main` |
