---
title: Don't use "git add ."
published: true
description: The main reasons why you should use git add -A instead of git add .
tags: git, development, cli
---

### TL:DR

`git add -A` will stages all changes
`git add .` will stages new files and modifications, without deletions
`git add -u` stages modifications and deletions, without new files

---

Wait, this post is in English. So keep going!

I never really thought about the mentor I did. He was not the teacher, he was a guide in this world of web development, just pointing my focus and attention to learn the right thing. And I remember when he told me to avoid using `git add .` and instead use `git add -A`.

At that time, I never thought about it, I just assumed I was doing it wrong, until yesterday I was wondering why there are two ways to add files to the stage area.

When you add files with `git add .`, you are adding every single file in the current folder, os structure, of anything like that, It's ok, you can do that, you can even add `git add *.js` for exemple.

But if you want to add any deletion, update and all changes in the other directories, in this case you should use add `git add -A`, this `-A` means **ALL**.

Another way is update only the updated files, without any test file, or some experimental code, in this case you can use `git add -u`, this `-u` means **UPDATE**.

Easy to remember, right?

(()=>{})()
