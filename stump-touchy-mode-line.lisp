;;;; stump-touchy-mode-line.lisp

(in-package #:stump-touchy-mode-line)

(defvar *space-between-buttons* 10 "Inactive space between buttons, in lengths of a button")
(defvar *min-button-length* nil "Minimum length of a button, in pixels")

(defun button-boundaries (button-length number)
  (let ((button-start (* number button-length (+ 1 *space-between-buttons*))))
    (list button-start (+ (floor button-start) (ceiling button-length)))))

(defmacro! set-touchy-mode-line (&rest specs)
  (let* ((num (length specs))
	 (button-length (/ (stumpwm::screen-width (stumpwm::current-screen))
			   (+ num (* (1- num) *space-between-buttons*)))))
    (if (< button-length *min-button-length*)
	(error "Length of a button is smaller, than specified minimum")
	(iter (for spec in specs)
	      (for i from 0)
	      (when spec
		(destructuring-bind (left right) (button-boundaries button-length i)
		  (collect `((and (<= ,left x) (<= x ,right))
			     (,spec))
		    into res)))
	      (finally (return `(progn (defun ,g!-touchy-mode-line-hook (mode-line button x y)
					 (declare (ignorable mode-line button x y))
					 ;; (message "Click on mode-line: ~a ~a" x y)
					 (cond ,@res))
				       (stumpwm:add-hook stumpwm:*mode-line-click-hook*
							 ',g!-touchy-mode-line-hook))))))))

(export '(set-touchy-mode-line *space-between-buttons* *min-button-length*))

;;; "stump-touchy-mode-line" goes here. Hacks and glory await!

(in-package #:stumpwm)

(use-package '(#:stump-touchy-mode-line))
	
    
