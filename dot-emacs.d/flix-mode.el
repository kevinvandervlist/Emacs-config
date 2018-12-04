(setq flix-keywords '("assert" "case" "def" "else" "enum" "if" "in" "index" "lat"
                      "let" "match" "namespace" "print" "rel" "val" "with"))

;; generate regex string for each category of keywords
(setq flix-keywords-regexp (regexp-opt flix-keywords 'words))

;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq flix-font-lock-keywords
      `((,flix-keywords-regexp . font-lock-keyword-face)))

;;;###autoload
(define-derived-mode flix-mode scala-mode "flix mode"
  "Major mode for editing Flix"
  (setq font-lock-defaults '((flix-font-lock-keywords))))

;; clear memory. no longer needed
(setq flix-keywords nil)
;; clear memory. no longer needed
(setq flix-keywords-regexp nil)

(provide 'flix-mode)
