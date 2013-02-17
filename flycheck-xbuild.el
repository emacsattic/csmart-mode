;;; flycheck-xbuild.el --- Flycheck support for .Net/Mono projects

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

(require 'flycheck)
(require 'csmart-proj)

(flycheck-declare-checker xbuild-csproj
  "A .Net project checker using mono xbuild."
  :command '("xbuild" (eval (csmart-find-buffer-csproj)))
  :error-patterns
  '(("^.*?\\(?1:[^/]+\\)(\\(?2:[0-9]+\\)\\(?:,[0-9]+\\)?): error \\(?4:.+\\)$" error))
  :predicate '(csmart-find-buffer-csproj)
  :modes 'csharp-mode)

(provide 'flycheck-xbuild)

;;; flycheck-xbuild.el ends here
