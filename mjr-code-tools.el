;;; mjr-code-tools.el --- source code tools -*- lexical-binding:t; coding: utf-8; mode:emacs-lisp; fill-column:158 -*-

;; Copyright (c) 2026-2026 Mitch Richling <https://www.mitchr.me>.  All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
;;
;; 1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.
;;
;; 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
;;    and/or other materials provided with the distribution.
;;
;; 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without
;;    specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
;; TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;; Author:      Mitch Richling <https://www.mitchr.me>
;; Version:     0.10
;; URL:         https://github.com/richmit/mjr-code-tools

;; This file is not part of Emacs

;;; Commentary:
;; See the README: https://github.com/richmit/mjr-code-tools/

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defgroup mjr-code-tools nil
  "mjr-code-tools."
  :group 'convenience
  :group 'development)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-github-url-default nil
  "The URL `mjr-github-url' returns when no github remote is found."
  :type '(choice string (const nil))
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-quick-code-comment-types '(
                                          ("ToDo"            . ("TODO WHO <DATE> CONTEXT: "))                 ;; TODO Marker
                                          ("Modification"    . ("MOD WHO <TIME> CONTEXT: "))                  ;; Modification
                                          ("Modification"    . ("MOD WHO BEGIN ----------------------- TIME"
                                                                "MOD WHO END ------------------------- TIME"))
                                          ("Debug"           . ("DEBUG WHO <TIME> CONTEXT: "))                ;; Code added for debug.  Normally deleted before published.
                                          ("Debug"           . ("DEBUG WHO BEGIN --------------------- TIME"
                                                                "DEBUG WHO END ----------------------- TIME"))
                                          ("Source Snippet"  . ("SS-BEGIN:TAG:"                               ;; Source Snippet Delimiters.
                                                                "SS-END:TAG:"))
                                          ("Coverage"        . ("COVERAGE WHO <DATE> CONTEXT: "))             ;; Test coverage
                                          ("SCM"             . ("SCM WHO <TIME> CONTEXT: "))                  ;; Transient comment. Pasted into SCM logs and removed before check-in.
                                          ("SHELLO"          . ("SHELLO: "))                                  ;; SHELLO comments for use with mjr-one-liner
                                          ("LISPOO"          . ("LISPOO: "))                                  ;; LISPOO comments for use with mjr-one-liner
                                          ("Bug"             . ("BUG WHO <DATE> CONTEXT: "))                  ;; Bug!
                                          ("Review"          . ("REVIEW WHO <TIME> CONTEXT: "))               ;; Code review comment
                                          )
  "Templates for `mjr-quick-code-comment'."
  :type 'list
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-quick-code-comment-who nil
  "The value for the WHO macro expanded by `mjr-quick-code-comment'.  If NIL, then the function `user-real-login-name' will be used."
  :type '(choice string (const nil))
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-fix-c-includes-der-db nil
  "File containing the header DB used by `mjr-fix-c-includes-der'."
  :type '(choice file (const nil))
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-add-header-der-templates nil
  "Directory holding template files for `mjr-add-header-der'."
  :type 'string
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-add-header-der-licenses nil
  "Directory holding licence files for `mjr-add-header-der'."
  :type 'string
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-add-header-der-login-name nil
  "The value for the LOGIN-NAME macro expanded by `mjr-add-header-der'.  If NIL, then the function `user-real-login-name' will be used."
  :type '(choice string (const nil))
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-add-header-der-legal-name nil
  "The value for the LEGAL-NAME macro expanded by `mjr-add-header-der'."
  :type '(choice string (const nil))
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-add-header-der-git-email nil
  "The value for the GIT-EMAIL macro expanded by `mjr-add-header-der'.  If NIL then the value from git config will be used."
  :type '(choice string (const nil))
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defcustom mjr-add-header-der-mode-to-ext '((c++-mode              . "cpp")
                                            (c-mode                . "c")
                                            (cmake-mode            . "cmake")
                                            (emacs-lisp-mode       . "elisp")
                                            (ess-r-mode            . "R")
                                            (fortran-mode          . "f95")
                                            (inf-ruby-mode         . "rb")
                                            (inferior-ess-r-mode   . "R")
                                            (java-mode             . "java")
                                            (js-mode               . "js")
                                            (latex-mode            . "tex")
                                            (lisp-interaction-mode . "elisp")
                                            (makefile-gmake-mode   . "make")
                                            (makefile-mode         . "make")
                                            (org-mode              . "org")
                                            (perl-mode             . "pl")
                                            (ps-mode               . "ps")
                                            (ruby-mode             . "rb")
                                            (sh-mode               . "sh")
                                            (slime-repl-mode       . "lisp")
                                            (sql-mode              . "sql"))
  "Used to map Emacs major modes to file extensions."
  :type 'alist
  :group 'mjr-code-tools)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun mjr-emerge-git-conflict (file-name)
  "Merge a git conflict with ediff merge."
  (interactive "fFile to merge: ")
  (cl-loop for buf = (find-buffer-visiting file-name)
           while buf
           do (kill-buffer buf))
  (let ((fileA (make-temp-file "ediffmerge"))
        (fileB (make-temp-file "ediffmerge"))
        (fileM (make-temp-file "ediffmerge")))
    (call-process "git" nil (list :file fileA) nil "show" (concat ":2:" (file-name-nondirectory file-name))) ;; ME
    (call-process "git" nil (list :file fileB) nil "show" (concat ":3:" (file-name-nondirectory file-name))) ;; THEM
    (call-process "git" nil (list :file fileM) nil "show" (concat ":1:" (file-name-nondirectory file-name))) ;; UP
    (ediff-merge-files-with-ancestor fileA fileB fileM #'ediff-cleanup-mess file-name)
    (delete-file fileA)
    (delete-file fileB)
    (delete-file fileM)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun mjr-one-liner ()
  "Find & evaluate a /one liner/ construct at the point or in the active region, and place the results on the kill ring.
One liner constructs:
  - SHELLO ... `shell-command-to-string' is used to evaluate the code and the resulting STDOUT is placed on the kill ring.
  - LISPO .... Code is parsed via `read-from-string' & evaluated.  The value is serialized and placed on the kill ring.  Serialization via `format' with %s.

Typical one line constructs have the form:

     ... LANGUAGE_TOKEN: commands/forms to evaluated

The LANGUAGE_TOKEN is one of SHELLO or LISP.  Any preceding text on the line is ignored.  The construct continues to the end of the line.  If the buffer's
current mode indicates an `comment-end' token, then that token will be removed from the end of the construct.


In spite the name of this function, multi-line code blocks are supported.  To use them at least one character of the construct's first & last lines must be
contained in the active region.  This region is expanded to the start of the first line and the end of the last line.  Blank lines are removed, the remaining
lines are stripped of any common prefix string, the LANGUAGE_TOKEN structure on the first line is removed, and the resulting code is evaluated.

My primary use case is to embedded these structures into programming language comments where the one liner is used to generate code."
  (interactive)
  (let* ((reg-act (region-active-p))                                                                               ;; Is region active
         (bor     (if reg-act (region-beginning) (point)))                                                         ;; Start of region or point
         (eor     (if reg-act (region-end)       (point)))                                                         ;; End of region or point
         (bor-bol (progn (goto-char bor) (line-beginning-position)))                                               ;; Start of the first line of region or line with point
         (eor-eol (progn (goto-char eor) (line-end-position)))                                                     ;; End of the last line of region or line with point
         (com-end (if (boundp 'comment-end) comment-end))                                                          ;; Comment end string
         (reg-raw (buffer-substring-no-properties bor-bol eor-eol))                                                ;; String with lines containing code
         (reg-str (if com-end
                      (string-remove-suffix com-end (string-trim-right reg-raw))
                      reg-raw))
         (reg-lin (string-split reg-str "[\n\r]+" t))                                                              ;; List of non-blank lines
         (lin-one (car reg-lin)))                                                                                  ;; First line (string)
    (when (null lin-one)
      (error "mjr-one-liner: Could not extract region"))
    (let ((tok-loc (string-match "\\(SHELL\\|LISP\\)O:" lin-one)))                                                 ;; Location of shello token
      (unless tok-loc
        (error "mjr-one-liner: Could not find one-liner start token"))
      (let* ((lan-tok (if (char-equal ?S (aref lin-one tok-loc)) "SHELL" "LISP"))                                  ;; language token
             (cod-str (substring (mapconcat (lambda (s) (substring s tok-loc)) reg-lin "\n")                       ;; Code string
                                 (if (string-equal lan-tok "SHELL") 7 6)))
             (cod-res (cond ((string-equal lan-tok "LISP")  (format "%s" (eval (car (read-from-string cod-str))))) ;; code result
                            ((string-equal lan-tok "SHELL") (shell-command-to-string cod-str)))))
        (unless (stringp cod-res)
          (error "mjr-one-liner: Something went horribly wrong during evaluation!"))
        (message "Code evaluation resulted in %d characters of output placed on the kill ring." (length cod-res))
        (kill-new cod-res)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun mjr-quick-code-comment ()
  "Add MJR comment at point/around region.

The MJR comments come in one of two forms (depending of if a region is selected when the function is executed):
  * Region: Two formatted comment lines are added on the line before and line after the current region.
  * Line: A formatted comment line is added after the current line (cursor placed ready for content)

The comments themselves are templates stored in `mjr-quick-code-comment'.  These templates can inquiarperate several macros that are are expanded: WHO, DATE,
TIME, TAG, & CONTEXT.  With a prefix argument, TIME and DATE are queried from the user.  Otherwise the sytem time/date in ISO 8601 format are used.  CONTEXT
is guessed from the source code (name of function or buffer).  The value of WHO is `mjr-quick-code-comment-who' if it is non-NIL and the user login name
otherwise.  If any any macro value is missing or an empty string, then it (and the space immediately proceeding it) are removed from the comment.

For interactive use:
  - The comment type is queried from the user
  - The date will be
    - Negative prefix argument: the empty string
    - Non-negative prefix argument: queried from the user
    - No prefix argument: current time in ISO 8601 format."
  (interactive)
  (let* ((line-mode     (not (region-active-p)))
         (region-start  (if line-mode (point) (region-beginning)))
         (region-end    (if line-mode (point) (region-end)))
         (com-type      (if line-mode
                            (if (and (boundp 'ido-everywhere) ido-everywhere)
                                (ido-completing-read "Line Mode Comment Type: " (mapcar #'car (cl-remove-if #'cddr mjr-quick-code-comment-types)))
                                (completing-read     "Line Mode Comment Type: " (mapcar #'car (cl-remove-if #'cddr mjr-quick-code-comment-types))))
                            (if (and (boundp 'ido-everywhere) ido-everywhere)
                                (ido-completing-read "Block Mode Comment Type: " (mapcar #'car (cl-remove-if-not #'cddr mjr-quick-code-comment-types)))
                                (completing-read     "Block Mode Comment Type: " (mapcar #'car (cl-remove-if-not #'cddr mjr-quick-code-comment-types))))))
         (macros        (cdr (cl-find-if (lambda (x) (and (= (if line-mode 1 2) (length (cdr x))) (string-equal com-type (car x)))) mjr-quick-code-comment-types)))
         (macro-comb    (apply #'concat macros))
         (com-start     (if (boundp 'comment-start) (symbol-value 'comment-start) ""))
         (com-end       (if (boundp 'comment-end)   (symbol-value 'comment-end)   ""))
         (report-time   (current-time))
         (macro-gets    '(("TIME"    . (lambda () (if current-prefix-arg
                                                      (read-string "Time String: " (format-time-string "%FT%T%z" report-time))
                                                      (format-time-string "%FT%T%z" report-time))))
                          ("DATE"    . (lambda () (if current-prefix-arg
                                                      (read-string "Date String: " (format-time-string "%F" report-time))
                                                      (format-time-string "%F" report-time))))
                          ("WHO"     . (lambda () (or mjr-quick-code-comment-who
                                                      (user-real-login-name))))
                          ("TAG"     . (lambda () (cl-loop for tmp = (read-string "Tag String (non-empty & alphanumeric): ")
                                                           finally (return tmp)
                                                           until (string-match-p "^[A-Za-z0-9_-]+$" tmp))))
                          ("CONTEXT" . (lambda () (or (cl-case major-mode
                                                        (org-mode (condition-case nil
                                                                      (nth 4 (org-heading-components))
                                                                    (error nil)))
                                                        (otherwise (let ((tmp (add-log-current-defun)))
                                                                     (when (cl-notany (lambda (x) (string-equal tmp x))
                                                                                      '("BOOST_AUTO_TEST_CASE" "TEST")) ;; List of bad defuns
                                                                       tmp))))
                                                      (when (buffer-file-name)
                                                        (file-name-nondirectory (buffer-file-name)))
                                                      (buffer-name))))))
         (macro-vals   (mapcar (lambda (mg) (let ((mt (car mg))
                                                  (mc (cdr mg)))
                                              (cons mt (or (when (string-match-p mt macro-comb)
                                                             (funcall mc))
                                                           ""))))
                               macro-gets))
         (macro-str    (mapcar (lambda (str) (let ((tmp str))
                                               (dolist (mv macro-vals)
                                                 (let ((mt (car mv))
                                                       (ms (cdr mv)))
                                                   (setq tmp (if (string-empty-p ms)
                                                                 (replace-regexp-in-string (concat " ?<?*" mt ">?*") "" tmp)
                                                                 (string-replace mt ms tmp)))))
                                               tmp))
                               macros)))
    (when (string-equal com-start ";")
      (setq com-start ";;"))
    (setq com-start (concat (string-trim-right com-start) " "))
    (if line-mode
        (progn
          (end-of-line)
          (insert (concat "\n" com-start (car macro-str) com-end))
          (backward-char (length com-end)))
        (progn
          (goto-char region-end)
          (end-of-line)
          (insert (concat "\n" com-start (nth 1 macro-str) com-end))
          (goto-char region-start)
          (beginning-of-line)
          (insert (concat com-start (car macro-str) com-end "\n"))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun mjr-fix-c-includes-der ()
  "Fixes C/C++ #include lines to match my standard header format.

In `dired-mode' operate on marked (or current) file(s); otherwise operate on current buffer.  If any of
the marked files are already loaded in a buffer it is best to save them first -- so you can do an
`ediff-current-file' to see what changed.

The standard header format is defined by a header DB stored `mjr-fix-c-includes-der-db'.
An example of such a file: https://github.com/richmit/codeBits/blob/main/cheaderSTD.txt"
  (interactive)
  ;; Validate mjr-fix-c-includes-der-db
  (unless (stringp mjr-fix-c-includes-der-db)
    (error "mjr-fix-c-includes-der: Value for mjr-fix-c-includes-der-db is not a string!"))
  (unless (file-exists-p mjr-fix-c-includes-der-db)
    (error "mjr-fix-c-includes-der: No file found in mjr-fix-c-includes-der-db: %s" mjr-fix-c-includes-der-db))
  ;; Try to fix things
  (let ((case-fold-search   nil)
        (include-line-regex "^\\s-*#[iI][nN][cC][lL][uU][dD][eE]\\s-*\\([<\"]\\)\\([^>\"]+\\)\\([>\"]\\).*$")
        (golden-includes    nil)
        (change-count       0))
    ;; Read golden include data
    (with-temp-buffer (insert-file-contents mjr-fix-c-includes-der-db)
                      (goto-char (point-min))
                      (while (re-search-forward include-line-regex nil t)
                        (let ((golden-include-line (match-string 0))
                              (golden-include-name (match-string 2)))
                          (push (cons golden-include-name golden-include-line) golden-includes))))
    ;; Process buffer(s)
    (mjr-apply-dired-magic (lambda ()
                                  (save-excursion
                                    (message "mjr-fix-c-includes-der: Processing buffer: %s" (buffer-name))
                                    (goto-char (point-min))
                                    (while (re-search-forward include-line-regex nil t)
                                      (let ((include-line        (match-string 0))
                                            (include-delim-start (match-string 1))
                                            (include-name        (match-string 2))
                                            (include-delim-end   (match-string 3)))
                                        (when (or (and (string-equal include-delim-start "<")  (string-equal include-delim-end ">"))
                                                  (and (string-equal include-delim-start "\"") (string-equal include-delim-end "\"")))
                                          (let ((golden-line (cdr (assoc include-name golden-includes))))
                                            (when (and golden-line (not (string-equal golden-line include-line)))
                                              (replace-match golden-line nil nil)
                                              (cl-incf change-count)))))))))
    (message "mjr-fix-c-includes-der: Fixed %d include lines" change-count)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun mjr-github-url ()
  "Return github URL.
If the CWD is part of a github repo with a remote origin, then the repo URL is returned.  Otherwise return URL to my github my profile page."
  (if-let* ((git-cfg (shell-command-to-string "git config --get remote.origin.url"))
            (        (string-match "github.com" git-cfg)))
      (string-remove-suffix ".git" (replace-regexp-in-string "^git@github.com:" "https://github.com/" (string-trim git-cfg)))
    mjr-github-url-default))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun mjr-add-header-der (&optional file-type license-file)
  "Prepend the buffer with an appropriate header (including a copyright/license) and, if the buffer is empty, a template.

Some text in the templates gets expanded:
    - YYYY-MM-DD
    - YYYY
    - FILENAME
    - FILENAME-EXT
    - FILENAME-EXT-UC
    - FILEPATHNAME
    - GIT-EMAIL
    - GIT-NAME
    - LEGAL-NAME
    - LOGIN-NAME
    - LICENSE

If run in dired-mode, then marked files will be loaded and operated on.

If run with a prefix argument, then FILE-TYPE and LICENSE-FILE are queried from the user.  Otherwise FILE-TYPE is automatically guessed, and the license is
default.txt.  The FILE-TYPE guess is based on the full filename, the file extension, and the buffer mode -- in that order.  If the FILE-TYPE can't be
determined, then an error is produced.  If the LICENSE-FILE is non-existent, then the LICENSE will be left unexpanded in the template.  Note the content of
the license file is wrapped to the fill-column set in the Emacs local variables section of the template header!

Template & License Files:
 - Header templates are in `mjr-add-header-der-templates' and named top.*
 - Full file templates are in `mjr-add-header-der-templates' and named template.*
 - License files are in in `mjr-add-header-der-licenses'"
  (interactive
   (if current-prefix-arg
       (let* ((file-type-v (append '("AUTO")
                                   (mapcar #'file-name-extension (file-expand-wildcards (file-name-concat mjr-add-header-der-templates "top.*")))))
              (da-type     (if (and (boundp 'ido-everywhere) ido-everywhere)
                               (ido-completing-read "Type: " file-type-v nil 't nil nil "AUTO")
                               (completing-read     "Type: " file-type-v nil 't nil nil "AUTO")))
              (da-lic      (read-file-name "Select License File:" mjr-add-header-der-licenses nil nil "default.txt")))
         (list da-type da-lic))
       (list "AUTO" (file-name-concat mjr-add-header-der-licenses "default.txt"))))
  (cl-flet ((nix-hws (str) (replace-regexp-in-string "[\n\r]+"                ""  str))                               ;; Delete horizontal whitespace
            (sqz-ws  (str) (replace-regexp-in-string "[[[:space:]\n\r]\n\r]+" " " str)))                              ;; Squeeze all whitespace
    (mjr-apply-dired-magic
     (lambda ()
       (when-let* ((da-filename   (buffer-file-name))
                   (file-type     (if (or (not (stringp file-type)) (string= file-type "AUTO")  (string= file-type ""))
                                      (or (if da-filename (cdr (cl-find-if (lambda (re) (string-match (car re) da-filename)) ;; filename pattern
                                                                           '(("^Doxyfile$"     . "doxyfile")))))
                                          (if da-filename (cl-find (file-name-extension da-filename)                         ;; filename extention
                                                                   (mapcar #'file-name-extension
                                                                           (file-expand-wildcards (file-name-concat mjr-dir-core
                                                                                                                    "codeBits/templates/top.*")))
                                                                   :test #'string-equal))
                                          (cdr (assoc major-mode mjr-add-header-der-mode-to-ext)))                          ;; major-mode
                                      file-type))                                                                           ;; the value of file-type
                   (top-file-name (concat (file-name-concat mjr-add-header-der-templates "top.")      file-type))
                   (tpl-file-name (concat (file-name-concat mjr-add-header-der-templates "template.") file-type))
                   (all-string    (concat (if (and (file-exists-p top-file-name)
                                                   (file-readable-p top-file-name))
                                              (with-temp-buffer
                                                (insert-file-contents top-file-name)
                                                (buffer-string))
                                              "")
                                          (if (and (= (point-min) (point-max))
                                                   (file-exists-p tpl-file-name)
                                                   (file-readable-p tpl-file-name))
                                              (with-temp-buffer
                                                (insert-file-contents tpl-file-name)
                                                (buffer-string))
                                              "")))
                   (              (not (string-empty-p all-string))))
         (when (file-exists-p license-file)                                                                ;; Fill in copyright block
           (let ((case-fold-search nil)
                 (lic-re           "\\(^.*\\)LICENSE[\n\r]+"))
             (when (string-match lic-re all-string)
               (let* ((cw-prefix (match-string 1 all-string))
                      (fil-wid (if (string-match "fill-column:\\([0-9]+\\)" all-string)
                                   (- (string-to-number (match-string 1 all-string)) (length cw-prefix) 2)
                                   65))
                      (lic-dat (with-temp-buffer
                                 (insert-file-contents license-file)
                                 (goto-char (point-min))
                                 (set-mark (point-max))
                                 (set-fill-column fil-wid)
                                 (fill-paragraph nil 't)
                                 (goto-char (point-max))
                                 (delete-blank-lines)
                                 (goto-char (point-min))
                                 (while (re-search-forward "^" nil t)
                                   (replace-match cw-prefix))
                                 (goto-char (point-max))
                                 (move-beginning-of-line 1)
                                 (delete-line)
                                 (buffer-string))))
                 (setq all-string (replace-regexp-in-string lic-re lic-dat all-string 't))))))
         (dolist (cur-rpl (list (cons "YYYY-MM-DD"      (lambda () (mjr-date "%Y-%m-%d")))           ;; Replace macros
                                (cons "YYYY"            (lambda () (mjr-date "%Y")))
                                (cons "FILENAME-EXT-UC" (lambda () (if da-filename (upcase (file-name-sans-extension (file-name-nondirectory da-filename))))))
                                (cons "FILENAME-EXT"    (lambda () (if da-filename (file-name-sans-extension (file-name-nondirectory da-filename)))))
                                (cons "FILENAME"        (lambda () (if da-filename (file-name-nondirectory da-filename))))
                                (cons "FILEPATHNAME"    (lambda () da-filename))
                                (cons "GIT-EMAIL"       (lambda () (or mjr-add-header-der-git-email
                                                                       (let ((git-ret (sqz-ws (nix-hws (shell-command-to-string "git config --get user.email")))))
                                                                         (and (stringp git-ret) (not (string-equal "" git-ret)) git-ret)))))
                                (cons "GIT-REMOTE"      (lambda () (string-trim (shell-command-to-string "git config --get remote.origin.url"))))
                                (cons "GITHUBURL"       (lambda () (mjr-github-url)))
                                (cons "LOGIN-NAME"      (lambda () (or mjr-add-header-der-login-name
                                                                       (user-real-login-name))))
                                (cons "LEGAL-NAME"      (lambda () mjr-add-header-der-legal-name))
                                (cons "GIT-NAME"        (lambda () (let ((git-ret (nix-hws (shell-command-to-string "git config --get user.name"))))
                                                                     (and (stringp git-ret) (not (string-equal "" git-ret)) git-ret))))))
           (when (string-match (car cur-rpl) all-string)
             (when-let* ((replace-value (funcall (cdr cur-rpl))))
               (setq all-string (replace-regexp-in-string (car cur-rpl) replace-value all-string 't 't)))))
         (goto-char (point-min))
         (insert all-string))))))

(provide 'mjr-code-tools)

;;; mjr-code-tools.el ends here
