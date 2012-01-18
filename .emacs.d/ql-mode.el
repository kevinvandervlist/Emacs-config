;; QL Syntax
(require 'generic-x) ;; we need this

;; Generate keywords from ebnf: 
;; cat ql.ebnf | perl -pe 's/.*\"(.*)\".*/\1/' | grep [A-Z] | xargs
(define-generic-mode 
  'ql-mode                         ;; name of the mode to create
  '("#")                           ;; comments start with '#'
	'("LESSON" "TITLE" "PURPOSE" "GOALS" "KEYWORDS" "DATA" "PARTS" 
		"TEXT" "IMAGE" "AUDIO" "OVERVIEW" "ACHIEVED" "QUESTION" "TYPE" 
		"ANSWER" "CORRECT" "EXPLANATION" "THEORY" "DISK" "SHELL" "TCMD"
		"TUSER" "TSEP" "THOST" "TPATH" "TPROMPT" "TCOMMAND" "TRESULT" "TLINE"
		)
  '(("" . 'font-lock-operator)     ;; '=' is an operator
    ("OPEN" | "MC" | "JSEMU" . 'font-lock-builtin))     ;; ';' is a a built-in 
  '("\\.ql$")                      ;; files for which to activate this mode 
	nil
  "A mode for QL-files"            ;; doc string for this mode
)

;; Indent settings
(defun ql-indent-setup()
	(setq indent-tabs-mode nil))

;: Hook the indent in the mode
(add-hook 'ql-mode-hook 'ql-indent-setup)
