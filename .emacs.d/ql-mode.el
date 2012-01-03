;; QL Syntax
(require 'generic-x) ;; we need this

;; Generate keywords from ebnf: 
;; cat ql.ebnf | perl -pe 's/.*\"(.*)\".*/\1/' | grep [A-Z] | xargs
(define-generic-mode 
  'ql-mode                         ;; name of the mode to create
  '("#")                           ;; comments start with '#'
  '("LESSON" "TITLE" "PURPOSE" "GOALS" "KEYWORDS" "OVERVIEW" ;; Keywords
		"DATA" "THEORY" "IMAGE" "AUDIO" "DISK" "TEXT" "QUESTION"
		"TYPE" "JSEMU" "TEXT" "ANSWER" "CORRECT" "EXPLANATION" "ACHIEVED")
  '(("" . 'font-lock-operator)     ;; '=' is an operator
    ("OPEN" | "MC" | "JSEMU" . 'font-lock-builtin))     ;; ';' is a a built-in 
  '("\\.ql$")                      ;; files for which to activate this mode 
   nil                              ;; other functions to call
  "A mode for QL-files"            ;; doc string for this mode
)
