;------------------------------------
;; Nick Savage's .emacs file
;; Last Updated:
;; 2018-07-10

;------------------------------------
;;;; Init
;------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

; who needs these?
(menu-bar-mode -1)
(tool-bar-mode -1)
 
(setq evil-want-C-i-jump nil)
(require 'evil)
(evil-mode t)

(require 'deft)
(setq deft-recursive t)

(line-number-mode t)
(column-number-mode t)
(show-paren-mode t)
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

(setq org-caldav-url "https://nextcloud.nicksavage.ca/remote.php/dav/calendars/nick")
(setq org-caldav-inbox "~/agenda/inbox.org")
(setq org-caldav-files '("~/agenda/personal.org" "~/agenda/inbox.org" "~/agenda/work.org"))
(setq org-caldav-calendars
      '((:calendar-id "test" :files ("~/agenda/work.org")
		      :inbox "~/agenda/fromwork.org")
	(:calendar-id "personal" :files ("~/agenda/personal.org")
		      :inbox "~/agenda/frompersonal.org")) )
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

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
;(setq diary-file "~/agenda/diary")
(setq org-agenda-include-diary t)
(setq org-return-follows-link t)
(setq org-tags-exclude-from-inheritance '(":project:"))
;(setq org-todo-keywords
;      '((sequence "TODO" "REVIEWED" "NEXT" "|" "REVIEW" "WAITING" "DONE")))


(setq org-todo-keywords
      '((sequence "REVIEWED" "NEXT" "|" "DONE" "REVIEW" "WAITING")
	(sequence "SOMEDAY" "NEXT" "DONE")
	(sequence "NEXT" "REVIEW" "NEXT" "PDR" "TAX" "TYPING" "DONE")
	(sequence "TODO" "DONE")))

(setq org-todo-keyword-faces
      (quote (("TODO" . org-warning)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("REVIEW" :foreground "forest green" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("TYPING" :foreground "forest green" :weight bold)
	      ("PDR" :foreground "forest green" :weight bold)
	      ("TAX" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "forest green" :weight bold)
	      ("SOMEDAY" :foreground "orange" :weight bold))))

(setq org-agenda-files '( "~/agenda/work.org" "~/agenda/inbox.org" "~/agenda/diary.org" "~/agenda/personal.org" "~/agenda/fromwork.org" "~/agenda/frompersonal.org"))
(setq org-default-notes-file "~/agenda/refile.org")

(evil-set-initial-state 'calendar-mode 'emacs)
(setq org-refile-targets '((nil :maxlevel . 6)
			   (org-agenda-files :maxlevel . 6)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)      

(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/agenda/inbox.org" "Tasks")
	 "* NEXT %?\n  %i\n  %a")
	("l" "Link" entry (file+headline "~/agenda/inbox.org" "Links")
	 "* %?\n %i\n %a")
	("e" "Event" entry (file+headline "~/agenda/inbox.org" "Events")
	 "* %?\n %i\n %a")
	))


;------------------------------------
;;;; Global Functions
;------------------------------------

(defun word-count ()
  "Counts the number of words in buffer." 
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun nsavage-insert-date ()
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive)
    (insert (format-time-string "%Y-%m-%d")))

;---------------------------------
;;;; Key Bindings
;---------------------------------

(global-set-key (kbd "C-c d") 'nsavage-insert-date)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key [f8] 'deft)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c /") 'org-sparse-tree)
(global-set-key (kbd "C-RET") 'org-insert-heading)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c r") 'helm-org-rifle)
(global-set-key (kbd "C-c p") 'org-do-demote)
(global-set-key (kbd "C-c P") 'org-do-promote)
(global-set-key (kbd "C-w") 'backward-kill-word)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/agenda/work.org" "~/agenda/diary.org" "~/agenda/personal.org")))
 '(package-selected-packages
   (quote
    (deft anki-editor org-caldav nov php-mode ess magit lua-mode hledger-mode helm-org-rifle evil-ledger 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
