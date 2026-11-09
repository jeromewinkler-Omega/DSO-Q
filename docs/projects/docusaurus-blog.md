# Docusaurus-Blog

<!--INSERT YOUR BRIEF DESCRIPTION HERE -->
A personal documentation and blog site built with Docusaurus. This guide walks through the complete setup — from creating an SSH key to running the site locally — and the feature-branch workflow used to submit changes via pull request.

## TOC

<!--INSERT YOUR TABLE OF CONTENTS HERE -->
- [Quickstart](#quickstart)
- [Description](#description)
- [Further References](#further-references)

import GithubLinkAdmonition from '@site/src/components/GithubLinkAdmonition';

<GithubLinkAdmonition 
    link="https://github.com/jeromewinkler-Omega/DSO-Q"
    title="Github Tip" 
    type="tip"
>
Checkout this repository to see the code/implementation
</GithubLinkAdmonition>

## Quickstart

### 1.  Configure Git (one-time setup)

Powershell:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### 2. Create an SSH key and add it to GitHub (one-time setup per PC)

Create the key. Confirm the file location by pressing Enter. Setting a passphrase is recommended but not necessary.

Powershell:

```bash
ssh-keygen -t ed25519 -C "your@email.com"
```

Confirm the file location by pressing Enter. 

Setting a passphrase is recommended but not neccessary.

Next, start the SSH agent so you don’t have to enter your passphrase every time. 

Powershell:

```bash
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
ssh-add $HOME\.ssh\id_ed25519
```

Then, copy the public key to your clipboard:

Powershell:

```bash
Get-Content $HOME\.ssh\id_ed25519.pub | Set-Clipboard
```

On GitHub, add it under Settings → SSH and GPG keys → New SSH key.

### 3. To test:

Terminal

```bash
ssh -T git@github.com
```


From VScode Temrinal 

to 

```bash
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
```

If you see "Hi yourname! You’ve successfully authenticated," it is working correctly.


### 4. Create your own repository from the template and clone it

Open the template repository in your browser, click **Use this template → Create a new repository**, then clone it:

Powershell:

```bash
cd C:\Directory
git clone https://github.com/YOUR-USER/project.git
cd project
```

 ### 5.Later, to update your local main:

```bash
git switch main
git pull origin main 
```


Alternatively, you can do this in your browser by clicking "Use this template" on the template repository page. Afterward, 

clone it using: 
```bash
git clone git@github.com:yourname/my-blog.git. 
```

### 6. Create a feature branch

Powershell:

```bash
git switch -c feature/setup-blog
```

### 7. Install dependencies

Powershell:

```bash
npm ci

```

:::note
`npm ci` installs the exact versions from `package-lock.json`. Use `npm install <package>` only when adding a new package.
:::

```bash
# if necessayry update your react-/ react-dom verion 
npm install react@19 react-dom@19 
npm run build
```
* Noch nicht committet

Powershell:
```bash
git restore package.json package-lock.json
npm ci
```
Damit sind beide Dateien wieder auf dem alten Stand, und npm ci installiert wieder React 18.

* Schon committet

Powershell:

```bash
git log --oneline          # Hash des Update-Commits suchen, z. B. a1b2c3d
git revert a1b2c3d
npm ci
git push

git revert erzeugt einen neuen Commit, der die Änderung wieder aufhebt. Das ist sicher, auch wenn du schon gepusht hast.
```


### 8. Create a .env file (if a .env.example file exists in the repo):

Terminal

```bash
Copy-Item .env.example .env
Then, enter your values ​​into the .env file.
```

### 9. Develop, build, and test

Powershell:

```bash
npm run start      # Development with live-reload, localhost:3000

npm run build      # Build the final site 
into the 'build' directory

npm run serve      # Test the build; press Ctrl + C to exit
```

### 10. Submit changes

Terminal

```bash
git add .
git commit -m "Setup blog"
git push -u origin feature/setup-blog
gh pr create --base main
```

If the CI check passes (turns green), merge the PR into the 'main' branch.
________________________________________
Steps 0 through 3 only need to be performed once per computer. For each new project, start from step 4.

## Description
This project is a static documentation and blog site built with [Docusaurus 3](https://docusaurus.io/), based on the Developer Akademie DevSecOps course template. It contains guides, a knowledge base (Containers, DevOps, Git, Linux) and project write-ups, and is available in English.
 
Key aspects of the setup:

- **Security:** `package-lock.json` stores an integrity hash (SHA-512) for each package, so tampered downloads are detected. Secrets live only in the local `.env` file, which is excluded via `.gitignore`.
- **Feature-branch workflow:** All changes are made in feature branches and merged into `main` through a pull request, which serves as the review and approval step.
- **CI/CD:** A GitHub Actions workflow builds the site on every pull request and deploys it to GitHub Pages after merging into `main`.
- **Dependency updates:** Dependabot opens pull requests for outdated packages. Each update is only merged if the CI build passes.


## Further References

- [Docusaurus Documentation](https://docusaurus.io/docs)
- [Docusaurus Deployment](https://docusaurus.io/docs/deployment)
- [GitHub Docs: Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [GitHub Docs: Creating a repository from a template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Dependabot Documentation](https://docs.github.com/en/code-security/dependabot)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [npm ci](https://docs.npmjs.com/cli/commands/npm-ci)
- [Git Documentation](https://git-scm.com/doc)