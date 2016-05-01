;------------------------------------
;; Nick Savage's .emacs file
;; Last Updated:
;; 2016-02-16

;------------------------------------
;;;; Init
;------------------------------------

(if (file-exists-p "~/.emacs.d/post.el")
    (require 'post))
(if (file-exists-p "~/.emacs.d/lua-mode.el")
    (require `lua-mode))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(server-start)

; who needs these?
(menu-bar-mode -1)
(tool-bar-mode -1)
 
(setq evil-want-C-i-jump nil)
(require 'evil)
(evil-mode t)

(line-number-mode t)
(column-number-mode t)
(show-paren-mode t)
(ido-mode t)
(global-visual-line-mode t)

(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(setq default-major-mode 'fundamental-mode) ;;; I like it.
(set-register ?e '(file . "~/.emacs")) ;; C-x r j e opens ~/.emacs
(setq inhibit-startup-message t)
(setq-default kill-read-only-ok t)

; Making emacs less fucking annoying.
(setq backup-directory-alist '(("." . "~/.saves")))
(setq auto-save-default nil)
(fset 'yes-or-no-p 'y-or-n-p)  ;; lol
(setq default-tab-width 8) ;;; Set tab width to 4. Default 2.
(setq c-basic-offset 8)

(setq tetris-score-file "~/.emacs.d/tetris-scores")

(autoload 'hledger-mode "hledger-mode" "A major mode for hledger" t)
(add-to-list 'load-path
	     (expand-file-name "~/.emacs.d/hledger-mode/"))
(add-to-list 'auto-mode-alist '("\\.ledger$" . hledger-mode))

;------------------------------------
;;;; Org-Mode
;------------------------------------

(evil-set-initial-state 'calendar-mode 'emacs)
(setq mark-holidays-in-calendar t)
(setq holiday-bahai-holidays nil)
(setq holiday-hebrew-holidays nil)
(setq holiday-islamic-holidays nil)
;; Canadian holidays
(setq general-holidays
      '((holiday-fixed 1 1 "New Year's Day")
	(holiday-fixed 2 14 "Valentine's Day")
	(holiday-fixed 2 15 "Flag Day")
	(holiday-fixed 3 1 "St. David's Day")
	(holiday-fixed 3 17 "St. Patrick's Day")
	(holiday-fixed 4 1 "April Fools' Day")
	(holiday-float 5 1 3 "Victoria Day")
	(holiday-float 5 0 2 "Mother's Day")
	(holiday-float 6 0 3 "Father's Day")
	(holiday-fixed 7 1 "Canada Day")
	(holiday-float 8 1 1 "Civic Holiday (Colonel By Day)") 
	(holiday-float 9 1 1 "Labour Day")
	(holiday-float 10 1 2 "Thanksgiving")
	(holiday-fixed 10 31 "Halloween")
	(holiday-fixed 11 11 "Remebrance Day")
	(holiday-fixed 12 24 "Christmas Eve")
	(holiday-fixed 12 25 "Christmas Day")
	(holiday-fixed 12 26 "Boxing Day")
	(holiday-fixed 12 31 "New Year's Eve")))

; Org-Mode Settings
(setq org-directory "~/agenda")
(setq diary-file "~/agenda/diary")
(setq org-agenda-include-diary t)
(setq org-return-follows-link t)
(setq org-tags-exclude-from-inheritance '(":project:"))

; Org-Mobile Settings
(setq org-mobile-directory "~/agenda/mobile")
(setq org-mobile-inbox-for-pull (concat org-mobile-directory "/index.org"))

(setq org-agenda-files (quote ("~/agenda/agenda.org"	    
			       "~/agenda/refile.org"
			       "~/agenda/work.org"
			       "~/agenda/school.org")))
(setq org-default-notes-file "~/agenda/refile.org")
(setq org-refile-targets (quote ((nil :maxlevel . 9)(org-agenda-files :maxlevel . 9)
				 )))

(setq org-capture-templates
      (quote (	("t" "todo" entry (file "~/agenda/refile.org")
		 "* TODO %?\n%U\n%a\n")
		("n" "next" entry (file "~/agenda/refile.org")
		 "* NEXT %?\n%U\n%a\n")
		("s" "someday" entry (file "~/agenda/refile.org")
		 "* SOMEDAY %?\n%U\n%a\n")
		("b" "bookmark" entry (file "~/agenda/refile.org")
		 "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n"))))

(setq org-todo-keywords
      '((sequence "TODO" "NEXT" "IN-PROGRESS" "|" "DONE")
	(sequence "WAITING" "TODO" "NEXT" "IN-PROGRESS" "|" "DONE")
	(sequence "SOMEDAY" "NEXT" "IN-PROGRESS" "|" "DONE")
	(sequence "HOLD" "NEXT" "IN-PROGRESS" "|" "DONE")))

(setq org-todo-keyword-faces
      (quote (("TODO" . org-warning)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("IN-PROGRESS" :foreground "red" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("HOLD" :foreground "magenta" :weight bold)
	      ("WAITING" :foreground "yellow" :weight bold)
	      ("SOMEDAY" :foreground "orange" :weight bold))))

; agenda views

(setq org-agenda-custom-commands
      (quote (("a" "Notes"
	       ((agenda "" ((org-agenda-ndays 1)))
		(todo "IN-PROGRESS")
		(todo "NEXT")
		(todo "WAITING")
		(todo "TODO")))
	      ("p" "Projects" tags "+project+LEVEL=2")
	      )
	     ))

(add-to-list 'load-path "~/.emacs.d/org-caldav")
(require 'org-caldav)

(setq org-caldav-url "https://nicksavage.ca/owncloud/remote.php/caldav/calendars/nick")

(setq org-caldav-calendars
      '((:calendar-id "school" :files ("~/agenda/school.org")
		      :inbox "~/agenda/fromschool.org")
	(:calendar-id "work" :files ("~/agenda/work.org")
		      :inbox "~/agenda/fromwork.org")
	(:calendar-id "personal" :files ("~/agenda/agenda.org")
		      :inbox "~/agenda/frompersonal.org")
		       ))


;------------------------------------
;;;; Global Functions
;------------------------------------

; diary-schedule lets you add entries from one date to another, on a set day
; basically for school
(defun diary-schedule (m1 d1 y1 m2 d2 y2 dayname)
         "Entry applies if date is between dates on DAYNAME.  
    Order of the parameters is M1, D1, Y1, M2, D2, Y2 if
    `european-calendar-style' is nil, and D1, M1, Y1, D2, M2, Y2 if
    `european-calendar-style' is t. Entry does not apply on a history."
	 (let ((date1 (calendar-absolute-from-gregorian
		       (if european-calendar-style
			   (list d1 m1 y1)
			 (list m1 d1 y1))))
	       (date2 (calendar-absolute-from-gregorian
		       (if european-calendar-style
			   (list d2 m2 y2)
			 (list m2 d2 y2))))
	       (d (calendar-absolute-from-gregorian date)))
	   (if (and
		(<= date1 d)
		(<= d date2)
		(= (calendar-day-of-week date) dayname)
		(not (check-calendar-holidays date))
		)
	                    entry)))

(defun word-count ()
  "Counts the number of words in buffer." 
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun reload ()
  "Reload .emacs interactively"
  (interactive)
  (if (file-exists-p "~/.emacs")
    (load "~/.emacs")))

; Based heavily on EmacsWiki code.
(defun insert-date ()
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive)
    (insert (format-time-string "%Y-%m-%d")))

; brettatoms
(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))

(defun insert-braces ()
  "Insert braces, yo"
  (interactive)
  (insert "{")
  (insert "}")
  (backward-char)
)

(defun c-insert-printf ()
  (interactive)
  (insert "printf(\"\");")
  (backward-char)
  (backward-char)
  (backward-char)
)


;---------------------------------
;;;; Key Bindings
;---------------------------------

(global-set-key (kbd "<f5>") 'undo)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c C-k") 'copy-line)

(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-q") 'query-replace-regexp)
(global-set-key (kbd "C-c C-w") 'toggle-word-wrap)
(global-set-key (kbd "M-c") 'calendar)


(global-set-key (kbd "C-l") 'capitalize-word)
(global-set-key (kbd "C-x /") 'point-to-register)
(global-set-key (kbd "C-x j") 'register-to-point)
(global-set-key (kbd "C-o") 'repeat)

(global-set-key (kbd "C-t") 'transpose-words)
(global-set-key (kbd "M-SPC") 'set-mark-command)

; org-mode keybindings
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c /") 'org-sparse-tree)
(global-set-key (kbd "C-RET") 'org-insert-heading)
(global-set-key (kbd "C-c c") 'org-capture)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-stuck-projects
   (quote
    ("+project+LEVEL=2/-DONE"
     ("TODO" "NEXT" "IN-PROGRESS")
     nil "")))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 587))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
