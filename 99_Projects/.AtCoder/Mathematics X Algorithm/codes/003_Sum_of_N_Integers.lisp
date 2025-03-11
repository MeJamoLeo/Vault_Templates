(let ((n (read)))
  (loop with ans = 0
        repeat n
        for a = (read)
        do (incf ans a)
        finally (format t "~A~%" ans)))
