; Allow max of 9 of each coin
(defun change (quan &optional (coins '(25 10 5  1)) &aux result)
       (cond ((zerop quan) (list nil))
	     ((null coins) t)
	     ((> (first coins) quan) (change quan (rest coins)))
	     (t (dotimes (i (1+ (min 9 (/ quan (first coins)))))
			 (let ((res (change (- quan (* i (first coins)))
					    (rest coins))))
			      (when (listp res)
				  (if (zerop i) 
				      (setq result (append res result))
				      (setq result (append (mapcar #'(lambda (x) (cons (list i (car coins)) x))
								   res)
							   result))))))
		(if (null result) t result))))
