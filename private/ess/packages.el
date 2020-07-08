;;; packages.el --- ESS (R) Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq ess-packages
  '(
    ess
    ess-R-data-view
    ess-smart-equals
    golden-ratio
    org))

(defun ess/init-ess ()
  (use-package ess-site
    :mode (("\\.sp\\'"           . S-mode)
           ("/R/.*\\.q\\'"       . R-mode)
           ("\\.[qsS]\\'"        . S-mode)
           ("\\.ssc\\'"          . S-mode)
           ("\\.SSC\\'"          . S-mode)
           ("\\.[rR]\\'"         . R-mode)
           ("\\.[rR]nw\\'"       . Rnw-mode)
           ("\\.[sS]nw\\'"       . Snw-mode)
           ("\\.[rR]profile\\'"  . R-mode)
           ("NAMESPACE\\'"       . R-mode)
           ("CITATION\\'"        . R-mode)
           ("\\.omg\\'"          . omegahat-mode)
           ("\\.hat\\'"          . omegahat-mode)
           ("\\.lsp\\'"          . XLS-mode)
           ("\\.do\\'"           . STA-mode)
           ("\\.ado\\'"          . STA-mode)
           ("\\.[Ss][Aa][Ss]\\'" . SAS-mode)
           ("\\.jl\\'"           . ess-julia-mode)
           ("\\.[Ss]t\\'"        . S-transcript-mode)
           ("\\.Sout"            . S-transcript-mode)
           ("\\.[Rr]out"         . R-transcript-mode)
           ("\\.Rd\\'"           . Rd-mode)
           ("\\.[Bb][Uu][Gg]\\'" . ess-bugs-mode)
           ("\\.[Bb][Oo][Gg]\\'" . ess-bugs-mode)
           ("\\.[Bb][Mm][Dd]\\'" . ess-bugs-mode)
           ("\\.[Jj][Aa][Gg]\\'" . ess-jags-mode)
           ("\\.[Jj][Oo][Gg]\\'" . ess-jags-mode)
           ("\\.[Jj][Mm][Dd]\\'" . ess-jags-mode))
    :commands (R stata julia SAS)
    :init
    (progn
      (spacemacs/register-repl 'ess-site 'julia)
      (spacemacs/register-repl 'ess-site 'R)
      (spacemacs/register-repl 'ess-site 'SAS)
      (spacemacs/register-repl 'ess-site 'stata)
      ;; Explicitly run prog-mode hooks since ess-mode does not derive from
      ;; prog-mode major-mode
      (add-hook 'ess-mode-hook 'spacemacs/run-prog-mode-hooks)
      (when (configuration-layer/package-usedp 'company)
          (add-hook 'ess-mode-hook 'company-mode))))

  ;; R --------------------------------------------------------------------------
  (setq spacemacs/ess-config
    '(progn
    ;; Follow Hadley Wickham's R style guide
    (setq ess-first-continued-statement-offset 2
          ess-continued-statement-offset 0
          ess-expression-offset 2
          ess-nuke-trailing-whitespace-p t
          ess-default-style 'DEFAULT)

    (defun spacemacs/ess-start-repl ()
      "Start a REPL corresponding to the ess-language of the current buffer."
      (interactive)
      (cond
       ((string= "S" ess-language) (call-interactively 'R))
       ((string= "STA" ess-language) (call-interactively 'stata))
       ((string= "SAS" ess-language) (call-interactively 'SAS))))

    (spacemacs/declare-prefix-for-mode 'ess-r-mode "md" "package dev")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "mh" "help")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "mv" "view data")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "ms" "session (REPL)")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "mc" "code")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "mg" "graphics")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "mr" "rmarkdown")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "mS" "shiny")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "mm" "make (drake)")
    (spacemacs/declare-prefix-for-mode 'ess-r-mode "mf" "function")

    (spacemacs/set-leader-keys-for-major-mode 'ess-julia-mode
      "'"  'julia
      "si" 'julia)
    (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
      "'"  'spacemacs/ess-start-repl
      "si" 'spacemacs/ess-start-repl
      ;; noweb
      "cs" 'tide-save-and-style-file
      ;; REPL
      "sB" 'ess-eval-buffer-and-go
      "sb" 'ess-eval-buffer
      "e" 'ess-eval-paragraph-and-step
      "i" 'ess-interrupt
      "o"  'ess-eval-word
      "R" 'ess-eval-region
      "t" 'tide-thead-at-point
      "sp" 'ess-eval-paragraph-and-step
      "sd" 'ess-eval-region-or-line-and-step
      "sl" 'ess-eval-line
      "sr" 'ess-eval-region
      "st" 'ess-eval-function
      "sw" 'ess-set-working-directory
      ;; R data viewers
      "vs" 'df-sample-small
      "vm" 'df-sample-medium
      "vl" 'df-sample-large
      ;; Package Dev helpers
      "di" 'ess-r-devtools-install-package
      "dt" 'ess-r-devtools-test-package
      "dl" 'ess-r-devtools-load-package
      "dc" 'ess-r-devtools-check-package
      "dd" 'ess-r-devtools-document-package
      "df" 'ess-roxy-update-entry
      "ds" 'tide-devtools-setup
      ;; R help
      "ho" 'ess-display-help-on-object
      "hi" 'ess-display-index
      "ha" 'ess-display-help-apropos
      ;; Graphics devices
      "gn" 'tide-new-gdev
      "gc" 'tide-cur-gdev
      "gs" 'tide-switch-to-gdev
      "gl" 'tide-list-all-gdev
      "gp" 'tide-save-gdev-pdf
      "gc" 'tide-capture-gdev
      "gj" 'tide-switch-next-gdev
      "gk" 'tide-switch-prev-gdev
      ;; R Markdown
      "rc" 'polymode-eval-chunk
      "rr" 'tide-rmd-rend
      "rd" 'tide-draft-rmd
      ;; Shiny
      "Sr" 'tide-shiny-run-app
      ;; Drake
      "mm" 'drake-make
      "mr" 'readd-target-at-point
      "mc" 'drake-clean
      "mp" 'source-packages-file
      ;; Fnmate
      "ff" 'fnmate
      "fb" 'fnmate-internal
      "fe" 'ess-eval-function
      )
    (define-key ess-mode-map (kbd "<s-return>") 'ess-eval-line)
    (define-key inferior-ess-mode-map (kbd "C-j") 'comint-next-input)
    (define-key inferior-ess-mode-map (kbd "C-k") 'comint-previous-input)
    ;; Toggle underscore off no replacement of _ for <-
    (setq ess-smart-S-assign-key nil)
    ;; Stop R repl eval from blocking emacs.
    (setq ess-eval-visibly 'nowait)
    ;; Set fontification
    (setq ess-R-font-lock-keywords
      '((ess-R-fl-keyword:keywords   . t)
        (ess-R-fl-keyword:constants  . t)
        (ess-R-fl-keyword:modifiers  . t)
        (ess-R-fl-keyword:fun-defs   . t)
        (ess-R-fl-keyword:assign-ops . t)
        (ess-R-fl-keyword:%op%       . t)
        (ess-fl-keyword:fun-calls)
        (ess-fl-keyword:numbers)
        (ess-fl-keyword:operators . t)
        (ess-fl-keyword:delimiters)
        (ess-fl-keyword:=)
        (ess-R-fl-keyword:F&T)))
    ;; add directory for windows
    (setq ess-directory-containing-R "c:")
    (setq inferior-R-program-name "c:/R/R-3.6.3/bin/x64/Rterm.exe")
    ;; enable prettify symbols
    (add-hook 'ess-mode-hook 'prettify-symbols-mode)

    ;; =====================================================================
    ;; Tidyverse IDE
    ;; =====================================================================
    (defun tide-insert-pipe ()
      "Insert a %>% and newline"
      (interactive)
      (insert "%>%"))
    (defun tide-insert-assign ()
      "Insert an assignment <-"
      (interactive)
      (insert "<- "))

    (dolist (mode-map (list ess-mode-map inferior-ess-mode-map))
      (define-key mode-map (kbd "C-\"") 'tide-insert-pipe)
      (define-key mode-map (kbd "C-'") 'tide-insert-assign)
      )

    (defun tide-draft-rmd ()
      "Draft a new Rmd file from a template interactively."
      (interactive)
      (setq rmd-file
            (read-from-minibuffer "Rmd Filename (draft_<date>.Rmd): "
                                  nil nil t t
                                  (format "draft_%s.Rmd"
                                          (string-trim
                                           (shell-command-to-string "date --iso-8601")))))
      (setq rmd-template
            (read-from-minibuffer
             (format "Draft %s from template (mmmisc/basic): " rmd-file)
                                               nil nil t t "mmmisc/basic"))
      (symbol-name rmd-template)
      (string-match "\\([^/]+\\)/\\([^/]+\\)"
                    (symbol-name rmd-template))
      (setq template-pkg
            (substring
             (symbol-name rmd-template)
             (match-beginning 1)
             (match-end 1)))
      (setq template-name
            (substring
             (symbol-name rmd-template)
             (match-beginning 2)
             (match-end 2)))
      (message "Drafting using template %s from package %s" template-name template-pkg)
      (ess-eval-linewise
       (format "rmarkdown::draft(file = \"%s\", template = \"%s\",
                package = \"%s\", edit = FALSE)"
               rmd-file template-name template-pkg))
      )
    ;; Graphics device management ;;
    (defun tide-new-gdev ()
      "create a new graphics device"
      (interactive)
      (ess-eval-linewise "dev.new()"))

    (defun tide-cur-gdev ()
      "return current graphics device"
      (interactive)
      (ess-eval-linewise "dev.cur()"))

    (defun tide-list-all-gdev ()
      "list all graphics devices"
      (interactive)
      (ess-eval-linewise "dev.list()"))

    (defun tide-switch-to-gdev ()
      "Prompt for the number of the graphics device to make current"
      (interactive)
      (setq dev-num
            (read-from-minibuffer "Select R graphics device: "
                                  nil nil t t "1"))
      (ess-eval-linewise
       (format "dev.set(%s)" dev-num)))

    (defun tide-switch-next-gdev ()
      "switch to next available graphics device"
      (interactive)
      (ess-eval-linewise "dev.set(dev.next())"))

    (defun tide-switch-prev-gdev ()
      "switch to previous available graphics device"
      (interactive)
      (ess-eval-linewise "dev.set(dev.prev())"))

    (defun tide-save-gdev-pdf ()
      "Save current graphics device as pdf"
      (interactive)
      (ess-eval-linewise "dev.copy2pdf()"))

    (defun tide-capture-gdev ()
      "Capture current graphics device as image"
      (interactive)
      (ess-eval-linewise "dev.capture()"))

    ;; Devtools
    (defun tide-devtools-setup ()
      "setup R package in current working directory"
      (interactive)
      (ess-eval-linewise "devtools::setup()"))

    ;; Shiny
    (defun tide-shiny-run-app ()
      "Run a shiny app in the current working directory"
      (interactive)
      (ess-eval-linewise "shiny::runApp()"))

    ;; Rmarkdowm
    (defun tide-rmd-rend ()
      "Render rmarkdown files with an interactive selection prompt"
      (interactive)
      (ess-eval-linewise "mmmisc::rend()"))

    ;; Data Views
    (defun df-at-point-to-buffer (&optional numrows)
      "output a sample of another data.frame to and jump to buffer."
      (let ((object (symbol-at-point))
            (r-process (ess-get-process))
            (r-output-buffer (get-buffer-create "*R-output*"))
            (numrows (or numrows 300)))
        (ess-command
         (format "mmmisc::df_preview(%s, %s)\n" object numrows)
         r-output-buffer nil nil nil r-process)
        (switch-to-buffer-other-window r-output-buffer)
        ))

    (defun df-sample-small ()
      "Sample and print 30 rows of a data.frame"
      (interactive)
      (df-at-point-to-buffer 30)
      )

    (defun df-sample-medium ()
      "Sample and print 300 rows of a data.frame"
      (interactive)
      (df-at-point-to-buffer 300)
      )

    (defun df-sample-large ()
      "Sample and print 3000 rows of a data.frame"
      (interactive)
      (df-at-point-to-buffer 3000)
      )

    (defun tide-thead-at-point ()
      "call t(head()) on object at point"
      (interactive)
      (let ((df (symbol-at-point)))
        (ess-eval-linewise (format "t(head(%s))\n" df))))

    ;; Styling
    (defun tide-save-and-style-file ()
      "Save the current buffer and style using styler"
      (interactive)
      (save-buffer)
      (let ((filename (buffer-file-name)))
        (ess-eval-linewise
         (format "styler::style_file(\"%s\")" filename))))

    ;;======================================================================
    ;; (R) markdown mode
    ;;======================================================================

    ;; Insert a new (empty) chunk to R markdown ============================
    (defun insert-chunk ()
      "Insert chunk environment Rmd sessions."
      (interactive)
      (insert "```{r}\n\n```")
      (forward-line -1)
      )
    ;; key binding
    (global-set-key (kbd "C-c i") 'insert-chunk)

    ;; Mark a word at a point ==============================================
    ;; http://www.emacswiki.org/emacs/ess-edit.el
    (defun ess-edit-word-at-point ()
      (save-excursion
        (buffer-substring
         (+ (point) (skip-chars-backward "a-zA-Z0-9._"))
         (+ (point) (skip-chars-forward "a-zA-Z0-9._")))))
    ;; eval any word where the cursor is (objects, functions, etc)
    (defun ess-eval-word ()
      (interactive)
      (let ((x (ess-edit-word-at-point)))
        (ess-eval-linewise (concat x)))
      )
    ;; key binding
    (define-key ess-mode-map (kbd "C-c r") 'ess-eval-word)

  ;;======================================================================
  ;; fnmate
  ;;======================================================================
  (defun text-around-cursor (&optional rows-around)
    (let ((rows-around (or rows-around 10))
          (current-line (line-number-at-pos))
          (initial-point (point)))
      (save-mark-and-excursion
        (goto-line (- current-line rows-around))
        (set-mark (point))
        (goto-line (+ current-line rows-around))
        (end-of-line)
        ;; Return a list of text, index
        (list (buffer-substring-no-properties (mark) (point))
              (+ (- initial-point (mark)) 1)))))

  (defun strip-ess-output-junk (r-buffer)
    (with-current-buffer r-buffer
      (goto-char (point-min))
      (while (re-search-forward "\\+\s" nil t)
        (replace-match ""))))

  (defun exec-r-fn-to-buffer (r_fn text)
    (let ((r-process (ess-get-process))
          (r-output-buffer (get-buffer-create "*R-output*")))
      (ess-string-command
       (format "cat(%s(%s))\n" r_fn text)
       r-output-buffer nil)
      (strip-ess-output-junk r-output-buffer)
      (save-mark-and-excursion
        (goto-char (point-max))
        (newline)
        (insert-buffer r-output-buffer))))

  ;; fnmate functions for keybindings
  (defun fnmate ()
    (interactive)
    (let* ((input-context (text-around-cursor))
           (text (prin1-to-string (car input-context)))
           (index (cdr input-context)))
      (ess-eval-linewise (format "fnmate::fnmate_fn.R(%s, %s)" text index))))

  (defun fnmate-internal ()
    (interactive)
    (let* ((input-context (text-around-cursor))
           (text (prin1-to-string (car input-context)))
           (index (cdr input-context))
           (args (format "%s, %s" text index)))
      (exec-r-fn-to-buffer "fnmate::fnmate_internal" args)))

    ;;======================================================================
    ;; Drake
    ;;======================================================================
    (defun drake-make ()
      (interactive)
      (ess-eval-linewise "drake::r_make()"))

    (defun drake-clean ()
      (interactive)
      (ess-eval-linewise "source('./clean.R')"))

    (defun readd-target-at-point ()
      "call drake::readd on object at point to load it into environment."
      (interactive)
      (let ((target (symbol-at-point)))
            (ess-eval-linewise (format "%s <- drake::readd(%s)\n" target target))))

    (defun drake-restart-make ()
      "restart R session then run make.R"
      (interactive)
      (let ((r-buffer (current-buffer))
            (r-repl-buffer (ess-get-process-buffer)))
        (switch-to-buffer-other-window r-repl-buffer)
        (inferior-ess-reload)
        (switch-to-buffer-other-window r-buffer)
        (drake-make)
        ))
    ))

  (defun source-packages-file ()
    "source ./packages.R"
    (interactive)
    (ess-eval-linewise "source('./packages.R')"))

  ;;======================================================================
  ;; Misc
  ;;======================================================================

  ;; Add fix for read-only ESS REPL
  ;; https://github.com/emacs-ess/ESS/issues/300
  (add-hook 'inferior-ess-mode-hook #'(lambda ()
                                        (setq-local comint-use-prompt-regexp nil)
                                        (setq-local inhibit-field-text-motion nil)))

  (eval-after-load "ess-r-mode" spacemacs/ess-config)
  (eval-after-load "ess-julia" spacemacs/ess-config))




(defun ess/init-ess-R-data-view ())

(defun ess/init-ess-smart-equals ()
  (use-package ess-smart-equals
    :defer t
    :if ess-enable-smart-equals
    :init
    (progn
      (add-hook 'ess-mode-hook 'ess-smart-equals-mode)
      (add-hook 'inferior-ess-mode-hook 'ess-smart-equals-mode))))

(defun ess/pre-init-golden-ratio ()
  (spacemacs|use-package-add-hook golden-ratio
    :post-config
    (dolist (f '(ess-eval-buffer-and-go
                 ess-eval-function-and-go
                 ess-eval-line-and-go))
      (add-to-list 'golden-ratio-extra-commands f))))

(defun ess/pre-init-org ()
  (spacemacs|use-package-add-hook org
    :post-config (add-to-list 'org-babel-load-languages '(R . t))))
