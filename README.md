Repository with git extra's
===========================

This repository contains:

* Git client side hooks

See also [Git documentation](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)

Git hooks
---------
Git has a way to fire off custom scripts when certain important actions (like `git commit` or
`git push`) occur. There are two groups of these hooks: client side and server side.

Examples of server side hooks are:

* restrict file size
* enforce a valid JIRA number in the commit message.

On our Stash server, the JIRA issue number hook can be enabled via the *Yet Another Commit Checker*
plugin. If enabled and the user tries to push a commit without a valid JIRA issue number, the push
is rejected by the server.

A file size limit is enforced via *File Size Hook* plugin on all repositories. Every night a
script is scheduled to enable the hook with a file size limit of 10M on all repositories.
In general this should be more than high enough and keeps the git repository on the server
free of big files.
If it is required to allow bigger files occasionally (you'd have to have a really good
reason though), it is possible to configure a different file size limit per repository via:

* \<repository\>/Settings/Hooks/File Size Hook

Please note that: this limit will be reset to 10M every night automatically.

Install client side hooks
-------------------------

Client side hooks live in your local repository folder at the following location:

	- <repository>/.git/hooks

It is important to note that client-side hooks are not copied when you clone a repository.
If you want to prevent yourself from committing changes into your local git repository without
a valid commit message or accidentally committing very big files, you need to install
client-side-hooks in *every* local git repository.

You can do this by cloning this repository and run "install-hooks.bat" or "install-hooks.sh"
from folder where all your git repositories reside. Or you can specify a specific path as
argument. E.g.:

Windows cmd:

	\> <path to cm-git>\install-hooks.bat C:\Git\My-repo
	\> cd C:\Git; <path to cm-git>\install-hooks.bat

Windows git bash:

	$ /<drive>/<path to cm-git>/install-hooks.sh .
	$ cd /<drive>/Git; /<drive>/<path to cm-git>/install-hooks.sh

Linux terminal:

	$ <path to cm-git>/install-hooks.sh ~/Git/my-repo
	$ cd ~/Git; <path to cm-git>/install-hooks.sh

Change limits pre-commit hook
-----------------------------

The pre-commit hook on the client and pre-receive hook on the server have default limits:

* filesize hard limit (default 10M): the commit or push is rejected
* filesize soft limit (default 1M): the commit or push is not rejected but a warning message is printed

You can change the limits on the client (inside a repository):

	$ git config hooks.filesizehardlimit 1000000
	$ git config hooks.filesizesoftlimit 500000

Add --global if you want to add the hooks on a global level.

