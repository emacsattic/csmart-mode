;;; csmart-utils.el --- csmart utility functions

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

(defvar csmart-debug-enabled nil
  "If non-nil, csmart will log debug messages.")

(defun csmart--debug (format-string &rest args)
  "Display message if debugging is enabled.

Apply `message` with FORMAT-STRING and ARGS if
`csmart-debug-enabled` is non nil."
  (when csmart-debug-enabled
    (apply 'message format-string args)))

(provide 'csmart-utils)

;;; csmart-utils ends here
