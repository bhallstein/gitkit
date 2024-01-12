# gitkit ⚡️

gitkit is a small ’n simple set of git bash aliases & functions, to help ease the pain of git's rather [verbose command line interface](http://stevelosh.com/blog/2013/04/git-koans/), to let you fly around in git like a bat on steroids. 🦇


## Contents

- [Installation](#installation)
- [Commands](#commands)


## Installation

```bash
bash install.sh
```

Or for unattended install:

```bash
bash install.sh ~/.profile   # Specify your bash profile file path up-front
```


## Commands

### gts: git status

```bash
$ gts
On branch master
Your branch is up to date with 'origin/master'.

$ gts src
On branch integration
Your branch is up to date with 'origin/integration'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

  modified:   main.c
```

### gch: git checkout

```bash
$ gch my-branch
Switched to branch 'my-branch'
```

```bash
$ gch .            # Discard all unstaged changes since parent commit
$ gch -- index.js  # Discard changes to index.js since parent commit
```

`gch` has two variants for common branch names `integration` and `master`:

```bash
$ gchi
Switched to branch 'integration'
````

```bash
$ gchm
Switched to branch 'master'
````


### gf & gtp — git fetch & git pull

You almost always want the options `--all --prune`, so that's what gf does.

Note: for safety, you should usually `gf` and `gts` before you `gtp`.

```bash
$ gf
Fetching origin...
From github.com:<x>
   c7982c0d3..c3dbd0648  integration -> origin/integration
 * [new branch]          my-branch   -> origin/my-branch
```

```bash
$ gtp
Updating c7982c0d3..c3dbd0648
Fast-forward
 src/blog.js                    |  3 ++-
 src/header.js                  | 12 ++++++++++++------
```


### gtl: git diff

```
$ gtl
--- a/src/index.js
+++ b/src/index.js
@@ -2,3 +2,4 @@

+import './math';
```

`gtl` has variants for showing only cached changes (`git diff --cached`):

```bash
$ gtlc
diff --git a/index.js b/index.js
index 348ab52..d528d10 100644
--- a/index.js
+++ b/index.js
@@ -20,6 +20,13 @@
-  const animation_speed = 10;
+  const animation_speed = 20;
```

And file status changes: (`git diff --name-status`):

```bash
$ gtln
D   assets/settings.svg
M   index.js
```


### gh: diff an specified commit with its parent

```bash
$ gh c1bf9dff9
--- a/alphabet.js
+++ b/alphabet.js
@@ -137,3 +137,16 @@
  function b() {
-    return 'c';
+    return 'b';
  }
```

When called with no argument, `gh` diffs HEAD with HEAD^.


### gad & gcom — git add & git commit

`gad` adds everything under the current directory, and uses `-u` to include file deletions. It calls `gts` afterwards, to show you what you've got staged.

```bash
$ gad
On branch integration
Your branch is up to date with 'origin/integration'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

  modified:   index.js
```

`gadn` includes `-N` and adds new files to the index but doesn't stage them:

```bash
$ touch file.js
$ gadn
On branch integration
Your branch is up to date with 'origin/integration'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

  new file:   file.js
```

`gcom` takes the commit message as the full string of its arguments:

```bash
$ gcom add a new file
[integration 34df9305d] add a new file
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 x.js
```

Make sure to use quotes if your commit message includes special characters like `&`:

```bash
$ gcom 'add new.js & delete old.js'
```


### gm — git merge

`gm` includes `--no-ff --no-commit`.

You should always merge in two stages: `gm`, then `gcom`.

```bash
$ gchi
Switched to branch 'integration'
Your branch is up to date with 'origin/integration'.

$ gm text-util-update
Automatic merge went well; stopped before committing as requested

$ gts
On branch integration
Your branch is up to date with 'origin/integration'.

All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:

  modified:   classes/utils/text.php

$ gcom merge branch text-util-update
[integration 311d38891] merge branch text-util-update

👍
```


### gb — git branch --all

List all branches.
```bash
$ gb
$ gb | grep hotfix
```


### gD — git branch -D

Delete branches. The D is capitalised to avoid accidental usage.

```bash
$ gD my-branch
Deleted branch my-branch (was c3dbd0648).
```

`gDmerged` is a variant to delete all local branches that are merged from the point of view of HEAD:

```bash
$ gDmerged
Deleted branch my-branch (was c7982c0d3).
```

...and `gDall` deletes **all unmerged** local branches (you could hurt yourself with this, but it will skip unmerged branches without remotes, so probably not too badly):

```bash
$ gDall
Deleted branch a-feature (was 0ca561f41).
error: The branch 'another-feature' is not fully merged.
If you are sure you want to delete it, run 'git branch -D another-feature'.
```


### gbm — git branch -m

Rename the current branch.

```bash
$ gch temp-branch
$ gbm my-feature
```


### gtt — fancy git log

`gtt` displays ‘traintracks view’:

```bash
$ gtt
* c3dbd0648 (HEAD -> integration, origin/integration) prod build
* aa795e9d1 WBT-2287: add natural height opt to cd hero
* db259e9d0 Noindex all blog archives except author
| * 1fb6c8b11 (temp-text-helper-improvements) helper func improvements: initial work
| | * cb94cc365 (origin/custom-cta) new custom button text field
| | * c6e7bd2b2 enable custom text on ctas
| |/
|/|
* | 12aab6354 only output images if required data is present
|/
* c7982c0d3 minor routing fix
*
...
```

`gtts` (for ‘single’) is a variant that only includes the history that has been merged into HEAD.


### gpoh — git push origin HEAD

The fastest way to push.

```bash
$ gpoh
Counting objects: 2, done.
...
To github.com:bhallstein/gitkit.git
   c3dbd0648..b8b86da89  HEAD -> my-branch
```

`gpohu` is a variant that sets the upstream tracking reference. It's often a good idea to use `gpohu` when pushing a newly created branch:

```bash
$ gch -b my-branch
Switched to a new branch 'my-branch'

$ gpohu
To github.com:bhallstein/gitkit.git
 * [new branch]          HEAD -> my-branch
Branch 'my-branch' set up to track remote branch 'my-branch' from 'origin'.
```


### gr, gri, grc — git rebase

For the rebaser.

`gr <a> <b> <c>` rebases commits ranging [b to c] onto a. (`git rebase --onto a b c`).

`gri <a> <b> <c>` as `gr`, but with --interactive

```bash
$ gr origin/utils c3dbd0648 text-utils
First, rewinding head to replay your work on top of it...
Applying: initial work
...
```

`grc` calls `git rebase --continue`, for when you have finished fixing conflicts during a rebase.


### gcl — git clean -fd

Removes untracked files. (Note: you could lose work if you meant to `gcom` those files!)

```
$ touch my-file
$ gcl
Removing my-file
```

