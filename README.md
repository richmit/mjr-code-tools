# mjr-code-tools

This package has some tools focused on editing and maintaining source code.  For example things like:

  - Code generation
  - Comment templates
  - C/C++ header file database & formatting
  - Source file header comments & templates
  - Etc...
  
Be warned that some of the functionality is dependent upon my development process -- for example the file layout I use for projects.
            
The easiest way to install mjr-code-tools is to pull it directly from github:

     (package-vc-install (list 'mjr-code-tools
                          :url "https://github.com/richmit/mjr-code-tools"
                          :rev 'newest))
