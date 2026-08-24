<!-- :shell>>> ~/core/codeBits/bin/emacs_package_com_to_md.rb mjr-code-tools.el -->
# Simple Emacs Tools For Software Development

Official Repository: https://github.com/richmit/mjr-code-tools

## Introduction

This package has some tools focused on editing and maintaining source code.  

 - `mjr-emerge-git-conflict`  Merge git conflicts
 - `mjr-fix-c-includes-der`   Reformat include lines in C/C++ to be pretty
 - `mjr-github-url`           Return the GitHub URL for the current repo
 - `mjr-quick-code-comment`   Add preformatted comments from templates 
 - `mjr-add-header-der`       Add a header at the top of source files

## WARNINGS

 - Some of the functionality is dependent upon my development process -- for example the file layout I use for projects.
 - Some of this code is usless without support files: https://github.com/richmit/codeBits
 - A better, more modern, alternative to `mjr-quick-code-comment` & `mjr-add-header-der` is Autoinsert + yasnippet.
 - The function `mjr-emerge-git-conflict` is pretty irrelevant now days considering the level of modern git support in Emacs.

## Installing

The easiest way to install `mjr-code-tools` is to pull it directly from github:

     (package-vc-install (list 'mjr-code-tools
                          :url "https://github.com/richmit/mjr-code-tools"
                          :rev 'newest))

You can also just download the primary Lisp file, load it into a buffer, and then run 'M-x package-install-from-buffer'.
