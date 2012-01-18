;; Pad om extra spul te laden. 
(add-to-list 'load-path "~/.emacs.d")

;; Darkroom mode
(require 'darkroom-mode)
(require 'frame-local-vars)
(require 'w32-fullscreen)
;; ido mode
(require 'ido) 
;;Uber killring (browse-kill-ring package)
(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))
;; Color theme base package
(require 'color-theme)
;; Zenburn coloring
(require 'zenburn)
;; PHP-mode from ~/.emacs.d
(require 'php-mode)
;; QL Mode
(load-file "~/.emacs.d/ql-mode.el")
;; Rainbow mode
(require 'rainbow-mode)
;; Programmers dvorak
(load-file "~/.emacs.d/programmer-dvorak.el")
;; org-mode
(require 'org-install)
;; Coffee mode https://github.com/defunkt/coffee-mode
(require 'coffee-mode)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom. Well sde
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
;;Tab completion voor buffer switching. 
(iswitchb-mode t)
;;Ook tab completion in document ipv M-/. Altijd makkelijk. 
;; Tab complete
(global-set-key [(tab)] 'smart-tab)
(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (dabbrev-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\_>")
          (dabbrev-expand nil)
        (indent-for-tab-command)))))

;;Tab completion met ido in minibuffer
(ido-mode t) ; for buffers and files
(setq 
  ido-ignore-buffers ;; ignore onderstaande buffers
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido")
  ido-work-directory-list '("~/")
  ido-everywhere t                 ; Hoe meer hoe beter. 
  ido-case-fold  t                 ; niet hoofdlettergevoelig met completion
  ido-use-filename-at-point nil    ; don't use filename at point (annoying)
  ido-use-url-at-point nil         ;  don't use url at point (annoying)
  ido-enable-flex-matching t       ; be flexible
  ido-max-prospects 4              ; don't spam my minibuffer
  ido-confirm-unique-completion t) ; wait for RET, even with unique completion
  ;; fix voor tab complete hierboven
  (add-hook 'ido-setup-hook    
          (lambda () 
            (define-key ido-completion-map [tab] 'ido-complete)))

;;Indent grootte
(setq standard-indent 4)
;;Huidige regel highlighten. Niet meer ivm zenburn
(global-hl-line-mode 1)
;;Andere kleurtjes
(set-face-background 'hl-line "#353E35")
(set-cursor-color "#353E35")
;;Geen debiele backup files ($name~)
(setq make-backup-files nil)
;;Geen toolbar in windowed mode
(if window-system
	(tool-bar-mode 0))
;;Geen menu bar
(menu-bar-mode -1)
;;Fullscreen wanneer er op F11 gedrukt word. 
(defun fullscreen ()
    (interactive)
    (set-frame-parameter nil 'fullscreen
        (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
            (global-set-key [f11] 'fullscreen)
;; Windows is anders dan Linux.
(if (eq system-type 'windows-nt)
	(global-set-key [f11] 'w32-fullscreen))

;;F9 voor de config file van emacs. 
(global-set-key (kbd "<f9>") 
  (lambda()(interactive)(find-file "~/.emacs")))
;;Parenthesis highlighting
(show-paren-mode)
;;Scrollbar rechts houden. 
(set-scroll-bar-mode 'right)
(setq scroll-margin 3)

(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))

;(load-file "~/.emacs.d/zenburn.el")
(color-theme-zenburn)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Day overview org-mode time tracking. - http://sachachua.com/blog/2007/12/clocking-time-with-emacs-org/
(defun org-dblock-write:rangereport (params)
  "Display day-by-day time reports."
  (let* ((ts (plist-get params :tstart))
         (te (plist-get params :tend))
         (start (time-to-seconds
                 (apply 'encode-time (org-parse-time-string ts))))
         (end (time-to-seconds
               (apply 'encode-time (org-parse-time-string te))))
         day-numbers)
    (setq params (plist-put params :tstart nil))
    (setq params (plist-put params :end nil))
    (while (<= start end)
      (save-excursion
        (insert "\n\n"
                (format-time-string (car org-time-stamp-formats)
                                    (seconds-to-time start))
                "----------------\n")
        (org-dblock-write:clocktable
         (plist-put
          (plist-put
           params
           :tstart
           (format-time-string (car org-time-stamp-formats)
                               (seconds-to-time start)))
          :tend
          (format-time-string (car org-time-stamp-formats)
                              (seconds-to-time end))))
        (setq start (+ 86400 start))))))
;; End daily overview

;; Default ispell taal - NL / EN_GB
(setq ispell-dictionary "nederlands")
;; (setq ispell-dictionary "british")

;; Disable C-z
(global-unset-key "\C-z")

;; Programmers dvorak as default
;;(defadvice switch-to-buffer (after activate-input-method activate)
;;  (activate-input-method "programmer-dvorak"))

;; Buffer resizing:
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; Default tab width. per-buffer: M-x set-variable RET c-basic-offset RET x RET
(setq default-tab-width 2)

;; Ctrl needs to be at tab location
;; Windows: Registry fix. Lame
;; Unix: place below lines in .xmodmap; .xmodmap in ~/.bash_profile
;; remove Lock = Caps_Lock
;; remove Control = Control_L
;; keysym Control_L = Caps_Lock
;; keysym Caps_Lock = Control_L
;; add Lock = Caps_Lock
;; add Control = Control_L

;; And I prefer not to use Alt (SunOS anyone?)
(global-set-key "\C-x\C-b" 'execute-extended-command)
(global-set-key "\C-c\C-b" 'execute-extended-command)

;; M-Backspace/backward-kill-word to C-w. I hardly use kill-region anyway. 
(global-set-key "\C-w" 'backward-kill-word)
;; And kill-region to C-x-C-k
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
;; Disable tab indenting
(setq indent-tabs-mode nil)

;; isearch-forward and isearch-backward are great, but isearch-{forward,backward}-regexp is usefull to.
(global-set-key "\M-s" 'isearch-forward-regexp)
(global-set-key "\M-r" 'isearch-backward-regexp)

;; Enable flyspell mode for certain modes
(dolist (hook '(text-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(LaTeX-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
(setq-default ispell-program-name "aspell")

;; C-x C-b (switch buffer becomes recompile)
(global-set-key "\C-x\C-m" 'recompile)

;; Close the compilation window if there was no error at all.
;; Reopens second buffer with prev
;;(setq compilation-exit-message-function
;;	  (lambda (status code msg)
;;		;; If M-x compile exists with a 0
;;		(when (and (eq status 'exit) (zerop code))
;;		  ;; then bury the *compilation* buffer, so that C-x b doesn't go there
;;		  (bury-buffer "*compilation*")
;;		  ;; and return to whatever were looking at before
;;		  (replace-buffer-in-windows "*compilation*"))
;;		;; Always return the anticipated result of compilation-exit-message-function
;;		(cons msg code)))

;; Helper for compilation. Close the compilation window if
;; there was no error at all.
(defun compilation-exit-autoclose (status code msg)
  ;; If M-x compile exists with a 0
  (when (and (eq status 'exit) (zerop code))
	;; then bury the *compilation* buffer, so that C-x b doesn't go there
	(bury-buffer)
	;; and delete the *compilation* window
	(delete-window (get-buffer-window (get-buffer "*compilation*"))))
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))
;; Specify my function (maybe I should have done a lambda function)
(setq compilation-exit-message-function 'compilation-exit-autoclose)

;; Line numbering
(global-linum-mode 1)
;; And line number formatting:
(setq linum-format "%d ")
