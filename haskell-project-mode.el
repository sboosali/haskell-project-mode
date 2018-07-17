;;; -*- lexical-binding: t -*-
;;; haskell-project-mode.el --- Major-mode for Haskell development.

;; Copyright (c) 2018 Spiros Boosalis

;; Author:     Spiros Boosalis <samboosalis@gmail.com>
;; Maintainer: Spiros Boosalis <samboosalis@gmail.com>
;; URL:        https://github.com/sboosali/haskell-project-mode
;; Created:    August 2018
;; Keywords:   haskell, tools
;; Package-Requires: ((dash "2.12.0") (emacs "25.1") (f "0.19.0") (haskell-mode "13.14") (s "1.11.0"))
;; Version: 0.0

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Imports

(require 'cl-lib)
(require 'dash)
(require 'f)
(require 's)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuration

(defgroup haskell-project nil
  "Interactive development mode for Haskell"
  :group 'haskell)

(defcustom haskell-project-debug nil
  "Show debug output."
  :group 'haskell-project
  :type '(set (const inputs) (const outputs) (const responses) (const command-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode

(defvar haskell-project-mode-map (make-sparse-keymap) "Haskell-Project minor mode's map.")

(defun haskell-project-status ()
  "Return haskell-project's status for the current source buffer."
  (let ((buf (haskell-project-buffer-p)))
    (if (not buf) "stopped"
      (with-current-buffer buf
        (s-join ":"
           (-non-nil
            (list (format "%s" haskell-project-state)
                  (when lcr-process-callback (format "busy(%s)" (1+ (length haskell-project-queue)))))))))))

;;;###autoload
(define-minor-mode haskell-project-mode
  "Minor mode for Haskell-Project.

`haskell-project-mode' takes one optional (prefix) argument.
Interactively with no prefix argument, it toggles haskell-project.
A prefix argument enables haskell-project if the argument is positive,
and disables it otherwise.

When called from Lisp, the `haskell-project-mode' toggles haskell-project if the
argument is `toggle', disables haskell-project if the argument is a
non-positive integer, and enables haskell-project otherwise (including
if the argument is omitted or nil or a positive integer).

\\{haskell-project-mode-map}"
  :lighter (:eval (concat " Danté:" (haskell-project-status)))
  :keymap haskell-project-mode-map
  :group haskell-project
  (if haskell-project-mode
      (progn (flycheck-select-checker 'haskell-haskell-project))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'haskell-project)

;;; haskell-project.el ends here
