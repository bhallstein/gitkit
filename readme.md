# gitkit ⚡️

gitkit is a fairly minimal set of git bash aliases & functions, to help ease the pain of git's incredibly verbose [command line interface](http://stevelosh.com/blog/2013/04/git-koans/), and make you fly around in git like a bat on steroids. 🦇


## Contents

- [Installation](#installation)
- [Commands](#commands)


## Installation

Just run `gitkit/install.sh`:

```bash
bash install.sh
```

Or:

```bash
bash install.sh ~/.profile   # Specify your bash profile file path up-front
                             # (unattended install)
```


## Usage

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
Switched to branch 'temp--orphan-scraper'
```

```bash
$ gch .            # Discard all unstaged changes since parent commit
$ gch -- index.js  # Discard changes to index.js since parent commit
```

`gch` has variants for a couple of common branch names:

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
 * [new branch]          custom-cta  -> origin/custom-cta
```

```bash
$ gtp
Updating c7982c0d3..c3dbd0648
Fast-forward
 src/blog/blog.js                       |  3 ++-
 src/content/partials/header.js         | 12 ++++++++++++------
```


### gtl: git diff

```
$ gtl
--- a/src/index.js
+++ b/src/index.js
@@ -2,3 +2,4 @@

+import './module-2';
```

`gtl` has variants for showing only cached changes (`git diff --cached`) or file names:

```bash
$ gtlc
diff --git a/index.php b/index.php
index 348ab52..d528d10 100644
--- a/index.php
+++ b/index.php
@@ -20,6 +20,13 @@

+  function func() {
+    return function() { };
+  }
+
```

```bash
$ gtln
D   assets/lightbulb.svg
M   index.js
```


### gh: show what changed in a commit

With no arguments: show changes made in the HEAD commit:

```bash
$ gh
--- a/classes/utils/numbers.php
+++ b/classes/utils/numbers.php
@@ -137,3 +137,16 @@
  function nine() {
-    return 8;
+    return 9;
  }
```

With commit argument: show changes made in the specified commit:

```bash
$ gh c1bf9dff9
--- a/classes/utils/letters.php
+++ b/classes/utils/letters.php
@@ -137,3 +137,16 @@
  function letter_b() {
-    return 'c';
+    return 'b';
  }
```


### gad & gcom — git add & git commit

With `git add`, you usually want `-u` to include file deletions, and you usually want to add everything under the current directory, so that's what `gad` does.

It calls `gts` afterwards, so you can see what you've staged, helping to prevent commit errors.

```bash
$ gad
On branch integration
Your branch is up to date with 'origin/integration'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

  modified:   index.php
```

`gadn` is a variant that uses `-N`, to add previously untracked files to the index without staging them:

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
$ gcom add file.js
[integration 34df9305d] add file.js
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 x.js
```

Be careful to use quotes if you include special characters like `&` in your commit message:

```bash
$ gcom 'add new.js & delete old.js'
```


### gm — git merge

Always merge in two stages. `gm` includes `--no-ff --no-commit`:

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

$ gcom Merge
[integration 311d38891] Merge

👍
```


### gD — git branch -D

Delete branches. The D is capitalised to avoid accidental usage.

```bash
$ gD my-branch
Deleted branch my-branch (was c3dbd0648).
```

`gD` has a variant to delete all local branches that are 'merged' from the point of view of HEAD:

```bash
$ gDmerged
Deleted branch my-branch (was c7982c0d3).
```

...and to delete **all unmerged** branches (you could hurt yourself with this, but it will skip unmerged branches, so probably not too badly):

```bash
$ gDall
Deleted branch core__asset-backend-revisions__scrapers (was 0ca561f41).
error: The branch 'temp--orphan-scraper' is not fully merged.
If you are sure you want to delete it, run 'git branch -D temp--orphan-scraper'.
```


### gbm — git branch -m

Rename the current branch.

```bash
$ gch temp-branch
$ gbm my-feature
```


### gtt — fancy git log

`gtt` shows what I call ‘traintracks view’:

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

`gtts` (for ‘single’) is a variant that doesn’t show unmerged branches.


### gpoh — git push origin HEAD

The fastest way to push your work.

```bash
$ gpoh
Counting objects: 2, done.
...
To github.com:BrandwatchLtd/brandwatch.com.git
   c3dbd0648..b8b86da89  HEAD -> temp
```

`gpohu` is a variant that sets the upstream tracking reference. It's often a good idea to use `gpohu` when pushing a newly created branch:

```bash
$ gch -b my-branch
Switched to a new branch 'my-branch'

$ gpohu
To github.com:BrandwatchLtd/brandwatch.com.git
 * [new branch]          HEAD -> my-branch
Branch 'my-branch' set up to track remote branch 'my-branch' from 'origin'.
```


### gri & grc — git rebase

For the advanced rebaser.

`gri <commit> <branch>` rebases everything from `commit` up to the HEAD of `branch` onto `integration` — `commit` should be the first ancestor of `branch` that does not contain any changes in `branch`.

i.e. it runs `git rebase --onto integration <commit> <branch>`

```bash
$ gri c7982c0d3 temp-text-helper-improvements
First, rewinding head to replay your work on top of it...
Applying: initial work
```

Run `grc` when you've fixed conflicts, it simply calls `git rebase --continue`.


### gcl — git clean -fd

Removes untracked files. You could lose work if you meant to `gadn` and `gcom` those files.

```
$ touch a-file
$ gcl
Removing a-file
```
