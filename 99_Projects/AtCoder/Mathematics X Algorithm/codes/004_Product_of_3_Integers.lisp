(let ((product 1))
       (loop with n = 3 repeat n for a = (read)
             do (setf product (* product a))
             finally (format t "~A~%" product)))

(loop for i
    from 0
    for day
    in '(monday tuesday wednesday thursday friday saturday sunday)
    collect (cons i day))
