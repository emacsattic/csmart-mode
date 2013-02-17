;;; test-xbuild.el --- Test the xbuild checker
;;; Commentary:
;;; Code:

(require 'ert)
(require 'csharp-mode)
(require 'flycheck-xbuild)

(let* ((flycheck-el (find-lisp-object-file-name 'flycheck-mode 'symbol-function))
       (testhelpers-el (concat (file-name-directory flycheck-el)
                               "tests/testhelpers.el")))
  (message testhelpers-el)
  (load-file testhelpers-el))

(defvar err-cs-0161
  '(7 nil "CS0161: `Test.Project.FlycheckError.CS0161()': not all code paths return a value" error))

(ert-deftest checker-xbuild-csproj-error ()
  "Test a real syntax error with xbuild-csproj."
  :expected-result (flycheck-fail-unless-checker 'xbuild-csproj)
  (with-current-buffer (find-file-noselect (file-truename "src/Test.Project/Core/FlycheckError.cs"))
    (should (csmart-find-buffer-csproj))
    (csharp-mode)
    (flycheck-mode)
    (flycheck-select-checker 'xbuild-csproj)
    (flycheck-wait-for-syntax-checker)
    (flycheck-should-errors err-cs-0161 err-cs-0161)))

(ert-deftest checker-xbuild-csproj-clear ()
  "Test a real syntax error with xbuild-csproj."
  :expected-result (flycheck-fail-unless-checker 'xbuild-csproj)
  (with-current-buffer (find-file-noselect "src/Test.Project/Core/Test.cs")
    (should (csmart-find-buffer-csproj))
    (csharp-mode)
    (flycheck-mode)
    (flycheck-select-checker 'xbuild-csproj)
    (flycheck-wait-for-syntax-checker)
    (flycheck-ensure-clear)))

;;; test-xbuild.el ends here
