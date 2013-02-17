;;; csmart-mode.el --- C# minor mode for .Net/Mono context

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

(require 'csmart-proj)

(defvar csmart-buffer-project nil)
(make-variable-buffer-local 'csmart-buffer-project)

(defvar csmart-buffer-solution nil)
(make-variable-buffer-local 'csmart-buffer-solution)

;;;###autoload
(define-minor-mode csmart-mode
  "Minor mode for .Net/Mono project context in C# files"
  :init-value nil
  (cond
   (csmart-mode
    (when (buffer-file-name)
      (setq csmart-buffer-project (csmart-find-buffer-csproj)
            csmart-buffer-solution (csmart-find-buffer-sln))))
   (t
    (setq csmart-buffer-project nil
          csmart-buffer-solution nil))))

(provide 'csmart-mode)

;;; csmart-mode.el ends here
