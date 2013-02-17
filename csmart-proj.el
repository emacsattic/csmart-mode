;;; csmart-proj.el --- Locate .Net/Mono project for source file

;;; Copyright (c) 2013 Krzysztof Witkowski <krzysztof.witkowski@gmail.com>
;;
;; Author: Krzysztof Witkowski <krzysztof.witkowski@gmail.com>
;; URL: http://github.com/kwitek/csmart

;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;; Code:

(require 'xml)
(require 'cl)

(require 'csmart-utils)

(defun csmart--find-nodes (node tag &optional attrs)
  "Find ancestor of tree NODE with matching TAG and attributes ATTRS."
  (when (listp node)
    (destructuring-bind (node-tag node-attrs &rest node-children) node
      (if (and (eq tag node-tag)
               (every (lambda (x) (find x node-attrs :key 'car)) attrs))
          (list (cons node-tag node-attrs))
        (mapcan (lambda (x) (csmart--find-nodes x tag attrs)) node-children)))))

(defun csmart--attr-value (node attr)
  (when (listp node)
    (destructuring-bind (node-tag &rest node-attrs) node
      (cdr (find attr node-attrs :key 'car)))))


(defun csmart--csproj-contains-p (proj-filename source-pattern)
  (csmart--debug "csmart--csproj-contains-p %s" proj-filename)
  (let ((xml (car (xml-parse-file proj-filename))))
    (some (lambda (x) (string= source-pattern x))
          (mapcar (lambda (x) (csmart--attr-value x 'Include))
                  (csmart--find-nodes xml 'Compile)))))

(defun csmart--sln-contains-p (solution project)
  (csmart--debug "%s %s" solution project)
  (let ((solution-buffer (find-file solution)))
    (unwind-protect
        (with-current-buffer solution-buffer
          (goto-char (point-min))
          (search-forward project nil t))
      (kill-buffer solution-buffer))))

(defun csmart--find-file-recursively (dir arg pattern predicate)
  (when dir
    (csmart--debug "dir=%s arg=%s" dir arg)
    (or (find-if (lambda (x) (funcall predicate x arg))
                 (directory-files dir t pattern))
        (let* ((parent (file-name-directory (substring dir 0 -1)))
               (relative (file-name-nondirectory (substring dir 0 -1))))
          (csmart--find-file-recursively parent
                                             (concat relative "\\" arg)
                                             pattern
                                             predicate)))))

(defun csmart--find-file (filename pattern predicate)
  (when filename
    (let* ((truename (file-truename filename))
           (name (file-name-nondirectory truename))
           (dir (file-name-directory truename)))
      (csmart--find-file-recursively dir name pattern predicate))))

(defun csmart-find-csproj (filename)
  "Find .Net/Mono project for a file FILENAME."
  (interactive)
  (let ((csproj (csmart--find-file filename ".csproj$" 'csmart--csproj-contains-p)))
    (when csproj
      (message "Found project %s for %s" csproj filename))
    csproj))

(defun csmart-find-buffer-csproj ()
  "Find .Net/Mono project for current buffer file."
  (interactive)
  (csmart-find-csproj (buffer-file-name)))

(defun csmart-find-sln (filename)
  "Find .Net/Mono solution for a file FILENAME."
  (interactive)
  (let* ((csproj (csmart-find-csproj filename))
         (sln (csmart--find-file csproj ".sln$" 'csmart--sln-contains-p)))
    (when sln
      (message "Found solution %s %s" sln filename))
    sln))

(defun csmart-find-buffer-sln ()
  "Find .Net/Mono solution for current buffer file."
  (interactive)
  (csmart-find-sln (buffer-file-name)))

(provide 'csmart-proj)

;;; csmart-proj ends here
