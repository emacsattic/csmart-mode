;;; test-proj.el --- ERT tests for csmart-proj
;;; Commentary:
;;; Code:

(require 'ert)
(require 'csmart-proj)

(defvar test-sln "src/TestSolution.sln")
(defvar test-csproj "src/Test.Project/Test.Project.csproj")

(ert-deftest can-find-compile-nodes ()
  (should
   (let ((csproj (car (xml-parse-file test-csproj))))
     (csmart--find-nodes csproj 'Compile))))

(ert-deftest can-find-csproj ()
  (should
   (string= (file-truename test-csproj)
            (csmart-find-csproj "src/Test.Project/Core/Test.cs"))))

(ert-deftest can-check-sln ()
  (should
   (csmart--sln-contains-p test-sln (file-name-nondirectory test-csproj))))

(ert-deftest can-find-sln ()
  (should
   (string= (file-truename test-sln)
            (csmart-find-sln "src/Test.Project/Core/Test.cs"))))

;;; test-proj.el ends here
