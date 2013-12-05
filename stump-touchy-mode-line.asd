;;;; stump-touchy-mode-line.asd

(asdf:defsystem #:stump-touchy-mode-line
  :serial t
  :description "Easily make areas of modeline behave like buttons"
  :author "Alexandr Popolitov <popolit@gmail.com>"
  :license "GPL"
  :depends-on (#:stumpwm #:iterate #:defmacro-enhance)
  :components ((:file "package")
               (:file "stump-touchy-mode-line")))

