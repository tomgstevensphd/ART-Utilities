;; ******************************** U-art-math-utilities.lisp **********************
;;
;;MY-FLOOR-CEILING
;;
;;ddd
(defun my-floor-ceiling (number &key floor ceiling)
  "In U-art-math-utilities"
  (let 
      ((return-num number)
       )
    (when floor
      (when (> floor number)
        (setf return-num floor)))
    (when ceiling
      (when (< ceiling number)
        (setf return-num ceiling)))
    return-num
    ))
;;TEST
;;  (my-floor-ceiling 50 :floor 60) = 60
;;  (my-floor-ceiling 50 :ceiling 40) = 40
;;  (my-floor-ceiling 50 :floor 0 :ceiling 100) = 50
;;  (my-floor-ceiling -20 :floor 0 :ceiling 100) = 0
;;  (my-floor-ceiling 200  :floor 0 :ceiling 100) = 100

;;MY-FLOOR
;;
;;ddd
(defun my-floor (number &key (if-above-floor-p T)  (floor 0) )
  "In U-art-math-utilities, returns floor if number is below floor (negative), unless if-above-floor-p, then returns floor if number is above floor (positive)"
  (let
      ((return-num floor)
       )
    (cond
     ;;if if-above-floor-p = T
     (if-above-floor-p
      ;;if number is above floor, return number otherwise return floor
      (if (> number floor)
          (setf return-num number)))
     ;;if. if-above-floor-p = T
     (t 
      ;;if-above-floor-p = NIL
      ;;if number is below floor, return number otherwise return floor
      (if (< number floor)
          (setf return-num number))))
    return-num
    ;;end let, my-zero-floor
    ))
;;TEST
;;  (my-floor 0.2) = 0.2
;;  (my-floor -0.2) = 0
;;  (my-floor 0.2 :if-above-floor-p nil) = 0
;;  (my-floor -0.2 :if-above-floor-p nil)  = -0.2
;;  (my-floor 0.2 :floor 0.1) = 0.2
;;  (my-floor -0.2 :floor 0.1) = 0.1
;;  (my-floor 0.2 :floor  7) = 7

;;MY-LIST-ITEM-FLOOR
;;
;;ddd
(defun my-list-item-floor (list  &key if-above-floor-p  (floor 0) )
  "In U-art-math-utilities, returns 0 if number is negative, unless if-positive-zero-p, then returns 0 if number is positive FOR EACH MEMBER OF A LIST"
  (let
      ((return-list)
       (return-item)
       )
    (loop
     for item in list
     do
     (cond
      ((numberp item)
       (setf return-item (my-floor item :if-above-floor-p if-above-floor-p  :floor floor)))
      (t (setf return-item item)))
     (setf return-list (append return-list (list return-item)))
     ;;end loop
     )
    return-list
    ;;end let, my-list-zero-floor
  ))
;;TEST
;;  SSS START HERE
;;  (my-list-item-floor  '(1 -1 0.3 -0.1))  = (1 0 0.3 0)
;; (my-list-item-floor  '(1 -1 0.3 -0.1) :if-above-floor-p nil :floor 6) = (1 -1 0.3 -0.1)
;; (my-list-item-floor  '(1 -1 0.3 -0.1) :if-above-floor-p nil) = (0 -1 0 -0.1)