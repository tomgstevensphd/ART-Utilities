;;************************* U-ART2.lisp *********************************
;;
;; UTILITY FUNCTIONS FOR ART2
;; SOME HAVE BEEN REPLACE FOR ART3
;;
;;
;;
;;NOTATION:
#|
   ;;1-D1M VAR LIST: (var-name (var-num layer-num field-num module-num) num-last-field value)
   ;;2-DIM VAR LIST:  (var-name (var-from-num var-to-num  from-layer-num to-layer-num  from-field-num to-field-num from-module-num to-module-num) num-last-field value)
|#
(my-config-editor-after-start)
;;


;;MAKE-DIMLIST-FROM-ART-SYM
;;
;;ddd
(defun make-dimlist-from-art-sym (sym &key node-separator)
  "FOR ART2 U-ART, Takes an ART sym (or string) (eg. zup11-33-9-1-2-3-44-44) and returns a dimension variable list  (eg1-D1M VAR LIST: (var-name (var-num layer-num field-num module-num)) or 2-DIM VAR LIST:  (var-name (var-from-num var-to-num  from-layer-num to-layer-num  from-field-num to-field-num from-module-num to-module-num) separator-str node-separator-n)  from the symbol. RETURNS (values dimlist node-separator-n)"
  (let
      ((dimlist)   
       (node-separator-n)
       (length-root 0)
       (sym-str)
       (match-n-list)
       ;;not used except in MVS
      (nonnum-list) (num-list)(root-str-num-list) (begin-str)(node-separator1)
       )

#|    (when node-separator
      (cond
       ((not (stringp sym))
        (setf sym-str (format nil "~A" sym)))
       (t (setf sym-str sym)))
      ;;find node-separator-n
      (setf node-separator-n (search node-separator sym-str :test 'string-equal)))|#

    ;;the main work of converting
    (multiple-value-setq (dimlist nonnum-list num-list root-str-num-list 
                                  begin-str node-separator1 node-separator-n)
        (convert-object-to-root-num-list sym :separator-str node-separator))
  ;;(break)
    (when (and node-separator-n dimlist)
      (setf dimlist (list (car dimlist) (second dimlist) node-separator node-separator-n)))

    ;;end let, make-dimlist-from-art-sym
    (values dimlist node-separator-n)
    ))
;;TEST
;;  (make-dimlist-from-art-sym 'Zup33-66-2-3-51-51-9-9)
;; works= ("ZUP" (33 66 2 3 51 51 9 9))  NIL
;;
;; (make-dimlist-from-art-sym 'Zup33-66-2To51-51-9-9m :node-separator "to")
;;  works= (ZUP (33 66 2 51 51 9 9) "to" 3)   3




;;SET-CLASS-SYMVAL
;;
;;ddd
(defun set-class-symval (sym value &optional key &key sym-end )
  "In U-ART, if sym is bound, puts value as second item in list, unless KEY.  If key, then sets value wherever key specifies, replacing value there unless append-key-p (SYMVALS = (name value (key1 value)(key2 value), etc) RETURNS (values  new-symvals new-keylist  return-value  final-spec-list old-keylist). If sym is a string creates symbol. If sym-end a string, adds to end of sym. (symvals = (name value (key1 value)(key2 value), etc).  NORMALLY value is a list of subclass symbols. "
  (let*
      ((sym-str)
       (symvals)
       (symvals)
       (new-symvals)
       (new-keylist)
       ;;replaced with new-symvals  (return-nested-lists)
       (return-value)
       (spec-list)
       (old-keylist)
       (old-item)
       )

    ;;make sure sym is a symbol and sym-str is a string
    (if sym-end 
        (setf sym-str  (format nil "~A~A" sym sym-end)
              sym sym-str))
    (if (symbolp sym) 
        (setf sym-str  (format nil "~A" sym ))
      (setf sym-str sym))                   
    (when (stringp sym)
      (setf sym (my-make-symbol sym)))

    (when (and (boundp sym)(listp (eval sym)))
      (setf symvals (eval sym)))

    (cond
     ;;symvals=T, key=NIL
     ((and symvals (null key))
      (multiple-value-setq (new-symvals old-item return-value)
          (replace-nth symvals 1 value)))
     ;;symbals=T
     ((null symvals)
      ;;symvals=NIL, key=NIL
      (if (null key)
          (setf  new-symvals (list sym-str value))
        ;;key=T
        (setf new-symvals (list sym-str nil (list key value)))))
     ;;symvals=T, key=T
     (t
       (multiple-value-setq (new-keylist new-symvals  return-value  spec-list old-keylist)
          (set-key-value-in-nested-lists value (list (list key 0))  symvals))
       ;;set-key- didn't work??

       (when (and (null new-keylist)  key)
         (setf new-keylist (list :no-key value)
               new-symvals (append symvals new-keylist)))
      ;;end t, outer cond
      ))
      ;; (t (setf new-symvals (list sym-str value))))

      ;;set the sym to the new-symvals (done in lower function)
       (set sym new-symvals)
      ;;end let, set-class-symval
      (values  new-symvals  new-keylist  return-value  spec-list old-keylist)
      ))
;;TEST
;; from initialized x-activity
;;  (set-class-symval 'x-activity 99 :key1)
;; works= ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99))  (:KEY1 99)  NIL  NIL NIL
;;  (get-class-symval 'x-activity :key1)
;; works= 99    ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99))
;; (get-class-symval 'x-activity)
;; works = ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5))   ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99)

;; (setf input  '("input" (input1 input2 input3) (:key1 this)(:key2 that)))
;; then (set-class-symval 'input 99 :key2)  =  ("input" (INPUT1 INPUT2 INPUT3) (:KEY1 THIS) (:KEY2 99))   (:KEY2 99)  99  (:KEY2 0)  (:KEY2 THAT)
;; then CL-USER 179 > input =  ("input" (INPUT1 INPUT2 INPUT3) (:KEY1 THIS) (:KEY2 99))
;; 
;;  (set-class-symval "classX1" 99) = ("classX" 99) NIL NIL NIL NIL
;;  (set-class-symval "classX1" 67  nil :sym-end  "end") = ("classXend" 99)  NIL  NIL NIL NIL
;; CL-USER 11 > classX1end = ("classXend" 99)
;; (set-class-symval "classX1end" 77) = ("classXend" 77) NIL 77 NIL NIL
;;  (set-class-symval "classX1end" .22 :key1) = ("classX1end" 77 (:KEY1 0.22))  NIL  NIL  NIL  NIL
;;  (set-class-symval "classX1" .44 :key1) = ("classX1" NIL (:KEY1 0.44)) NIL NIL NIL NIL
 ;;  (set-class-symval "classX1" .11 :key1) = ("classX1" 79 (:KEY1 0.11))  :KEY1 0.11)  NIL  NIL NIL
;;  (makunbound-vars '(classX1 classX1end classXX1))


     

;;GET-CLASS-SYMVAL
;;
;;ddd
(defun get-class-symval (class-sym  &optional key ) ;;later?? &key sym-end)
  "In U-ART, if sym is bound, gets value as second item in list, unless KEY.  RETURNS (values  new-symvals new-keylist  return-value  final-spec-list old-keylist). If sym is a string creates symbol. If sym-end a string, adds to end of sym. (symvals = (name value (key1 value)(key2 value), etc). NORMALLY value is a list of subclass symbols if NO KEY."

  (let*
      (;;(sym-str)
       (symvals (eval class-sym))
       ;;replaced with new-symvals  (return-nested-lists)
       (class-name-str (car symvals))
       ;;value is normally a list of class instance symbols
       (value (second symvals))
      )

    (when key
      (setf keylist
        (get-key-value-in-nested-lists (list (list key 0)) symvals  :return-list-p t)
        value (second keylist)))

    (values value symvals)
    ;;end let, get-class-symval
    ))
;;TEST
;;  (get-class-symval 'input)
;;  (set-class-symval 'x-activity 99 :key1)
;; works= ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99))  (:KEY1 99)  NIL  NIL NIL
;;  (get-class-symval 'x-activity :key1)
;; works= 99    ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99))
;; (get-class-symval 'x-activity)
;; works = ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5))   ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99)



;;
;;SETSYMVAL
;;
;;ddd
(defun setsymval (symbol &optional dims value  &key get-only-p 
                         (betw-dims-strs '("-" "")) (2-node-symbol-list '(wup wdn uup udn))
                         (node-separator "To")(node-separator-n 3) (value-n 3) append-value-p)
  "ART2 VERSION: In U-ART, Adds value to fourth place in the sym-vals list (eg WUP2-3 = (\"Wup\"(2 3) 9 value). RETURNS new sym-vals list (values sym-vals new-sym value old-value). INPUT EITHER1.symbol with dims (eg. sym2-4 nil) or root plus dims (eg. sym (2 4). Use instead of aref. betw-dims-strs is a list of strings to be inserted in order betw dims. NOTE: symbol must be quoted. append-value-p causes it to append the value to the list instead of puttting it in value-n place. dims = list of the i j etc of each dim. "
  (let
      ((sym-vals) 
       (old-sym-vals)
       (old-value)
       (new-sym-str)
       (new-sym)
       (dims-str "")
       (n-dims (list-length dims))
       (temp1)
       )
    (cond
     ;;if using a full art sym with dims built in set dims to NIL
     ((null dims)
      ;; (setf rootdims-list (make-dimlist-from-art-sym symbol)))
      (cond
       ((and (symbolp symbol)(boundp symbol))
        (setf new-sym symbol))

       ;;not symbol or bound
       (t
        (setf new-sym (my-make-symbol (format nil "~A" symbol))))))

     ;;get the new-sym
     (dims
      
     (dims
      ;;make the dims-str


      (cond
       ((= n-dims 1)
        (setf dims-str (format nil "~A" (car dims))
              new-sym (my-make-symbol (format nil "~A~A" symbol dims-str))))
       ;;if it is a  node-to-node symbol
       ((member symbol 2-node-symbol-list :test 'my-equal)
        (setf dims-str 
              (make-art-dims-string dims  :node-separator "To")
              new-sym-str (format nil "~A~A" symbol dims-str)
              new-sym (my-make-symbol new-sym-str)))
       (t 
        ;;puts betw strings between dims
        (setf dims-str  (make-art-dims-string dims)
              new-sym-str (format nil "~A~A" symbol dims-str)
              new-sym (my-make-symbol new-sym-str))))
      )
     (t
      (when (boundp symbol)
        (setf  new-sym symbol ))))

 ;;GET OR SET THE NEW? VALUE  
 (cond
  ((and (symbolp new-sym)(boundp new-sym))
   (setf old-sym-vals (eval new-sym)
         old-value (nth value-n old-sym-vals))
   (cond
    ((not get-only-p)
     (cond
      ((null append-value-p)
       (cond
        ((> (list-length old-sym-vals) 4)
         (setf  sym-vals (list (first old-sym-vals)(second old-sym-vals)
                               (third old-sym-vals) value)
                sym-vals (append sym-vals (nthcdr 4 old-sym-vals))))
        (t                           
         (setf  sym-vals (list (first old-sym-vals)(second old-sym-vals)
                               (third old-sym-vals) value)))))
      (t (setf  sym-vals (append sym-vals (list value)))))
     ;;end  not get-only-p clause
     )
    ;;if get-only-p
    (t 
     (setf value old-value
           sym-vals old-sym-vals)))
     ;;end boundp clause
     )
  ;;if new-sym not bound
  (t  (setf  rootdims-list 
             (make-dimlist-from-art-sym symbol :node-separator node-separator))
      (cond
       ((> (list-length rootdims-list) 2)
        (setf sym-vals (list (first rootdims-list)(second rootdims-list) NIL value)
              sym-vals (append sym-vals (nthcdr 2 rootdims-list))))
       (t 
        (setf sym-vals (list (first rootdims-list)(second rootdims-list) NIL value)))))
  ;;end big cond
  )
      (set new-sym sym-vals)

   (values sym-vals new-sym value old-value)
    ;;end let, setsymval
    ))     
;;TEST
;; (setsymval 'WDN2-1-2TO4-3-1 NIL  0.7)
;;   (setsymval 'WDN2-1-2TO4-3-1 NIL  0.7)
;; ("Wdn" (2 1 2 4 3 1) 1 0.7) WDN2-1-2TO4-3-1 0.7 NIL
;;
;;(setsymval 'wdn '(2 1 2 4 3 1) 0.88)
;;works= (WDN (2 1 2 4 3 1) NIL 0.88 "to" 3)  WDN2-1-2TO4-3-1  0.88  0.7
;;also CL-USER 60 > WDN2-1-2TO4-3-1 
;;works=  (WDN (2 1 2 4 3 1) NIL 0.88 "to" 3) ;note it includes "to" 3

;;IF (setf WDN2-1-2TO4-3-1 '(WDN (2 1 2 4 3 1) nil 0.44 "to" 3))
;;THEN (setsymval 'WDN2-1-2TO4-3-1 NIL  0.7)
;;WORKS= (WDN (2 1 2 4 3 1) NIL 0.7 "to" 3)  WDN2-1-2TO4-3-1  0.7  0.44
;;
;; (setsymval 'WDN2-1-2TO4-3-1 nil nil  :get-only-p T)
;; works= (WDN (2 1 2 4 3 1) NIL 0.44 "to" 3)  WDN2-1-2TO4-3-1 0.44 0.44
;; 
;; (setsymval 'reset-ninputs (list 2) 0)
;; WORKS= ("reset-ninputs" (2) 9 0) RESET-NINPUTS2  0  NIL
;; ALSO= CL-USER 88 > RESET-NINPUTS2 
;;works=  ("reset-ninputs" (2) 9 0)

;;
;; (setsymval 'wdn '(2 1 2 4 3 1) 0.88)




;; TESTING FOR ART2
;;  (setsymval 'WDN2-3 NIL  0.7)
;; works= ("Wdn" (2 3) 5 0.7)  WDN2-3 0.7 NIL
;; works if old value= 0.282= ("Wdn" (2 3) 9 0.7)  WDN2-3 0.7 0.282
;;
;; If wdn2-3 is unbound (setsymval 'WDN2-3 NIL  0.7) =
;; result= ("WDN" (2 3) NIL 0.7)  WDN2-3   0.7  NIL  ;;NOTE the NIL in 3rd place
;;also CL-USER 7 > WDN2-3  =  ("WDN" (2 3) NIL 0.7)
;;
;; also CL-USER 28 > WDN2-3  = ("Wdn" (2 3) 5 0.7)
;; also works when reset value to a new one.
;;  (setsymval 'WDN2-3 NIL  0.55) = ("Wdn" (2 3) 5 0.55) WDN2-3  0.7
;; then using get-only-p, (setsymval 'WDN2-3 NIL  nil :get-only-p T) = ("Wdn" (2 3) 5 0.55)  WDN2-3 nil 0.55
;;
;;  (setsymval "Wdn" '(1 4)  0.98) = ("Wdn" (1 4) 5 0.98)  WDN1-4
;;  CL-USER 41 > WDN1-4  =  ("Wdn" (1 4) 5 0.98)
;;  if change value (setsymval "Wdn" '(1 4)  0.66) = ("Wdn" (1 4) 5 0.66)  WDN1-4 0.98 0.66
;;   (setsymval 'WDN2-3 NIL  '(appended v alue) :append-value-p T) ("Wdn" (2 3) 5 0.33 (APPENDED V ALUE))  WDN2-3  (APPENDED V ALUE)
0.33
;; Used to GET A VALUE as well, use GETSYMVAL below
;;FOR ART3
;;  (setsymval 'WDN2-3-1-1-3-4 NIL 0.55)




;;GETSYMVAL
;;
;;ddd
(defun getsymval (symbol &optional dims  &key (betw-dims-strs '("-" ""))  (value-n 3) (node-separator "To"))
  "In U-ART, returns value in fourth place in the sym-vals list (eg WUP2-3 = (\"Wup\"(2 3) 9 value). RETURNS  (values value sym-vals new-sym). INPUT EITHER1.symbol with dims (eg. sym2-4 nil) or root plus dims (eg. sym (2 4). Use instead of aref. betw-dims-strs is a list of strings to be inserted in order betw dims. NOTE: symbol must be quoted."
  (let
      ((sym-vals) 
       (x)
       (new-sym-str)
       (new-sym)
       (dims-str "")
       (n-dims (list-length dims))
       )

    (multiple-value-setq (sym-vals new-sym x value)
        (setsymval  symbol dims nil :get-only-p T  :betw-dims-strs betw-dims-strs :value-n  value-n :node-separator node-separator))
    (values value sym-vals new-sym)
    ;;end let, getsymval
    ))
;;TEST
;;FOR ART3
;; (getsymval 'WDN2-1-2TO4-3-1)
;; works= 0.44  (WDN (2 1 2 4 3 1) NIL 0.44 "to" 3)  WDN2-1-2TO4-3-1
;;
;; (getsymval 'WDN  '(2 1 2 4 3 1))
;; works= 0.44  (WDN (2 1 2 4 3 1) NIL 0.44 "to" 3)  WDN2-1-2TO4-3-1  


;;FOR ART2
;;  (getsymval 'WDN2-3) = 0.7  ("Wdn" (2 3) 5 0.7)  WDN2-3
;;  (getsymval "Wdn" '(2 3)) = 0.7  ("Wdn" (2 3) 5 0.7)  WDN2-3
;;  (getsymval "Wdn" '(2 3) :value-n 1) = (2 3)  ("Wdn" (2 3) 5 0.7)  WDN2-3
;;  (getsymval "Wdn" '(2 3) :value-n 1)



;;GET-CLASS-SYMVALS
;;
;;ddd
(defun get-class-symvals (class-sym  &key (value-n 3) )
  "In U-ART RETURNS (values symvals-list sym-count). If  value-n = :last, returns last)"
  (let
      ((symvals-list)
        (sym-count)
        )
    (multiple-value-setq (symvals-list x values sym-count)
        (set-class-symvals class-sym NIL  :get-only-p T :value-n value-n))

    (values values symvals-list sym-count)
    ;;end let, get-class-symvals
    ))
;;TEST
;;  (get-class-symvals 'Wdn) = (0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.1 0.11 0.12 0.13 0.14 0.15)     (("Wdn" (1 1) 5 0.1) ("Wdn" (1 2) 5 0.2) ("Wdn" (1 3) 5 0.3) ("Wdn" (1 4) 5 0.4) ("Wdn" (1 5) 5 0.5) ("Wdn" (2 1) 5 0.6) ("Wdn" (2 2) 5 0.7) ("Wdn" (2 3) 5 0.8) ("Wdn" (2 4) 5 0.9) ("Wdn" (2 5) 5 0.1) ("Wdn" (3 1) 5 0.11) ("Wdn" (3 2) 5 0.12) ("Wdn" (3 3) 5 0.13) ("Wdn" (3 4) 5 0.14) ("Wdn" (3 5) 5 0.15))    15
;;
;; (get-class-symvals 'Wdn :value-n 9) = (NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL) ETC
;; (get-class-symvals 'Wdn :value-n :last) = (0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.1 0.11 0.12 0.13 0.14 0.15)  (("Wdn" (1 1) 5 0.1) ("Wdn" (1 2) 5 0.2) ("Wdn" (1 3) 5 0.3) ("Wdn" (1 4) 5 0.4) ("Wdn" (1 5) 5 0.5) ("Wdn" (2 1) 5 0.6) ("Wdn" (2 2) 5 0.7) ("Wdn" (2 3) 5 0.8) ("Wdn" (2 4) 5 0.9) ("Wdn" (2 5) 5 0.1) ("Wdn" (3 1) 5 0.11) ("Wdn" (3 2) 5 0.12) ("Wdn" (3 3) 5 0.13) ("Wdn" (3 4) 5 0.14) ("Wdn" (3 5) 5 0.15))  15




;;SET-CLASS-SYMVALS --NOT CURRENTLY USED??
;;
;;
;;ddd
(defun  set-class-symvals (class-sym &optional value-list &key get-only-p 
                                    (value-n 3) append-value-p)
  "In U-ART, RETURNS (values  new-symvals-list new-values old-values sym-count value-count ).  INPUT class-sym = list of syms, each set to sym-vals = (root dims n-elements value).  append-value-p  causes it to append the value..Works for nested sym-vals lists. Note: value-list is a flat list, should be equal total N of all symbols. value-list may be nested, or can be a single value which is set in all symvals lists. If value-n = :last, sets last value."
  (let
      ((sym-list (eval class-sym))
       (flat-value-list) 
       (flat-sym-list)
       (value-count 0)
       (sym-count 0)
       (symvals)
       (new-values)
       (old-value)
       (old-values)
       (n -1)
       (new-symvals-list)
       )
    (when value-list
      (multiple-value-setq (flat-value-list value-count)
          (flatten-count-nested-lists value-list)))
    (multiple-value-setq (flat-sym-list sym-count)
        (flatten-count-nested-lists sym-list))
    (loop
     for sym in flat-sym-list
     do  
     (incf n)
     ;;find value
     (cond
      ((<= value-count 1)
       (setf value (car flat-value-list))  )
      (t
       (setf value (nth n flat-value-list))))

     ;;get old sym-vals
     (setf symvals (eval sym))
     (when (equal value-n :last)
       (setf value-n (- (list-length symvals) 1)))
     (setf old-value (nth value-n symvals))
     ;;set new value
     ;;(afout 'out (format nil "VALUE= ~A~%" value))
      (unless get-only-p
       (cond
        (append-value-p
         (setf symvals (append symvals (list value)))
         (set sym symvals)
         ;;(afout 'out (format nil "1 >> sym= ~A~% (eval sym)= ~A" sym (eval sym)))     
         )
        (t
         (setf symvals (replace-nth  symvals value-n value))
        ;; (break)
         (set sym symvals)
         ;;(afout 'out (format nil "2  >> sym= ~A~% (eval sym)= ~A" sym (eval sym)))
         )))

      (setf new-symvals-list (append new-symvals-list (list symvals))
            new-values (append new-values (list value))
            old-values (append old-values (list old-value)))
     ;;(afout 'out (format nil "sym= ~A~%symvals= ~A~% new-symvals-list= ~A~%" sym symvals new-symvals-list))
     ;;end loop
     )
    (values  new-symvals-list new-values old-values sym-count value-count )
    ;;end let, set-class-symvals
    ))
;;TEST
;;(defun set-class-symvals (class-sym &optional value-list &key get-only-p (value-n 3) append-value-p )
;;
;; (progn (setf out nil)  (set-class-symvals 'wdn nil :get-only-p T)) = (("Wdn" (1 1) 5) ("Wdn" (1 2) 5) ("Wdn" (1 3) 5) ("Wdn" (1 4) 5) ("Wdn" (1 5) 5) ("Wdn" (2 1) 5) ("Wdn" (2 2) 5) ("Wdn" (2 3) 5 0.7) ("Wdn" (2 4) 5) ("Wdn" (2 5) 5) ("Wdn" (3 1) 5) ("Wdn" (3 2) 5) ("Wdn" (3 3) 5) ("Wdn" (3 4) 5) ("Wdn" (3 5) 5))  
;;(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)
;;(NIL NIL NIL NIL NIL NIL NIL 0.7 NIL NIL NIL NIL NIL NIL NIL)  15  0
;;
;; (set-class-symvals 'wdn '(.99)) = (("Wdn" (1 1) 5 0.99) ("Wdn" (1 2) 5 0.99) ("Wdn" (1 3) 5 0.99) ("Wdn" (1 4) 5 0.99) ("Wdn" (1 5) 5 0.99) ("Wdn" (2 1) 5 0.99) ("Wdn" (2 2) 5 0.99) ("Wdn" (2 3) 5 0.99) ("Wdn" (2 4) 5 0.99) ("Wdn" (2 5) 5 0.99) ("Wdn" (3 1) 5 0.99) ("Wdn" (3 2) 5 0.99) ("Wdn" (3 3) 5 0.99) ("Wdn" (3 4) 5 0.99) ("Wdn" (3 5) 5 0.99))
;;(0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99)
;;(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)  15 1
;;
;; (set-class-symvals 'wdn '(.1 .2 .3 .4 .5  .6 .7 .8 .9 .10 .11 .12 .13 .14 .15)) = 
;;
;; (set-class-symvals 'wdn '(a b c d e f g h i j k l m n o) :append-value-p T) = (("Wdn" (1 1) 5 0.1) ("Wdn" (1 2) 5 0.2) ("Wdn" (1 3) 5 0.3) ("Wdn" (1 4) 5 0.4) ("Wdn" (1 5) 5 0.5) ("Wdn" (2 1) 5 0.6) ("Wdn" (2 2) 5 0.7) ("Wdn" (2 3) 5 0.8) ("Wdn" (2 4) 5 0.9) ("Wdn" (2 5) 5 0.1) ("Wdn" (3 1) 5 0.11) ("Wdn" (3 2) 5 0.12) ("Wdn" (3 3) 5 0.13) ("Wdn" (3 4) 5 0.14) ("Wdn" (3 5) 5 0.15))
;;(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.1 0.11 0.12 0.13 0.14 0.15)
;;(0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99) 15 15
;;
;; (set-class-symvals 'wdn '(a b c d e f g h i j k l m n o) :value-n :last)  = (("Wdn" (1 1) 5 A) ("Wdn" (1 2) 5 B) ("Wdn" (1 3) 5 C) ("Wdn" (1 4) 5 D) ("Wdn" (1 5) 5 E) ("Wdn" (2 1) 5 F) ("Wdn" (2 2) 5 G) ("Wdn" (2 3) 5 H) ("Wdn" (2 4) 5 I) ("Wdn" (2 5) 5 J) ("Wdn" (3 1) 5 K) ("Wdn" (3 2) 5 L) ("Wdn" (3 3) 5 M) ("Wdn" (3 4) 5 N) ("Wdn" (3 5) 5 O))
;;(A B C D E F G H I J K L M N O)
;;(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.1 0.11 0.12 0.13 0.14 0.15)  15  15
    
     
     







#|

     (setf length-symlist (list-length sym-list)
           value-list (nth 
     
     (loop
      for sym in sym-list
      for n from 0 to (- length-symlist 1)
      do
      ;;set value
      (unless get-only-p
        (cond
         ((and value-list (listp value-list))
          (setf value (nth n value-list)))
         (value-list
          (setf value value-list))
         (t nil)))

      (multiple-value-setq ( sym-vals new-sym value old-value)
          (setsymval sym nil value :get-only-p get-only-p :betw-dims-strs betw-dims-strs 
                     :value-n value-n :append-value-p append-value-p))
     
      (setf  sym-vals-list (append sym-vals (list sym-vals))
             new-sym-list (append new-sym-list (list new-sym))
             value-list (append value-list (list value))
             old-value-list (append old-value-list (list old-value))
             sym-vals-loop-list (append sym-vals-loop-list (list sym-vals))
             ;;new-sym-list (append new-sym-list (list new-sym))
             ;;value-loop-list (append value-loop-list (list value))
             old-value-loop-list (append old-value-loop-list (list old-value)))
      ;;end inner loop
      )
     (setf  sym-vals-nested-list (append sym-vals-nested-list (list sym-vals-loop-list))
             ;;new-sym-list (append new-sym-list (list new-sym))
             ;;value-nested-list (append value-list (list value))
             old-value-nested-list (append old-value-nested-list (list old-loop-value))
             sym-vals-loop-list nil
             old-loop-value nil)
     ;;end outer loop
     )
    ;;end let, set-class-symvals
    (values  value-list sym-vals-list new-sym-list old-value-list)
    ))|#
;;TEST
;;   (defun set-class-symvals (class-sym  value-list &key  get-only-p  (value-n 3) append-value-p (betw-dims-strs '("-" "")))
;;  (set-class-symvals 'wup   '(.11 .12 .13 .14 .15) )



#|
 
;;MAKE-POINTS-LIST
;;
;;ddd
(defun get (cell-type)
  "In  U-ART, makes a graph points list from eg. input, x-activity"
  (let
      ((cell-list)
       (points-list)
       (cell-count)
       )
    (multiple-value-setq (cell-list cell-count)
        (flatten-count-nested-lists (eval cell-type)))
    (
    (dolist (cell cell-type)
      (setf points-list (append points-list (list (last (eval cell)))))
      )
    (values points-list cell-type)
    ))
;;TEST
;;works
CL-USER 21 > (make-points-list wup)

;;;(INPUT0 INPUT1 INPUT2 INPUT3 INPUT4)
|#



;;sss START HERE ON POINTS--REPLACE WITH ABOVE FUNCTIONS
;;  and FIND WHERE OLD SYMS GOT SET TO EG (0 (20 0.076000005))
(defun make-points-list (sym-class)
  "In ART-multipane-interface.lisp, makes a graph points list from eg. input, x-activity"
  (let
      ((symvals)
       (points-list)
       )
    (dolist (cell sym-class)
      (setf symvals (append points-list (list (eval cell)))
            points-list  (last symvals))
      )
    (values points-list cell-type)
    ))
;;TEST
;;works
#|CL-USER 21 > (make-points-list input)
((0 (20 0.076000005)) (1 (40 0.23568)) (2 (60 0.91568)) (3 (80 0.37008)) (4 (100 -0.07216)))
(INPUT0 INPUT1 INPUT2 INPUT3 INPUT4)
|#



;;

(defun initialize-ART-graph-data ()
  (setf 
   ;;THE POINTS LISTS
   *I-points (make-graph-points-list input)
   ;;was'((0 (40 0) "0") (1 (80 0.4) "1") (2 (120 0.9) "2") (3 (160 0.4) "3") (4 (200 0) "4"))
   *v-points (make-graph-points-list x-activity)
   ;;was'((0 (40 0) "0") (1 (80 0.4) "1") (2 (120 0.7) "2") (3 (160 0.4) "3") (4 (200 0.4) "4"))
#| doesn't work because  double-indexes  *wup-points (make-graph-points-list wup)
   ;;was'((0 (40 0) "0") (1 (80 0.2) "1") (2 (120 0.3) "2") (3 (160 0.2) "3") (4 (200 0.1) "4"))
   *wdn-points (make-graph-points-list wdn)
   ;;was'((0 (40 0) "0") (1 (80 0.0) "1") (2 (120 0.1) "2") (3 (160 0.4) "3") (4 (200 0.2) "4"))|#
   *reset-points (make-graph-points-list reset)
   *y-points (make-graph-points-list y-output)
   ;;was'((0 (40 0) "0")  (1 (80 1.0) "1")  (2 (120 0) "2"))
   ;;mmm  ;;To make graph of ALL reset vals in each frame

   ;;THE CELL NAMES
   *I-cell-list input
   ;;was'(In0 In1 In2 In3 In4)
   *x-list x-activity
   ;;was'(x0 x1 x2 x3 x4)
   *wup-list wup
   ;;was'(wu0 wu1 wu2 wu3 wu4)
   *wdn-list wdn
   ;;was'(wd0 wd1 wd2 wd3 wd4)
   *Y-cell-list  y-output
   ;;was'(y1 y2 y3))
   *reset-list  reset
  ))


;;MAKE-GRAPH-POINTS-LISTS
;;
;;ddd
(defun make-graph-points-lists (class-sym-list  &key  (initial-x-pix 0) (incr-x-pix 40)
                                         (sortdim-n 1)  append-symvals-p
                                         (from-index0 1)(to-index0 1)
                                         (use-label-abbrev-p T) (add-label-p T)
                                         (setsym-2dim-nested-lists-p T)
                                         no-1dimlists-in-nested-p)
  "In ART.lisp, NOTE:  initial-x-pix and incr-x-pix can be a value OR a list of values--single value used for all, list values must match num cells. Takes N dim arrays RETURNS (values  converted-symvals-lists symbols-list)   eg. (PUT EG HERE SSS  ). 1-dim lists are appended to nested-points-lists unless no-1dimlists-in-nested-p"
  (let*
      ((class-points-sym)
       (class-points-syms)
       (flat-points-lists)
       (nested-points-lists)
       (points-sym)
       (flat-points-list)
       (nested-points-list)
       )
    (loop
     for class-sym in class-sym-list
     do
     (multiple-value-setq (class-points-sym flat-points-list nested-points-list)
         (make-graph-points-list class-sym  :initial-x-pix initial-x-pix
                                 :incr-x-pix incr-x-pix
                                 :sortdim-n sortdim-n
                                 :append-symvals-p append-symvals-p 
                                 :use-label-abbrev-p use-label-abbrev-p 
                                 :add-label-p add-label-p
                                 :setsym-2dim-nested-lists-p setsym-2dim-nested-lists-p
                                  ))

     (setf class-points-syms (append class-points-syms (list class-points-sym))
           flat-points-lists (append flat-points-lists (list flat-points-list)))
     (cond
      (nested-points-list
          (setf nested-points-lists (append nested-points-lists (list nested-points-list))))
      (no-1dimlists-in-nested-p NIL)
      (t  (setf nested-points-lists (append nested-points-lists (list flat-points-list)))))   

     ;;end loop
     )
    (values class-points-syms  flat-points-lists  nested-points-lists)
    ;;end let, make-graph-points-lists
    ))
;;TEST
;;FOR ART3 ----------------------------------
;; (make-graph-points-lists  '(X))
;; (make-graph-points-lists  '(Y))


;;FOR ART2 ------------------------------------------------------------------
;; to test (setf *t-input '("input" ((input1 input2 input3))) input1 '("input" (1) 3 .11) input2 '("input" (2) 3 .22)  input3 '("input" (3) 3 .33)  *t-wup '("wup" ((wup1-1 wup1-2)(wup1-2 wup2-2)))  wup1-1 '("wup" (1 1) 2  .11)  wup2-1 '("wup" (1 1) 2  .21) wup1-2 '("wup" (1 2) 2 .12) wup2-2 '("wup" (2 2) 2 .22))
;;  (make-graph-points-lists '(*t-input *t-wup)) ;; activity))
;; works= (*INPUT-POINTS *WUP-POINTS)
;flatlist: (((1 (40 0.11) "input1" (1)) (2 (80 0.22) "input2" (2)) (3 (120 0.33) "input3" (3))) ((1 (40 0.11) "wup1-1" (1 1)) (1 (80 0.12) "wup1-2" (1 2)) (1 (120 0.12) "wup1-2" (1 2)) (2 (160 0.22) "wup2-2" (2 2))))
;;nested-list with 1dim: (((1 (40 0.11) "input1" (1)) (2 (80 0.22) "input2" (2)) (3 (120 0.33) "input3" (3))) ((:DIMLIST 1 ((1 (40 0.11) "wup1-1" (1 1)) (1 (80 0.12) "wup1-2" (1 2)))) (:DIMLIST 1 ((1 (40 0.12) "wup1-2" (1 2)) (2 (80 0.22) "wup2-2" (2 2))))))

;; (make-graph-points-lists '(input))

;;TO TEST FOR ART3
;; to test (setf *t3-input '("input" ((input1-2-11 input2-2-11 input3-2-11))) input1-2-11 '("input" (1 2 11) 3 .11) input2-2-11 '("input" (2 2 11) 3 .22)  input3-2-11 '("input" (3 2 11) 3 .33)  *t3-wup '("wup" ((wup1-1-2-2-11-11 wup1-2-2-2-11-11)(wup1-2-2-2-11-11 wup2-2-2-2-11-11)))  wup1-1-2-2-11-11 '("wup" (1 1 2 2 11 11) 2  .11)  wup2-1-2-2-11-11 '("wup" (1 1 2 2 11 11) 2  .21) wup1-2-2-2-11-11 '("wup" (1 2 2 2 11 11) 2 .12) wup2-2-2-2-11-11 '("wup" (2 2 2 2 11 11) 2 .22) *GRAPH-SYM-ABRV-BEGIN-N 20 *GRAPH-SYM-ABRV-BEGIN-N 0 *GRAPH-SYM-ABRV-END-N 3)
;;
;;  (make-graph-points-lists '(*t3-input *t3-wup)) 




;;MAKE-GRAPH-POINTS-LIST
;;
;;ddd
(defun make-graph-points-list (class-sym &key  (initial-x-pix 0) (incr-x-pix 40)
                                           append-symvals-p
                                         (use-label-abbrev-p T) (add-label-p T)
                                         (setsym-2dim-nested-lists-p T)
                                         (sortdim-n 1))
  "In ART.lisp, NOTE:  initial-x-pix and incr-x-pix can be a value OR a list of values--single value used for all, list values must match num cells. Takes N dim arrays RETURNS (values class-points-sym flat-points-list nested-points-list)   eg. (PUT EG HERE SSS  ). setsym-2dim-nested-lists-p returns nested list if 2dim, otherwise flat. NOTE: if n-dims >= 2, syms are nested by all F1 together first level, F2 groups of F1 ((C11 C21)(C12 C22)), Eg. 1-dim: *INPUT-POINTS = '((:DIMLIST 1 ((1 (40 110) INPUT1 (1)) (2 (80 222 ) INPUT2 (2)) (3 (120 333) INPUT2 (3))))), for 2-dim: *WUP-POINTS = ((:DIMLIST 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1)))) (:DIMLIST 2 ((1 (40 50) WUP1-2 (1 2)) (2 (80  20) WUP2-2 (2 2)))))."
  (let*
      ((class-symvals (eval class-sym))
       (syms (second class-symvals))
       (flat-sym-list (flatten-count-nested-lists syms))
       (n-syms (list-length flat-sym-list))
       (firstsym-symvals (eval (car flat-sym-list)))
       (firstsym-dims (second firstsym-symvals))
       (n-dims (list-length firstsym-dims))
       (symroot (first firstsym-symvals))
       (firstsym-lastelem-n (third  firstsym-symvals))
       (n-field2-groups 1)  
       (firstF1-n)
       (flat-points-list)
       (new-symvals-list)
       (new-values)
       (old-values)
       (sym-count)
       (value-count)
       (x-pix initial-x-pix)
       (y-pix 0)
       ;;(label "")
       (x-val initial-x-pix)
       (class-points-sym-str)
       (class-points-sym)
       (points-list)
       (nested-points-list)
       (dims)
       (sym-i)
       (sym-j)  
       (n-dims)
       )
    ;;(afout 'out (format nil "1 flat-sym-list= ~A~%" flat-sym-list))

    ;;make the graph-points-list points-sym
    (setf  class-points-sym-str (format nil "*~A-points" symroot)
           class-points-sym (my-make-symbol class-points-sym-str))
    ;;(afout 'out (format nil "1 class-points-sym= ~A~%" class-points-sym))
 
    ;;MAKE THE GRAPHING VALUES TO ADD 
    ;;from draw-graph-window function, points-list input eg.:  ((:DIMLIST 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1)))) (:DIMLIST 2 ((1 (40 50) WUP1-2 (1 2)) (2 (80  20) WUP2-2 (2 2)))))
    (loop
     for sym in flat-sym-list
     for n from 1 to n-syms
     do
     (let*
         ((symvals (eval sym))
          (root (first symvals))
          (lastfield-n (third symvals))
          (value (fourth symvals))
          (point)
          (preitems)
          ;;sss write abbreviate-sym later
          (label-abbrev)    ;;in config-art
          ) 

       (setf dims (second symvals)
             n-dims (list-length dims)
             sym-i (car dims)
             sym-j (second dims))
       ;;(break)

       ;;Include label or abbrev in point?
       (cond
        ((null add-label-p) NIL)
        (use-label-abbrev-p
         (setf label-abbrev (abbreviate-sym-str sym *graph-sym-abrv-begin-n *graph-sym-abrv-end-n)))
        (t (setf  label-abbrev sym)))
      
       ;;SET THE PIXELS FOR GRAPH
       (setf x-pix (+ x-pix incr-x-pix)
             point (list sym-i (list x-pix value) label-abbrev dims))


       ;;MAKE FLAT POINTS LIST
       (setf flat-points-list (append flat-points-list (list point)))

       ;;(afout 'out (format nil "2 class-points-sym= ~A~%" class-points-sym))
       ;;when want to add point to cell/sym symvals
       (when append-symvals-p
         (multiple-value-setq (new-symvals-list new-values old-values 
                                                sym-count value-count )
             (set-class-symval class-sym dims  :append-value-p t)))

       ;;end inner let*,loop
       ))

    ;;FOR 2-dim NESTED LISTS
    ;;nested-list-goal ((:DIMLIST 1 (1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1))) (:DIMLIST 2 (1 (40 50) WUP1-2 (1 2)) (2 (80 20) WUP2-2 (2 2))))
    (when (and (= n-dims 2) setsym-2dim-nested-lists-p)
      (cond
       ((equal class-sym 'wup) (setf sort2dim-n *sort-wup-dim))
       ((equal class-sym 'wdn) (setf sort2dim-n *sort-wdn-dim))
       (t nil))
      (setf nested-points-list (sort-art-list-into-nested-lists  flat-points-list
                                                                 :sortdim-n sort2dim-n 
                                                                 :pre-add-dim-n-p T 
                                                                 :preitems '(:dimlist) 
                                                                 :double-quote-nested-item-p T
                                                                 :x-pix0 40 :x-pix-incr *incr-x-pix)))

    ;;first item is (dimlist dimlist etc), 2nd (1 2 3 4...), only 3rd useful
    ;;(setf nested-points-list (third nested-points-list))
    
    ;;(afout 'out (format nil "3 class-points-sym= ~A~%" class-points-sym))
    (cond
     ((and (= n-dims 2) setsym-2dim-nested-lists-p)
      (set class-points-sym nested-points-list))
     (t (set class-points-sym flat-points-list)))

    (values class-points-sym flat-points-list nested-points-list)
    ;;end let*, make-graph-points-list
    ))
;;TEST  
;;from actual data
;; (make-graph-points-list  'input)
;;works= *INPUT-POINTS    ((1 (40 0.033760004) "Input1" (1)) (2 (80 0.070879996) "Input2" (2)) (3 (120 -0.021760002) "Input3" (3)) (4 (160 0.97904) "Input4" (4)) (5 (200 1.05632) "Input5" (5)) (6 (240 0.92912) "Input6" (6)) (7 (280 0.05392) "Input7" (7)) (8 (320 0.05088) "Input8" (8)) (9 (360 -0.006240003) "Input9" (9)))    NIL
;;also *INPUT-POINTS evals to above list
;;  (make-graph-points-list  'wup)
;;works=  *WDN-POINTS
;;  ((1 (40 0.86669004) "Wdn1-1" (1 1)) (1 (80 0.8019) "Wdn1-2" (1 2)) (1 (120 0.89576) "Wdn1-3" (1 3)) (1 (160 0.8133) "Wdn1-4" (1 4)) (1 (200 0.83268) "Wdn1-5" (1 5)) (1 (240 0.91058004) "Wdn1-6" (1 6)) (1 (280 0.87296004) "Wdn1-7" (1 7)) (1 (320 0.80532) "Wdn1-8" (1 8)) (1 (360 0.81729) "Wdn1-9" (1 9)) (2 (400 0.8526331) "Wdn2-1" (2 1)) (2 (440 0.88569314) "Wdn2-2" (2 2)) (2 (480 1.6516918) "Wdn2-3" (2 3)) (2 (520 63.665223) "Wdn2-4" (2 4))  ...... rest
;;((:DIMLIST 1 ((1 (40 0.081907004) "Wup1-1" (1 1)) (1 (80 0.33341035) "Wup1-2" (1 2)) (1 (120 0.033630997) "Wup1-3" (1 3)) (1 (160 0.025734) "Wup1-4" (1 4)) (1 (200 0.137335) "Wup1-5" (1 5)))) (:DIMLIST 2 ((2 (40 0.086675) "Wup2-1" (2 1)) (2 (80 8.843666) "Wup2-2" (2 2)) (2 (120 0.033184) "Wup2-3" (2 3)) (2 (160 0.061941) "Wup2-4" (2 4)) (2 (200 0.085036) "Wup2-5" (2 5)))) (:DIMLIST 3 ((3 (40 0.13629201) "Wup3-1" (3 1)) (3 (80 28.409277) "Wup3-2" (3 2)) (3 (120 0.013963) "Wup3-3" (3 3)) (3 (160 0.13837801) "Wup3-4" (3 4)) (3 (200 0.10768401) "Wup3-5" (3 5))))  ... plus rest.
;;(make-graph-points-list  'wup  :group-by-F1-p T)


;;ABBREVIATE-SYM-STR
;;
;;ddd
(defun abbreviate-sym-str (sym  n-begin-digits n-end-digits &key (add-dims-p T) (abbrev-sym-root-p T)) ;;not work  (separator #\-)) ;;  "-"))  ;;or "-"
  "In U-ART, sym can be a symbol or string. Works ONLY on an ART sym that is set to a list such as (\"Input1\" (1)) or wup2-3 = (\"Wup\" (2 3) 5 NIL) If change separator betw dims, must manually replace the hyphen in code  below. RETURNS (values new-str symvals)"
  ;; sss START HERE, MUST CONVERT SYMBOL TO A STRING FIRST
  (let
      ((symvals)
       (begin-str "")
       (end-str "")
       (new-str )
       (dims-str "")
       (sym-str)
       (sym-length) ;; (length sym))
       ;;  (begin 0)
       (end 3)
       )
    ;;if sym a string, then work on it and don't try to eval it
    (when (stringp sym)
      (setf abbrev-sym-root-p nil))

    (cond
     ((null abbrev-sym-root-p)
      (setf sym-str sym))
     ((and (boundp sym) (listp (setf symvals (eval sym))))
      (setf sym-str (car symvals)
            dims (second symvals))
      ;;add the dims to string?
      (when add-dims-p
        (setf dims-str (format nil "~{~a~^-~}" dims) ;;not work  separator)
              sym-str (format nil "~A~A" sym-str dims-str)))
      )
     (t nil))

    (when (stringp sym-str)
      (setf sym-length (length sym-str))  
      ;;(afout 'out (format nil "sym-str= ~A~%" sym-str))

      ;;make the begin-str and end-str and abbreviate if not longer than original
      (cond
       ;;not shorter than original 
       ((>= (+ (- n-begin-digits 1) n-end-digits) sym-length)
        (setf new-str  sym-str)) ;;added extra (format nil "~A~A" sym-str dims-str)))
       (t (setf   end (- sym-length  n-end-digits )
                  begin-str (subseq sym-str  0  n-begin-digits)
                  end-str (subseq sym-str end)
                  new-str (format nil "~A~A" begin-str end-str))))
      ;;end when
      )
    (values new-str symvals)
    ;;end mvb,let,abbreviate-sym
    ))
;;TEST
;; (abbreviate-sym-str  'wup3-4  2 3)  = "Wu3-4"  ("Wup" (3 4) 5 NIL) 
 ;; (abbreviate-sym-str  "wup3-4"  2 3)  = "wu3-4"  NIL  ;;from string not symbol
;;  (abbreviate-sym-str  'input2 2 2) =  "int2"  ("input" (2) 3 0.22) = "it2"  ("input" (2) 3 0.22)
;;  (abbreviate-sym-str  'input2 4 4) = "input2"  ("input" (2) 3 0.22)


;;WRITE-CELL-TEXT
;;
;;ddd
(defun write-cell-text (rich-text-pane art-point-lists &key pane-label
                                       font-list graph-color-list)
  "In U-ART, If  (NULL rich-text-pane), then just returns the text. RETURNS (values info-text MAX-VALUE point-label-list point-value-list)  INPUT: art-point-list egs. *INPUT-POINTS = ((1 (40 0.11) \"input1\" (1)) (2 (80 0.22) \"input2\" (2)) (3 (120 0.33) \"input3\" (3))), for 2-dim: *WUP-POINTS = ((:DIMLIST 1 ((1 (40 0.11) \"wup1-1\" (1 1)) (1 (80 0.12) \"wup1-2\" (1 2)))) (:DIMLIST 1 ((1 (40 0.12) \"wup1-2\" (1 2)) (2 (80 0.22) \"wup2-2\" (2 2)))))."
  (let
      ((dimlist-n 1)
       (point-n)
       (point-list)
       (point-info-list)
       (point-label-list)
       (point-value-list)
       (pix-point-label-lists)
       (font) 
       (value)
       (x-pix)
       (label)
       (dim1)
       (last-dim)
       (info-text "")
       (color-text "")
       (n-point-lists (list-length art-point-lists))
       (multi-dim-list-p)
       )
    (if (equal (caar  art-point-lists) :dimlist)  (setf multi-dim-list-p T))

    (loop
     for art-point-list in art-point-lists
     do
     (cond
      ((equal (car art-point-list) :dimlist)
       (setf dimlist-n (second art-point-list)
             point-list (third art-point-list)))
             ;;multi-dim-list-p T))
      (t (setf point-list (list art-point-list))))

     ;;make the point-info-list
    (loop
     for point in point-list
     do     
     (multiple-value-setq (value x-pix label dim1 last-dim)
         (find-point-value point))
       (setf point-info-list (append point-info-list (list label value))
             point-label-list (append point-label-list (list label))
             point-value-list (append point-value-list (list value)))
       ;;end loops
       ))

    ;;(afout 'out (format nil ">>>> graph-color-list= ~A  multi-dim-list-p= ~A  n-point-lists= ~A~%" graph-color-list  multi-dim-list-p  n-point-lists 1) )
    ;;LIST DIM-COLOR FOR GRAPH LINES
      (when  (and graph-color-list  multi-dim-list-p  (> n-point-lists 1)) 
        (setf color-text  "[DIM 1:")
        (loop
         for n from 1 to n-point-lists
         for color in graph-color-list
         do
         (setf color-text (format nil "~A ~A=~A" color-text  n color))
         )
        (setf color-text (format nil "~A]" color-text))
        )
      

    ;;GET MAX-MIN INFO
    (multiple-value-bind (max-value max-val-ptnum max-val-ptlabel min-value  min-val-ptnum min-val-ptlabel)
        (find-max-min-points-list art-point-lists)

      (unless pane-label (setf  pane-label "VARS-VALS:"))
      ;;write the info-text
      (setf info-text
            (format nil "~%~A MAX=~A at ~A,~A; MIN=~A at ~A,~A  ~A  >>ALL==>  ~{~S= ~S  ~} " pane-label  max-value max-val-ptnum max-val-ptlabel min-value  min-val-ptnum min-val-ptlabel color-text point-info-list))

      ;;if write to a window
      (when  rich-text-pane        
        ;;sss  creates error (my-find-best-font rich-text-pane font-list )
        ;;set the new font here
        ;; (setf (capi:simple-pane-font rich-text-pane) font)
        ;;write the text
        (setf (capi:rich-text-pane-text  rich-text-pane) info-text))

      (values info-text MAX-VALUE point-label-list point-value-list)
      ;;end mvb, let, write-cell-text
      )))
;;TEST
;; without a pane
;; (write-cell-text nil *wup-points :graph-color-list *graph-color-list)
;; (write-cell-text nil *input-points :graph-color-list *graph-color-list)
;; works= VARIABLES and VALUES:    \"input1\"= 0.11  \"input2\"= 0.22  \"input3\"= 0.33   "    ("input1" "input2" "input3")    (0.11 0.22 0.33)
;;
;; (write-cell-text nil  *wup-points) =   \"Wup1-1\"= 0.081907004  \"Wup1-2\"= 0.33341035  \"Wup1-3\"= 0.033630997  \"Wup1-4\"= 0.025734  \"Wup1-5\"= 0.137335  \"Wup2-1\"= 0.086675  \"Wup2-2\"= 8.843666  \"Wup2-3\"= 0.033184  \"Wup2-4\"= 0.061941  \"Wup2-5\"= 0.085036  \"Wup3-1\"= 0.13629201  \"Wup3-2\"= 28.409277  \"Wup3-3\"= 0.013963  \"Wup3-4\"= 0.13837801  \"Wup3-5\"= 0.10768401  \"Wup4-1\"= 0.048382 ...etc.
;; ("Wup1-1" "Wup1-2" "Wup1-3" "Wup1-4" "Wup1-5" "Wup2-1" "Wup2-2" "Wup2-3" "Wup2-4" "Wup2-5" "Wup3-1" "Wup3-2" "Wup3-3" "Wup3-4" "Wup3-5" "Wup4-1" "Wup4-2" "Wup4-3" "Wup4-4" "Wup4-5" "Wup5-1" "Wup5-2" "Wup5-3" "Wup5-4" "Wup5-5" "Wup6-1" "Wup6-2" "Wup6-3" "Wup6-4" "Wup6-5" "Wup7-1" "Wup7-2" "Wup7-3" "Wup7-4" "Wup7-5" "Wup8-1" "Wup8-2" "Wup8-3" "Wup8-4" "Wup8-5" "Wup9-1" "Wup9-2" "Wup9-3" "Wup9-4" "Wup9-5")
;;(0.081907004 0.33341035 0.033630997 0.025734 0.137335 0.086675 8.843666 0.033184 0.061941 0.085036 0.13629201 28.409277 0.013963 0.13837801 0.10768401 0.048382 358.85248 0.121839 0.145977 0.019178002 0.015453001 14.874984 0.10768401 0.119008005 0.114240006 0.135845 16.450892 0.09174101 0.045104 0.13778201 0.072371006 0.28825817 0.026330002 0.018731002 0.12139201 0.12496801 368.434 0.085036 0.111707 0.064027004 0.056428 340.56998 0.036909 0.006364 0.136143)


;;(capi:contain (write-cell-text nil *input-points))

 #|(capi:contain  
   (make-instance 'capi:rich-text-pane
                  :text (write-cell-text nil *input-points)
                  :font (gp:make-font-description
                         :family "times" 
                         :size 12 
                         :weight :medium                         
                         :slant :roman)))|#
 ;;above works

;;FIND-POINT-VALUES
;;
;;ddd
(defun find-point-value (art-point)
  "In U-ART, Eg (1 (40 0.11) \"wup1-1\" (1 1))"
  (multiple-value-bind (point-n  pix-val-list label dims)
      (values-list art-point)
    (let
        ((x-pix (car pix-val-list))
         (value (second pix-val-list))
         (dim1 (car dims))
         (last-dim (car (last dims))))                        
      (values value x-pix label dim1 last-dim)
      ;;end find-point-values
      )))
 ;;TEST
 ;; (find-point-value  '(1 (40 0.11) \"wup1-1\" (1 1)))
;; works= 0.11  40  \"WUP1-1\"  1  1
















;;CONVERT-ART-POINTS -- REPLACED?
;;
;;ddd
#|(defun convert-art-points (art-points-lists &key (list-dim 1)(sort-by-dim 2))
  "In U-ART, converts LIST of dim points lists from ART to function-plotter functions format., INPUT  Eg. 1-dim: *INPUT-POINTS =((1) (40 0.11) \"input1\") ... ((3) (120 0.33) \"input3\")), for 2-dim: *WUP-POINTS = ((1 1) (40 0.11) \"wup1-1\") ((1 2) (80 0.12) \"wup1-2\")) OUTPUT =  ((:DIMLIST dim ((time0  (x1 x2 ... xn) \"label\" dims  extra stuff goes here) (time1 (x1 x2 .. xn) etc)). Eg, ((:DIMLIST 1 ((1 (40 0.11) WUP1-1 (1 1)) (2 (80 0.21) WUP1-2 (2 1)))) (:DIMLIST 2 ((1 (40 0.12) WUP1-2 (1 2)) (2 (80 0.22) WUP2-2 (2 2)))))
. Puts list-dim num in place of the time. RETURNS function-plotter-points-list. NOTE: art-points-lists can be a SYMBOL eval to the list."
  (when (symbolp art-points-lists)
    (setf art-points-sym art-points-lists
          art-points-lists (eval art-points-sym)))
  (let
      ((function-plotter-dim-points-list)
       (function-plotter-points-lists)
       (sort-dim-n)
       (dims)
       )

    (loop
     for art-dim-points-list in  art-points-lists
     do
     ;;(afout 'out (format nil "1 art-dim-points-list=~A~%" art-dim-points-list))
     (setf dims (caar art-dim-points-list))
     (cond
      ((= (list-length dims) 1)
       (setf sort-dim-n 1))
      (t (setf sort-dim-n (nth (- sort-by-dim 1)dims))))

     (setf function-plotter-dim-points-list
           (convert-art-dim-points  art-dim-points-list :list-dim list-dim))
     ;;(afout 'out (format nil "2 function-plotter-dim-points-list=~A~%" function-plotter-dim-points-list))
     (setf function-plotter-points-lists (append function-plotter-points-lists
                                                 (list (list :dimlist sort-dim-n function-plotter-dim-points-list))))
     ;;(afout 'out (format nil "3 function-plotter-points-lists=~A~%" function-plotter-points-lists))
     ;;end loop
     )
    function-plotter-points-lists
  ;;end let, convert-art-points
  ))|#
;;TEST
;;  (convert-art-points '((((1 1) (40 0.11) WUP1-1) ((2 1) (80 0.21) WUP1-2)) (((1 2) (40 0.12) WUP1-2) ((2 2) (80 0.22) WUP2-2)))) 
;; works= ((:DIMLIST 1 ((1 (40 0.11) WUP1-1 (1 1)) (2 (80 0.21) WUP1-2 (2 1)))) (:DIMLIST 2 ((1 (40 0.12) WUP1-2 (1 2)) (2 (80 0.22) WUP2-2 (2 2)))))
;;  (convert-art-points '((((1 ) (40 0.11) INPUT1) ((2) (80 0.2) INPUT2)((3) (120 0.3) INPUT2))))
;; works= ((:DIMLIST 1 ((1 (40 0.11) INPUT1 (1)) (2 (80 0.2) INPUT2 (2)) (3 (120 0.3) INPUT2 (3)))))


;;CONVERT-ART-DIM-POINTS  WORKS BUT REPLACED?
;;
;;ddd
#|(defun convert-art-dim-points (art-dim-points-list &key (list-dim 1))
  "In U-ART, converts ONE dim points list from ART to function-plotter functions format., INPUT  Eg. 1-dim: *INPUT-POINTS =((1) (40 0.11) \"input1\") ... ((3) (120 0.33) \"input3\")), for 2-dim: *WUP-POINTS = ((1 1) (40 0.11) \"wup1-1\") ((1 2) (80 0.12) \"wup1-2\")) OUTPUT =  ((time0  (x1 x2 ... xn) \"label\" dims  extra stuff goes here) (time1 (x1 x2 .. xn) etc)).. Puts list-dim num in place of the time. RETURNS function-plotter-points-list."
  (let
      ((point)
       (dims)
       (dim)
       (coord-list)
       (label)
       (function-plotter-points-list)
       )
    (loop
     for point in art-dim-points-list
     do
     (multiple-value-setq (dims coord-list label)
         (values-list point))
     
     (if (> (list-length dims) 1)
         (setf time (nth (- list-dim 1) dims))
       ;;otherwise
       (setf time (car dims)))
     ;;make list
     (setf function-plotter-points-list (append function-plotter-points-list
                                                (list (list time coord-list label dims))))
     ;;end loop
     )
    function-plotter-points-list
    ;;end let, convert-art-dim-points
    ))|#
;;TEST
;;   (convert-art-dim-points '(((1 1) (40 0.11) \"wup1-1\")((2 1) (80 0.21) \"wup1-2\")))
;; works= ((1 (40 0.11) \"WUP1-1\" (1 1)) (2 (80 0.21) \"WUP1-2\" (2 1)))

     
       
;;FIND-MAX-MIN-POINTS-LIST
;;
;;ddd
(defun find-max-min-points-list (points-list &key max-floor min-ceiling)
  "In U-ART, INPUT: Either 2-dim or 1-dim points lists; RETURNS (values max-value max-val-ptnum max-val-ptlabel   min-value  min-val-ptnum min-val-ptlabel).  If max-floor, sets min for the max value= floor. Otherwise min of max-value= -999999,If  min-ceiling otherwise max of min= 999999."
  (let
      ((points)
       (all-points)
       (point)
       (value)
       (max-value)
       (max-val-ptnum)
       (max-val-ptlabel)
       (min-value)
       (min-val-ptnum)
       (min-val-ptlabel)
       )
    (loop
     for dimlist in points-list
     do
     (when (listp dimlist)
       (cond
        ;;for multi-dim points
        ((equal (car dimlist) :dimlist)
         (setf points (third dimlist)
               all-points (append all-points  points)))
        ;;for single-dim points
        (t (setf all-points (append all-points (list dimlist))))))
     ;;end loop
     )   
    ;;WORK ON ALL-POINTS LIST
    (multiple-value-setq (max-value max-val-ptnum max-val-ptlabel  
                                    min-value  min-val-ptnum min-val-ptlabel)
        (find-max-min-points all-points :max-floor max-floor :min-ceiling min-ceiling))
    (values max-value max-val-ptnum max-val-ptlabel  
             min-value  min-val-ptnum min-val-ptlabel)
    ;;end let, find-mav-points-list
 ))
;;TEST
;;  (find-max-min-points-list *x-activity-points) 
;;works =0.05786446 4 "X-Aty4" -0.0037560517 2 "X-Aty2"
;;  (find-max-min-points-list   *wup-points)
;;works = 368.434 8  "Wup8-2" 0.006364 9 "Wup9-4"
;;  (find-max-min-points-list   *y-output-points)
;; (find-max-min-points-list   *reset-points) = 0 1 "reset1" 0 1 "reset1"


;;FIND-LARGEST-ART-VALUEINDEX
;;
;;ddd
(defun find-largest-ART-ValueIndex (var &key avoid-reset-indexes-p) ;;was &aux (maxIndex 0) (maxVal (aref *y-output 0)))
  "In ART, RETURNS (values  maxIndex maxVal maxVar ). maxIndex is a dim-list if var has dim-n > 1."
  (let*
      ((varlist (eval var))
       (varlist1 (second varlist))
       (maxIndex 1)
       (maxVal 0) 
       (val-j 0)
       (num-vars)
       (n-dims)
       (subvar-list)
       )

    ;;is it a proper ART var where eg. reset = ("reset" ((RESET1 RESET2 RESET3 RESET4 RESET5)))
    (when varlist1 
      (setf n-dims (list-length (second (eval (caar varlist1)))))

    (cond
     ((> n-dims 1)
      (setf  varlist1 (flatten-count-nested-lists varlist1)))
     (t (setf varlist1 (car varlist1))))

    ;;wdn1-1 or input1
    (setf maxVal (fourth (eval (car varlist1))))
    (setf num-vars (list-length varlist1))                      
      (loop
       for subvar in varlist1
       for j from 1 to num-vars
       do
       (setf  subvar-list (eval subvar)
              dims (second subvar-list)
              val-j (fourth subvar-list))

       (when (null val-j) (setf val-j 0))
       (when (and
            ;;larger than previous largest
            (>   val-j maxVal) ;; (aref *y-output j) maxVal)
            (or
             ;; (null avoid-reset-indexes-p)
             (not avoid-reset-indexes-p)
             ;;reset val for that j = 0
             (and (= n-dims 1)(=  (getsymval 'reset (list j)) 0))
             ))                        ;; (aref *reset j)))
           (setq maxVal val-j
                 maxVar subvar)
           (cond
            ((> (list-length dims) 1)
                 (setf maxIndex dims))
            (t (setf maxIndex (car dims))))
           ;;end when
           )
       ;;end loop, outer when
       ))
      ;;(if (= *print-detail 2) (afout 'out (format nil "maxIndex= ~a ~%" maxIndex)))
      (values  maxIndex maxVal maxVal )
      ;;end let, find-largest-ART-ValueIndex
      ))
;;(find-largest-ART-ValueIndex 'reset :avoid-reset-indexes-p t) = 1 0.0
;;  (find-largest-ART-ValueIndex 'y-output) = 1   139.79415
;; (find-largest-ART-ValueIndex 'wup) = (1 4)  1.001302  WDN1-4



;;FIND-MAX-MIN-POINTS
;;
;;ddd
(defun find-max-min-points (points &key max-floor min-ceiling)
  "In U-ART INPUT a simple 1-dim point list, RETURNS (values  max-value max-val-ptnum max-val-ptlabel min-value  min-val-ptnum min-val-ptlabel).  If max-floor, sets min for the max value= floor. Otherwise min of max-value= -999999,If  min-ceiling otherwise max of min= 999999."
  (let
      ((values)
       (ptnum)
       (ptlable)
       (value)
       (max-value -999999)
       (min-val-ptnum)
       (min-val-ptlabel)
       (min-value 999999)
       (max-val-ptnum)
       (max-val-ptlabel)
       )
    ;;
    (if max-floor (setf max-value max-floor))
    (if min-ceiling (setf min-value min-ceiling))

    (loop
     for point in points
     do
     (setf ptnum(car point) 
           ptlable (third point)
           value (second (second point)))   
     ;;for min-val
     (when (< value min-value)
       (setf min-value value
             min-val-ptnum ptnum
             min-val-ptlabel ptlable))
     ;;for max-val
     (when (> value max-value)
       (setf max-value value
             max-val-ptnum ptnum
             max-val-ptlabel ptlable))
     ;;end loop
     )
    (values  max-value max-val-ptnum max-val-ptlabel  
             min-value  min-val-ptnum min-val-ptlabel)
    ;;end let, find-max-min-points
    ))
;;TEST
;;  (find-max-min-points *INPUT-POINTS)
;; works= 1.04512 4 "Input4" -0.067839995 2 "Input2"
 



;;SORT-ART-SYMS-BY-DIM
;;
;;ddd
(defun sort-art-syms-by-dim (root dim-n &key return-nth-list)
  "In U-ART. Sorts syms list of (eval root) by one dim (eg dim 2 of  3 or 6 dims in dimlist).
 RETURNS (values sorted-lists return-syms). dim-n starts with 1"
  (let
      ((symval-list (eval root))
       (root-str (car symval-list))
       (symlist (second symval-list))
       (rest-list (cddr symval-list))
       (sym-dim-list)
       (sym-dim-lists)
       (sorted-symlist)
       (sorted-symval-list)
       (sorted-sym-dims-lists)
       (nth-list)
       (num-lists)
       (return-list)
       )
    ;;SSSS START HERE
    ;;make a big sym-dims-list so can sort by it
    (loop
     for sym in symlist
     do
     (let*
         ((symlist1 (eval sym))
          (dimlist (second symlist))
          (dim (nth (- dim-n 1) simlist))
          )
       (setf sym-dim-list (list dim sym)
             sym-dims-list (append sym-dims-list (list sym-dim-list)))
       ))

    (setf sorted-sym-dims-lists (NEW?? GROUP-BY-NTH sym-dims-list 0))
    
    (setf sorted-symval-list (append (list root-str sorted-sym-dims-lists) rest-list))

   (when return-nth-list
      (setf return-list (elt sorted-symlist return-nth-list)))

    (values sorted-symval-list n return-list)
    ;;end let, sort-art-syms-by-dim
    ))



;;SORT-ART-SYMS-BY-N
;;
;;ddd
(defun sort-art-syms-by-n (root &key n-lists n-items-per-list return-nth-list)
  "In U-ART.  RETURNS (values resorted-symvals-list n-nested-lists nth-list). Any degree of nesting ok. Sorts EITHER BY n-lists OR n-items-per-list. If both specified, sorts by n-lists with n-items-per-list and puts rest items in rest-list. If left over items in any sorting, puts items in rest-list. If return-nth-list, returns it at values end."
  (let*
      ((symval-list (eval root))
       (root-str (car symval-list))
       (symlist (second symval-list))
       (rest-list (cddr symval-list))
       (sorted-symlist)
       (sorted-symval-list)
       (nth-list)
       (num-lists)
       (return-list)
       )
    (multiple-value-setq (sorted-symlist num-lists)
        (resort-nested-lists-by-n symlist :n-lists  n-lists :n-items-per-list n-items-per-list))

    (setf sorted-symval-list (append (list root-str sorted-symlist) rest-list))

   (when return-nth-list
      (setf return-list (elt sorted-symlist return-nth-list)))

    (values sorted-symval-list num-lists return-list)
    ;;end let, sort-art-syms-by-n
    ))
;;TEST
;; (sort-art-syms-by-n 'x :n-lists 3 :return-nth-list 2)
;; WORKS= ("X" ((X1-1-1 X1-1-2 X1-1-3 X1-2-1 X1-2-2 X1-2-3 X1-3-1 X1-3-2 X1-3-3 X2-1-1 X2-1-2 X2-1-3 X2-2-1 X2-2-2 X2-2-3 X2-3-1 X2-3-2 X2-3-3 X3-1-1 X3-1-2 X3-1-3 X3-2-1 X3-2-2 X3-2-3 X3-3-1 X3-3-2 X3-3-3) (X4-1-1 X4-1-2 X4-1-3 X4-2-1 X4-2-2 X4-2-3 X4-3-1 X4-3-2 X4-3-3 X5-1-1 X5-1-2 X5-1-3 X5-2-1 X5-2-2 X5-2-3 X5-3-1 X5-3-2 X5-3-3 X6-1-1 X6-1-2 X6-1-3 X6-2-1 X6-2-2 X6-2-3 X6-3-1 X6-3-2 X6-3-3) (X7-1-1 X7-1-2 X7-1-3 X7-2-1 X7-2-2 X7-2-3 X7-3-1 X7-3-2 X7-3-3 X8-1-1 X8-1-2 X8-1-3 X8-2-1 X8-2-2 X8-2-3 X8-3-1 X8-3-2 X8-3-3 X9-1-1 X9-1-2 X9-1-3 X9-2-1 X9-2-2 X9-2-3 X9-3-1 X9-3-2 X9-3-3)))  4  NIL

    



   
;;SORT-ART-LIST-INTO-NESTED-LISTS
;; Eg flat-points-list = ((1 (40 0.070434004) "Wup1-1" (1 1)) (1 (80 0.06954) "Wup1-2" (1 2)) (1 (120 0.026330002) "Wup1-3" (1 3)) (1 (160 0.038548) "Wup1-4" (1 4)) (1 (200 0.112005) "Wup1-5" (1 5)) ...
;;
;;ddd
(defun sort-art-list-into-nested-lists  (flat-points-list  ;;not needed items-per-list 
                                                           &key (sortdim-n 1) (x-pix0 40)  (x-pix-incr 40)
                                                           preitems   postitems
                                                           (pre-add-dim-n-p t)  double-quote-nested-item-p)
  "In U-lists, Sorts flat-points-list into 2-dim nested lists.  Uses the ART dim sortdim-n (usually 1 or 2) sortdim-n puts that dim in the OUTER-MOST nested list.. Appends preitems to beginning of each dimlist, postitems to end of each dimlist. pre-add-dim-n-p adds dim-n at end of preitems. This designed for ART flat-point-lists, but may be adapted for some other uses. double-quote-nested-item-p only relates to postitems. RETURNS nested-lists of dimlists, [dimlist eg. (:DIMLIST 1 ((1 (40 0.070434004) \"Wup1-1\" (1 1)) (2 (80 0.06954) \"Wup1-2\" (1 2)) ...  ]. "
  (let*
      ((nested-lists)
       (new-dimlist-p)
       (dimlist)
       (dimlist-n 0)
       (new-point-list)
       (n-items (list-length flat-points-list))
       (n-lists 0)
       (value)
       (nth-dimlist-point 0)
       (length-last-dimlist 0)
       (temp-nested-lists)
       (length-sublist)
       (x-pix)
       (F-list (fourth (car flat-points-list)))
       (n-dims)
       ) 
    ;;prevent errors
    (when (listp F-list)
      (when (< (list-length F-list) sortdim-n)
        (setf  sortdim-n 1)))

    ;;get info from flat-points-list
    (loop
     for point-list in flat-points-list
     do
     ;;eg (1 (40 0.8836) "Wdn1-1" (1 1))
     (multiple-value-bind (dim1 sublist label dims  rest)
         (values-list point-list)
       (setf dim-n (nth (- sortdim-n 1) dims)
             value (second sublist))
       ;;find relevant dimlist in nested-list (if it exists, if not a new dimlist)
       (setf dimlist 
             (get-key-value-in-nested-lists (list (list dim-n 1)) nested-lists
                                            :return-list-p T))

       ;;(afout 'out (format nil "LOOP point-list=~A~%  dim-n=~A    ~%dimlist=~A" point-list dim-n dimlist))

       ;;If new dimlist, find pix values and new-list-p value
       (cond
        ((null dimlist)
         ;;(setf new-dimlist-p T)

         ;;start new x-pix numbering for new graph
            (setf x-pix x-pix0)

         ;;set nth-dimlist-point and new-point-list
         (setf  nth-dimlist-point 1
                sublist (list x-pix (second sublist)))
         (if rest
             (setf  new-point-list (list 1 sublist label dims  rest))
           (setf  new-point-list (list 1 sublist label dims)))

         ;;start new dimlist
         ;;add preitems to new dimlist?
         (when preitems
           (if pre-add-dim-n-p
               (setf dimlist (append  preitems (list dim-n)(list (list new-point-list))))
             (setf dimlist (append preitems (list new-point-list)))))
    
         ;;append nested list with new dimlist (put partial dimlists in it and find later as find new points to add to the dimlist);  the nested-list should be in order dimlist 1, 2, etc.
         (setf nested-lists (append nested-lists (list dimlist)))
         ;;end dim-n 1 clause
         )
        ;;previous dimlist of that dim exists (not first item in the relevant dimlist)
        (dimlist
         
         ;;find last-point-list, nth-dimlist-point, x-pix 
         (setf last-point-list  (car (last (car (last dimlist))))
               nth-dimlist-point (+ (car last-point-list) 1)
               x-pix (+ (car (second last-point-list)) x-pix-incr))

         ;;make the new point-list
         ;;eg (1 (40 0.8836) "Wdn1-1" (1 1))
         ;;(multiple-value-bind (dim1 sublist label dims  rest)
         (cond 
          (rest
           (setf new-point-list
                 (list nth-dimlist-point (list x-pix value) label dims rest)))
          (t 
           (setf new-point-list
                 (list nth-dimlist-point (list x-pix value) label dims))))

         ;;yyyy
         ;;append the dimlist with new-point-list
         (setf dimlist (append-nth-nested-list  new-point-list :last  dimlist))

         ;;replace the old dimlist with modified one
         (setf nested-lists (replace-keylist dim-n nested-lists dimlist :key-n 1))
         ;;(afout 'out (format nil "END dimlist clause~% dimlist=~A dim-n=~A~%nested-lists=~A "dimlist dim-n nested-lists))
         ;;end dimlist clause
         )
        ;;should not be a case where either dimlist exists or it is a new one
        (t nil))
       
       ;;AT END ADD postitems to ALL dimlists
       (when postitems
         (loop
          for dimlist in nested-lists
          do
          (if double-quote-nested-item-p
              (setf dimlist (append-double-quoted-sublist (list postitems)))
            (setf dimlist (append dimlist (list postitems))
                  temp-nested-lists (append temp-nested-lists (list dimlist))))
          ;;end loop
          )
         (setf nested-lists temp-nested-lists)
         ;;end when
         )
       ;;reset dimlist
       (setf dimlist nil)

       ;;end mvb,loop
       ))
 
    nested-lists
    ;;end let, sort-list-into-nested-lists
    )) 

;;TEST
;;FOR ART FORMAT TO make-graph-line
;;SORT BY DIM 1
;; ;;   (sort-art-list-into-nested-lists  '((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (1 2))(1 (40 50) WUP2-1 (2  1)) (2 (80  20) WUP2-2 (2 2)))  :pre-add-dim-n-p T :preitems '(:dimlist)  :double-quote-nested-item-p T :sortdim-n 1 )
;;works= ((:DIMLIST 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (1 2)))) (:DIMLIST 2 ((1 (40 50) WUP2-1 (2 1)) (2 (80 20) WUP2-2 (2 2)))))
;;   (sort-art-list-into-nested-lists  '((1 (40 0.070434004) "Wup1-1" (1 1)) (1 (80 0.06954) "Wup1-2" (1 2)) (1 (120 0.026330002) "Wup1-3" (1 3)) (1 (160 0.038548) "Wup1-4" (1 4)) (1 (200 0.112005) "Wup1-5" (1 5)) (2 (240 0.08712201) "Wup2-1" (2 1)) (2 (280 0.0074070008) "Wup2-2" (2 2)) (2 (320 0.082205005) "Wup2-3" (2 3)) (2 (360 0.017092) "Wup2-4" (2 4)) (2 (400 0.063878) "Wup2-5" (2 5)) (3 (440 0.100085005) "Wup3-1" (3 1)) (3 (480 0.009195) "Wup3-2" (3 2)) (3 (520 0.13808) "Wup3-3" (3 3)) (3 (560 0.096807) "Wup3-4" (3 4)) (3 (600 0.08280101) "Wup3-5" (3 5)) (4 (640 0.032587998) "Wup4-1" (4 1)) (4 (680 0.076096006) "Wup4-2" (4 2)) (4 (720 0.022009) "Wup4-3" (4 3)) (4 (760 0.097701006) "Wup4-4" (4 4)) (4 (800 0.05166) "Wup4-5" (4 5)) (5 (840 0.107535005) "Wup5-1" (5 1)) (5 (880 0.009791001) "Wup5-2" (5 2)) (5 (920 0.057769) "Wup5-3" (5 3)) (5 (960 0.046295997) "Wup5-4" (5 4)) (5 (1000 0.056875) "Wup5-5" (5 5)) (6 (1040 0.046445) "Wup6-1" (6 1)) (6 (1080 0.07848) "Wup6-2" (6 2)) (6 (1120 0.024542002) "Wup6-3" (6 3)) (6 (1160 0.048978) "Wup6-4" (6 4)) (6 (1200 0.104704) "Wup6-5" (6 5)) (7 (1240 0.023946) "Wup7-1" (7 1)) (7 (1280 0.11111101) "Wup7-2" (7 2)) (7 (1320 0.07505301) "Wup7-3" (7 3)) (7 (1360 0.011728) "Wup7-4" (7 4)) (7 (1400 0.022009) "Wup7-5" (7 5)) (8 (1440 0.0033840002) "Wup8-1" (8 1)) (8 (1480 0.019178002) "Wup8-2" (8 2)) (8 (1520 0.12347801) "Wup8-3" (8 3)) (8 (1560 0.012324) "Wup8-4" (8 4)) (8 (1600 0.047934998) "Wup8-5" (8 5)) (9 (1640 0.026181002) "Wup9-1" (9 1)) (9 (1680 0.046147) "Wup9-2" (9 2)) (9 (1720 0.126458) "Wup9-3" (9 3)) (9 (1760 0.080417) "Wup9-4" (9 4)) (9 (1800 0.13361001) "Wup9-5" (9 5)))   :pre-add-dim-n-p T :preitems '(:dimlist)  :double-quote-nested-item-p T :sortdim-n 1 )
;;WORKS= ((:DIMLIST 1 ((1 (40 0.070434004) "Wup1-1" (1 1)) (2 (80 0.06954) "Wup1-2" (1 2)) (3 (120 0.026330002) "Wup1-3" (1 3)) (4 (160 0.038548) "Wup1-4" (1 4)) (5 (200 0.112005) "Wup1-5" (1 5)))) (:DIMLIST 2 ((1 (40 0.08712201) "Wup2-1" (2 1)) (2 (80 0.0074070008) "Wup2-2" (2 2)) (3 (120 0.082205005) "Wup2-3" (2 3)) (4 (160 0.017092) "Wup2-4" (2 4)) (5 (200 0.063878) "Wup2-5" (2 5)))) (:DIMLIST 3 ((1 (40 0.100085005) "Wup3-1" (3 1)) (2 (80 0.009195) "Wup3-2" (3 2)) (3 (120 0.13808) "Wup3-3" (3 3)) (4 (160 0.096807) "Wup3-4" (3 4)) (5 (200 0.08280101) "Wup3-5" (3 5)))) (:DIMLIST 4 ((1 (40 0.032587998) "Wup4-1" (4 1)) (2 (80 0.076096006) "Wup4-2" (4 2)) (3 (120 0.022009) "Wup4-3" (4 3)) (4 (160 0.097701006) "Wup4-4" (4 4)) (5 (200 0.05166) "Wup4-5" (4 5)))) (:DIMLIST 5 ((1 (40 0.107535005) "Wup5-1" (5 1)) (2 (80 0.009791001) "Wup5-2" (5 2)) (3 (120 0.057769) "Wup5-3" (5 3)) (4 (160 0.046295997) "Wup5-4" (5 4)) (5 (200 0.056875) "Wup5-5" (5 5)))) (:DIMLIST 6 ((1 (40 0.046445) "Wup6-1" (6 1)) (2 (80 0.07848) "Wup6-2" (6 2)) (3 (120 0.024542002) "Wup6-3" (6 3)) (4 (160 0.048978) "Wup6-4" (6 4)) (5 (200 0.104704) "Wup6-5" (6 5)))) (:DIMLIST 7 ((1 (40 0.023946) "Wup7-1" (7 1)) (2 (80 0.11111101) "Wup7-2" (7 2)) (3 (120 0.07505301) "Wup7-3" (7 3)) (4 (160 0.011728) "Wup7-4" (7 4)) (5 (200 0.022009) "Wup7-5" (7 5)))) (:DIMLIST 8 ((1 (40 0.0033840002) "Wup8-1" (8 1)) (2 (80 0.019178002) "Wup8-2" (8 2)) (3 (120 0.12347801) "Wup8-3" (8 3)) (4 (160 0.012324) "Wup8-4" (8 4)) (5 (200 0.047934998) "Wup8-5" (8 5)))) (:DIMLIST 9 ((1 (40 0.026181002) "Wup9-1" (9 1)) (2 (80 0.046147) "Wup9-2" (9 2)) (3 (120 0.126458) "Wup9-3" (9 3)) (4 (160 0.080417) "Wup9-4" (9 4)) (5 (200 0.13361001) "Wup9-5" (9 5)))))

;;
;;SORT BY DIM 2
;; (sort-art-list-into-nested-lists  '((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1))(1 (40 50) WUP1-2 (1 2)) (2 (80  20) WUP2-2 (2 2)))  :pre-add-dim-n-p T :preitems '(:dimlist)  :double-quote-nested-item-p T :x-pix0 40 :sortdim-n 2 )
;;works=  ((:DIMLIST 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 50) WUP1-2 (1 2)))) (:DIMLIST 2 ((1 (40 200) WUP1-2 (2 1)) (2 (80 20) WUP2-2 (2 2)))))

;;(sort-art-list-into-nested-lists  '((1 (40 0.070434004) "Wup1-1" (1 1)) (1 (80 0.06954) "Wup1-2" (1 2)) (1 (120 0.026330002) "Wup1-3" (1 3)) (1 (160 0.038548) "Wup1-4" (1 4)) (1 (200 0.112005) "Wup1-5" (1 5)) (2 (240 0.08712201) "Wup2-1" (2 1)) (2 (280 0.0074070008) "Wup2-2" (2 2)) (2 (320 0.082205005) "Wup2-3" (2 3)) (2 (360 0.017092) "Wup2-4" (2 4)) (2 (400 0.063878) "Wup2-5" (2 5)) (3 (440 0.100085005) "Wup3-1" (3 1)) (3 (480 0.009195) "Wup3-2" (3 2)) (3 (520 0.13808) "Wup3-3" (3 3)) (3 (560 0.096807) "Wup3-4" (3 4)) (3 (600 0.08280101) "Wup3-5" (3 5)) (4 (640 0.032587998) "Wup4-1" (4 1)) (4 (680 0.076096006) "Wup4-2" (4 2)) (4 (720 0.022009) "Wup4-3" (4 3)) (4 (760 0.097701006) "Wup4-4" (4 4)) (4 (800 0.05166) "Wup4-5" (4 5)) (5 (840 0.107535005) "Wup5-1" (5 1)) (5 (880 0.009791001) "Wup5-2" (5 2)) (5 (920 0.057769) "Wup5-3" (5 3)) (5 (960 0.046295997) "Wup5-4" (5 4)) (5 (1000 0.056875) "Wup5-5" (5 5)) (6 (1040 0.046445) "Wup6-1" (6 1)) (6 (1080 0.07848) "Wup6-2" (6 2)) (6 (1120 0.024542002) "Wup6-3" (6 3)) (6 (1160 0.048978) "Wup6-4" (6 4)) (6 (1200 0.104704) "Wup6-5" (6 5)) (7 (1240 0.023946) "Wup7-1" (7 1)) (7 (1280 0.11111101) "Wup7-2" (7 2)) (7 (1320 0.07505301) "Wup7-3" (7 3)) (7 (1360 0.011728) "Wup7-4" (7 4)) (7 (1400 0.022009) "Wup7-5" (7 5)) (8 (1440 0.0033840002) "Wup8-1" (8 1)) (8 (1480 0.019178002) "Wup8-2" (8 2)) (8 (1520 0.12347801) "Wup8-3" (8 3)) (8 (1560 0.012324) "Wup8-4" (8 4)) (8 (1600 0.047934998) "Wup8-5" (8 5)) (9 (1640 0.026181002) "Wup9-1" (9 1)) (9 (1680 0.046147) "Wup9-2" (9 2)) (9 (1720 0.126458) "Wup9-3" (9 3)) (9 (1760 0.080417) "Wup9-4" (9 4)) (9 (1800 0.13361001) "Wup9-5" (9 5)))   :pre-add-dim-n-p T :preitems '(:dimlist) :sortdim-n 2 :double-quote-nested-item-p T  :sortdim-n 2)
;;WORKS=  ((:DIMLIST 1 ((1 (40 0.070434004) "Wup1-1" (1 1)) (2 (80 0.08712201) "Wup2-1" (2 1)) (3 (120 0.100085005) "Wup3-1" (3 1)) (4 (160 0.032587998) "Wup4-1" (4 1)) (5 (200 0.107535005) "Wup5-1" (5 1)) (6 (240 0.046445) "Wup6-1" (6 1)) (7 (280 0.023946) "Wup7-1" (7 1)) (8 (320 0.0033840002) "Wup8-1" (8 1)) (9 (360 0.026181002) "Wup9-1" (9 1)))) (:DIMLIST 2 ((1 (40 0.06954) "Wup1-2" (1 2)) (2 (80 0.0074070008) "Wup2-2" (2 2)) (3 (120 0.009195) "Wup3-2" (3 2)) (4 (160 0.076096006) "Wup4-2" (4 2)) (5 (200 0.009791001) "Wup5-2" (5 2)) (6 (240 0.07848) "Wup6-2" (6 2)) (7 (280 0.11111101) "Wup7-2" (7 2)) (8 (320 0.019178002) "Wup8-2" (8 2)) (9 (360 0.046147) "Wup9-2" (9 2)))) (:DIMLIST 3 ((1 (40 0.026330002) "Wup1-3" (1 3)) (2 (80 0.082205005) "Wup2-3" (2 3)) (3 (120 0.13808) "Wup3-3" (3 3)) (4 (160 0.022009) "Wup4-3" (4 3)) (5 (200 0.057769) "Wup5-3" (5 3)) (6 (240 0.024542002) "Wup6-3" (6 3)) (7 (280 0.07505301) "Wup7-3" (7 3)) (8 (320 0.12347801) "Wup8-3" (8 3)) (9 (360 0.126458) "Wup9-3" (9 3)))) (:DIMLIST 4 ((1 (40 0.038548) "Wup1-4" (1 4)) (2 (80 0.017092) "Wup2-4" (2 4)) (3 (120 0.096807) "Wup3-4" (3 4)) (4 (160 0.097701006) "Wup4-4" (4 4)) (5 (200 0.046295997) "Wup5-4" (5 4)) (6 (240 0.048978) "Wup6-4" (6 4)) (7 (280 0.011728) "Wup7-4" (7 4)) (8 (320 0.012324) "Wup8-4" (8 4)) (9 (360 0.080417) "Wup9-4" (9 4)))) (:DIMLIST 5 ((1 (40 0.112005) "Wup1-5" (1 5)) (2 (80 0.063878) "Wup2-5" (2 5)) (3 (120 0.08280101) "Wup3-5" (3 5)) (4 (160 0.05166) "Wup4-5" (4 5)) (5 (200 0.056875) "Wup5-5" (5 5)) (6 (240 0.104704) "Wup6-5" (6 5)) (7 (280 0.022009) "Wup7-5" (7 5)) (8 (320 0.047934998) "Wup8-5" (8 5)) (9 (360 0.13361001) "Wup9-5" (9 5)))))

;;FOR SORTING 3+ dimension lists, where the field and module dimensions are the SAME.
;;
;;  (sort-art-list-into-nested-lists  '((1 (40 110) WUP1-1-8-11-1-2  (1 1 8 11 1 2)) (2 (80 200) WUP1-2-8-11-1-2  (1 2 8 11 1 2))(1 (40 50) WUP2-1-8-11-1-2  (2  1 8 11 1 2)) (2 (80  20) WUP2-2-8-11-1-2  (2 2 8 11 1 2)))  :pre-add-dim-n-p T :preitems '(:dimlist)  :double-quote-nested-item-p T :sortdim-n 1 )
;; RESULTS= ((:DIMLIST 1 ((1 (40 110) WUP1-1-8-11-1-2 (1 1 8 11 1 2)) (2 (80 200) WUP1-2-8-11-1-2 (1 2 8 11 1 2)))) (:DIMLIST 2 ((1 (40 50) WUP2-1-8-11-1-2 (2 1 8 11 1 2)) (2 (80 20) WUP2-2-8-11-1-2 (2 2 8 11 1 2)))))




#|
CL-USER 65 > (truncate (/ 9  4 )) = 2   1/4
CL-USER 66 > (truncate (/ 9 (* 4 1.0))) = 2  0.25
CL-USER 68 > (ceiling (/ 9  4)) = 3  -3/4
|#



;;MAKE-ART-CYCLE-DATA-TEXT
;;
;;ddd
(defun make-art-cycle-data-text (vars-list &key (cycle-n  learningCycleCounter) formula-list)
  "In U-ART, makes text listing variables and values in vars-list. Each var evals to a list of sublists or subvars. Eg (\"Wup\" ((WUP1-1 WUP1-2..)(WUP2-1 ...)))"
  (let
      ((var-n 0)
       (main-var-list)
       (var-text)
       (subvar-text "")
       (var-text "")
       (cycle-text 
        (format nil ">>> FOR CYCLE-N= ~A, VARIABLES= ~A" cycle-n vars-list))
       (formula "")
       (subvar-list)
       (outer-dim-n 0)
       (inner-dim-n 0)
       (line 
"------------------------------------------------------------------------------------------------------------------------------------------------------------")    
       
   
    (cycle-line " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> END OF CYCLE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
    )
    ;;default-formula-list
    (unless formula-list
      (setf formula-list
            '((input "INPUT")
              (p "pi = (+ ui  SUMj (* (g yj) wdnji))  ;  ui = net v-activity;; g(yj) = d  ;if Tj = maxi Tj  & the jth F2 node not reset ;;; g(yj) = 0  ;otherwise")
              (q "qi = (/ pi (+ e   L2norm p));;L2norm = SUMi (* var var)")
              (u "ui = (/ vi (+ e  L2norm v)) ;;L2norm = SUMi (* var var)")
              (r  "ri = (-  (/  ui   max1u)  (/ pi  max2p))")
              (v-activity "vi = (+ f(xi)  (* b f(qi)))  = (+ x (* b x))  OR  0; b=  0.2; WHERE f(x) = 0  if (<= x theta); f(x) = x  if (>= x theta)  ;theta = 0.3;")
              (w  "wi = (+ Ii (* a ui)) ;a=0.5 ")
              (wup "wupij =  SUMi  (* learning-rate  d  (my-floor (- pi  wupij) -0.2) " )
              (wdn "wdnji =  SUMi  (* learning-rate  d  (my-floor (- pi  wdnji) -0.2) ")
              (T "Tj = SUMi (* pi zij)  ;;(j = M + 1...N), M= max i number; Tj = max{Tj:  j= M+1...N}  F2 MAKES A CHOICE")
              (y-output "yi = SUMj (* pi wupij) .  In CompetitiveF2, if y-max-output > 0.25, resets all other y-outputs to 0.0")
              )))

    ;;eg for (input v-activity ...)
    (loop
     for main-var in vars-list
     do
     (incf var-n)
     ;;find the right formula
     (setf formula (get-key-value-in-single-nested-list main-var formula-list))
     
     ;;get the specific dim vars
     (setf main-var-list (second (eval main-var)))
     (multiple-value-bind (max-index max-val)
         (find-largest-ART-ValueIndex main-var)
     (setf var-text (format nil "~A~%>> FOR VAR= ~A, MAX-VAL=~A, Max-index= ~A;  VarN=~A,  Cycle-N=~A~% ==>  ~A"  line  main-var max-val max-index var-n  cycle-n   formula))    

     ;;eg for ((wup1-1..)(wup2-1...) ...)
    (loop
     for sublist in main-var-list     
     do
     (when (listp main-var-list)
     (incf outer-dim-n)
     (setf subvar-text (format nil "~A [ "subvar-text))

     ;;eg for (wup1-1 wup 1-2...)
     (loop
      for subvar in sublist
      do  
      (incf inner-dim-n)
     (setf subvar-list (eval subvar))

     (multiple-value-bind (varname dims n value)
         (values-list subvar-list)
       (setf subvar-text (format nil "~A~A~A=~A; "subvar-text varname dims value))
       ;;end mvb, innermost loop
       ))
     (setf subvar-text (format nil "~A]" subvar-text))
     (setf var-text (format nil "~A~%~A"var-text subvar-text)
                      subvar-text "")
     ;;end when,middle loop
     ))
    (setf cycle-text (format nil "~A~%~A" cycle-text var-text ) 
          var-text "")
    ;;end mvb, outer loop
    ))
    (setf cycle-text (format nil "~A~% ~A~%   =====> END CYCLE= ~A" cycle-text  cycle-line cycle-n))
    cycle-text
    ;;end let, make-art-cycle-data-text
    ))
;;TEST
;;  (make-art-cycle-data-text '(input v-activity wup))
;; works= ">>> FOR CYCLE-N= 30, VARIABLES= (INPUT V-ACTIVITY WUP)
#|------------------------------------------------------------------------------------------------------------------------------------------------------------
>> FOR VAR= INPUT, MAX-VAL=0.95456, Max-index= 4;  VarN=1,  Cycle-N=30
 ==>  INPUT
 [ Input(1)=0.046879992; Input(2)=-0.016479999; Input(3)=0.031359993; Input(4)=0.95456; Input(5)=0.93792; Input(6)=0.95264; Input(7)=-0.05792; Input(8)=-0.051199995; Input(9)=6.400049E-4; ] .... ETC
------------------------------------------------------------------------------------------------------------------------------------------------------------
>> FOR VAR= WUP, MAX-VAL=0.23860002, Max-index= (7 3);  VarN=3,  Cycle-N=30
 ==>  wupij =  SUMi SUMj (* learning-rate  d  pi  wupij) 
 [ Wup(1 1)=0.20155; Wup(1 2)=0.12715; Wup(1 3)=0.16225; Wup(1 4)=0.1612; Wup(1 5)=0.23065001; ]
.. ETC
 [ Wup(8 1)=0.12010001; Wup(8 2)=0.101950005; Wup(8 3)=0.119950004; Wup(8 4)=0.1684; Wup(8 5)=0.2245; ]
 [ Wup(9 1)=0.10345; Wup(9 2)=0.22855002; Wup(9 3)=0.22225002; Wup(9 4)=0.2362; Wup(9 5)=0.13645001; ]
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> END OF CYCLE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   =====> END CYCLE= 30"
|#


;;FIND-RESETS
;;
;;ddd 
(defun find-art-above-min  (&key  (art-sym 'reset)  (min-val 0))
  "In U-ART, RETURNS (values min-indexes-list min-values-list). min-indexes-list includes only reset-val indeces, min-values-list includes all vals. Returns NIL if none were reset."
  (let*
      (( min-indexes-list)
       (min-values-list)
       (min-index-list)
       (min-list  (second (eval art-sym))) ;;was reset
       (min-index 0)
       (val)
       (val)
       )
    (loop
     for reset  in  min-list
     do
     (incf min-index)
     (setf val (fourth (eval reset ))) 
     (when (> val 0)
       (setf min-indexes-list (append min-indexes-list (list min-index))))
     ;;append all vals
     (setf min-values-list (append min-values-list (list val)))
     ;;end loop
     )   
    (values min-indexes-list min-values-list)
    ;;end let, find-art-above-min
    ))
;;TEST
;;  (find-art-above-min)
;; works= (1 4)   (2.2419372 0 0 1.2131255 0)



;;MAKE-DIM-SYMBOL
;;
;;ddd
(defun make-dim-symbol (root dimlist &key (separator-str "-") tail-string return-only-str-p)
  "In U-ART, RETURNS (values new-dimsym symdims-str) eg WUPI-3-2TOI-1-3   \"WupI-3-2TOI-1-3\")"
  (let
      ((symdims-str)
       (new-dimsym)
       (dimlist-str (make-dims-string dimlist :separator-str separator-str))
       )
    (cond
     (tail-string
      (setf symdims-str
            (format nil "~A~A~A" root dimlist-str tail-string)))
     (t
      (setf symdims-str
            (format nil "~A~A" root dimlist-str))))

    (unless return-only-str-p
      (setf new-dimsym (my-make-symbol symdims-str)))

    (values new-dimsym symdims-str)
    ;;end let, make-symdims-string
    ))
;;TEST
;;  (make-dim-symbol "Wup"   '(i 8 3 to i 9 22))
;; works= WUPI-8-3TOI-9-22   "WupI-8-3TOI-9-22"
;;  (make-dim-symbol "Wup"   '(i 8 3 to i 9 22) :tail-string "tailstring")
;; works= WUPI-8-3TOI-9-22TAILSTRING    "WupI-8-3TOI-9-22tailstring"



;;MAKE-DIMS-STRING
;;
;;ddd
(defun make-dims-string (dimlist &key (separator-str "-")(key-list '(to)))
  "In U-ART, RETURNS a dims-string (eg. \"wup1-2-3To4-5-6\") from a dims-list eg. (1 2 3 :to 4 5 6) Otherwise inserts just separator-str."
  (let
      ((dims-string "")
       (no-separator-p)
       )
    (multiple-value-bind (n-dims n-items keys)
        (dimlist-length dimlist)
      (loop
       for item in dimlist
       for n from 1 to n-items
       do
       (cond
        ;;for key items
       ((member item key-list :test 'equal)
         (setf dims-string (format nil "~A~A" dims-string item)
               no-separator-p T))
        ;;for first item
        ((= n 1)
         (setf dims-string (format nil "~A" item)))
        ;;if following a key
        (no-separator-p
         (setf dims-string (format nil "~A~A" dims-string  item)
               no-separator-p nil))
        (t 
         (setf dims-string (format nil "~A~A~A" dims-string separator-str item)
               no-separator-p nil)))

       ;;end loop
       )
      dims-string
      ;;end let, mvb, make-art-dims-string
      )))
;;TEST
;; (make-dims-string '(11)) = "11"
;; (make-dims-string '(12 7 33)) = "12-7-33"
;;  (make-dims-string '(5 78 3 to 4 9 22)) =  "5-78-3TO4-9-22"
;; (make-dims-string '(i 8 3 to i 9 22)) = "I-8-3TOI-9-22"



;;DIMLIST-LENGTH
;;
;;ddd
(defun dimlist-length (dimlist)
  "In U-ART, RETURNS (values n-integers n-items keys) for a dimlist (eg. (1 2 3 To 4 5 6)). keys is a list of  n-subitems key n-subitems, etc."
  (let
      ((n-ints 0)
       (n (list-length dimlist))
       (n-subs 0)
       (keys)
       )
    (dolist (item dimlist)
      (cond
       ((integerp item)
        (incf n-ints)
        (incf n-subs))
       (t (setf keys (append keys (list n-subs item))
                n-subs 0)))
      )
    (setf keys (append keys (list n-subs)))
    (values n-ints n keys)
    ;;end let, dimlist-length
    ))
;;TEST
;;  (dimlist-length '(1 2 3 :TO 4 5 6)) = 6 7 (3 :TO 3)







;;xxx
;;================ FOR CREATING NEW SYMBOLS ===============
;;
;;MOVE SOME or ALL TO U-TSTRING??


;;MAKE-NEW-DIMSYMBOL-TYPES
;;was make-new-dim-symbol-types
;;
;;  THESE 3 MAKE FUNCTIONS ARE ONLY USED IN ART--SO CAN CHANGE
;;   ALSO, U-ART HAS RELATED SET, GET FUNCTIONS TO OPERATE 
;;   ON THE SYMBOLS AND SYMVALS LISTS CREATED
;;
;;ddd
(defun make-new-dimsymbol-types (symbol-spec-lists
                                    &key make-sublists-for-each-dim-p
                                    (set-global-vars-p T)  (return-flat-lists-p T)
                                    (path-indicator-string "To"));; nested-inner-list-size)
 "In U-ART.  OLD-REVISE: Returns new symbols of root, begin-str,dim-element,end-str for each value of dim-element from begin-n to n-dim-elements. RETURNS (values new-symbol-type-list  new-symbols-type-list-of-lists   new-symbol-type-spec-list-of-lists  new-root-list   new-symbol-type-symbol-string-list-of-lists  all-new-sym-names-flat-list  all-new-symbols-flat-list all-new-symdim-lists-flat-list).  INPUTS:  For SYMBOL-SPEC-LISTS, EACH symbol-spec-list= (ROOT all-dims-spec-list). ALL-DIMS-SPEC-LIST= (sublist1 sublist2 etc).  Each dim sublist =  (n-elements begin-n/or/cur-dim-n  dim-incr  begin-str end-str. Eg. (\"root\" '((4 1 1 \"C\" \"F\")(3 1 1 \"C\" \"F\"))).
KEYS: If set-global-vars-p, sets global * versions of all return vars.  If return-flat-lists-p, then returns unnested lists instead of nested ones. NOTE: Nested-lists are nested by all Dim1 items together.  Use function resort-nested-lists for 2-level/2-dim nested lists with all Dim2 items in same list."

 (when set-global-vars-p
  (setf   *new-symbol-type-nested-list nil)  ;;*new-symbols-type-list-of-lists  nil
           ;;*new-symbol-type-spec-list-of-lists nil  *new-root-list nil
           ;;*new-symbol-type-symbol-string-list-of-lists nil ))
  (let*    
      ((n-symbol-types  (length symbol-spec-lists))
       ;;outputs
       (root-sym)
       (new-symbols-list)
       (new-symbol-type)
       (new-symbol-type-list)
       (new-sym-names-flat-list)  ;;new
       (new-symbols-flat-list) ;;new
       (new-symdim-lists-flat-list) ;;new
       (all-new-sym-names-flat-list)  ;;new
       (all-new-symbols-flat-list) ;;new
       (all-new-symdim-lists-flat-list) ;;new
       (all-dims-spec-list) ;;new
       (new-seq-nested-lists)
       (new-symbol-nested-lists)
       (new-dim-list-nested-lists)
       (new-symbol-type-spec-list)
       (new-symbol-type-symbol-string-list)
       (new-symbols-type-list-of-lists)
       (new-symbol-type-spec-list-of-lists)
       (new-symbol-type-symbol-string-list-of-lists)       
       (new-root-list)
       (dimspecs-n)
       (inner-list)
       (outer-list)
       )
    ;;(afout 'out (format nil "2 symbol-spec-lists= ~A~%" symbol-spec-lists))
    (loop
     for symbol-spec-list in symbol-spec-lists
     ;;for dim-spec-list in symbol-spec-lists
     ;;for symbol-n from 1 to  n-symbol-types
     ;;    with n-symbols = (car dim-spec-list)
     do
     (setf root (car symbol-spec-list)
           all-dims-spec-list (second symbol-spec-list)
           root-sym (my-make-symbol root)
           dimspecs-n 0)
     ;;(afout 'out (format nil "dim-spec-list= ~A~%" dim-spec-list))
     ;;eg SingleDim (,nInputs ("Input" ((1 1)) "" ""))
     ;;eg DoubleDim (,nOutputs ("Wup" ((1 1)(1 1)) "" ""))

     ;;added 2015-09
       ;;all-dims-spec-list=  ((3 1 1"")(1 3 1  "-")(1 1 1 "-"  ) (3  1 1  "To" )(1 1 1   "-")(1 2 1 "-"))
       ;;dimspecs= (3 1 1"")  or (1 3 1  "-") or  (3  1 1  "To" )

      ;;If nest-indicator-string, find nested-inner-list-size
     (when nest-indicator-string
       (dolist (dimspecs all-dims-spec-list)
         (incf dimspecs-n) ;;first = 1
         (cond 
          ;;if  "To" is begin-str, uses N of same dimspecs
          ((string-equal (fourth dimspecs) nest-indicator-string)
           (setf nested-inner-list-size (car dimspecs)))
          ;;if  "To" is end-str, uses N of NEXT dimspecs
          ((string-equal (fifth dimspecs) nest-indicator-string)
           (setf nested-inner-list-size (car (nth dimspecs-n dimspecs))))   ;;next list      
        (t  NIL ))  ;;was (setf nested-inner-list-size nil)))
       ;;end  dolist,when
       ))

     ;;SSS FIX new-seq-nested-lists RETURNING NIL
     ;;FIND THE NEW SYMBOLS, ETC
     (multiple-value-setq (new-seq-nested-lists  new-symbol-nested-lists new-dim-list-nested-lists  new-sym-names-flat-list new-symbols-flat-list new-symdim-lists-flat-list)
         (make-multi-dim-symbol-list  root  all-dims-spec-list
                                        :return-flat-lists-p  return-flat-lists-p))
        ;;old (make-new-dim-symbols  n-symbols (second dim-spec-list)
          ;;                        :make-sublists-for-each-dim-p make-sublists-for-each-dim-p))

     (setf  new-root-list (append new-root-list (list root))
           new-symbol-type-list (append new-symbol-type-list 
                                         (list root-sym))            
           new-symbols-type-list-of-lists (append new-symbols-type-list-of-lists
                                                  (list new-symbol-nested-lists))
           new-symbol-type-spec-list-of-lists (append new-symbol-type-spec-list-of-lists
                                                      (list new-dim-list-nested-lists))
           new-symbol-type-symbol-string-list-of-lists 
                (append new-symbol-type-symbol-string-list-of-lists 
                      (list new-seq-nested-lists))
           all-new-sym-names-flat-list (append all-new-sym-names-flat-list 
                                           (list new-sym-names-flat-list))
           all-new-symbols-flat-list  (append all-new-symbols-flat-list
                                            (list new-symbols-flat-list))
           all-new-symdim-lists-flat-list (append all-new-symdim-lists-flat-list
                                            (list new-symdim-lists-flat-list)))


   ;;sss
;; (values new-symbol-type-list  Xnew-symbols-type-list-of-lists             new-symbol-type-spec-list-of-lists  new-root-list             Xnew-symbol-type-symbol-string-list-of-lists  all-new-sym-names-list)       

     ;;added 2015-09 may be elsewhere also??
     ;;make a flat list if list is eg. ((WUP1-3-2TO1-1-3) (WUP1-3-2TO2-1-3) (WUP2-3-2TO1-1-3) (WUP2-3-2TO2-1-3) (WUP3-3-2TO1-1-3) (WUP3-3-2TO2-1-3))
#|     (dolist (item  new-symbol-nested-lists)
       (cond 
        ((listp item)
         (setf new-symbol-flat-list (append new-symbol-flat-list  item)))
        (t setf  new-symbol-flat-list (append new-symbol-flat-list (list item))))
       ;;end dolist
       )|#
     ;;make a nested list 
     (when  nested-inner-list-size
       (loop
        for item in new-symbols-flat-list
        do
        (loop
         for n from 1 to nested-inner-list-size
         do
         (setf inner-list (append inner-list (list item)))
         ;;end inner-loop
         )
        (setf outer-list (append outer-list (list inner-list)))
        ;;reset inner-list
        (setf inner-list nil)
        ;;end outer loop
        )         
       (setf new-symbol-nested-lists outer-list)
       ;;end when
       )

     ;; SSSS START HERE FIXING WHAT X SET TO
     ;;SET NEW SYMBOLS TO LISTS 
 ;;  causes errors
#|   (cond
     ;;If want to manually control the nested-inner-list-size
      (nested-inner-list-size
       (set (my-make-symbol (format nil "~A-flat" root))   new-symbols-flat-list)
       (set  root-sym  new-symbol-nested-lists))
      (t
       (set  root-sym  new-symbols-flat-list)
       (set (my-make-symbol (format nil "~A-flat" root))  new-symbols-flat-list)))|#

     ;;end BIG OUTER symbol-spec-lists loop
     )
    
    (when set-global-vars-p 
      (setf *new-symbol-type-list new-symbol-type-list
            *new-symbols-type-list-of-lists  new-symbols-type-list-of-lists
            *new-symbol-type-spec-list-of-lists  new-symbol-type-spec-list-of-lists
            *new-root-list new-root-list
            *new-symbol-type-symbol-string-list-of-lists new-symbol-type-symbol-string-list-of-lists
            *all-new-sym-names-flat-list  all-new-sym-names-flat-list
            *all-new-symbols-flat-list all-new-symbols-flat-list
            *all-new-symdim-lists-flat-list all-new-symdim-lists-flat-list))

    (values new-symbol-type-list  new-symbols-type-list-of-lists
            new-symbol-type-spec-list-of-lists  new-root-list
            new-symbol-type-symbol-string-list-of-lists  all-new-sym-names-flat-list 
            all-new-symbols-flat-list all-new-symdim-lists-flat-list)
    ;;end let, make-new-dimsymbol-types
    ))

 )
;;TEST
;;FOR  OLD ART3--------------------------------------------------------------
;; (make-new-dimsymbol-types  `(("Wup" ((3 1 1"")(1 3 1  "-")(1 1 1 "-"  ) (3  1 1  "To" )(1 1 1   "-")(1 2 1 "-")))))
;;new-symbol-type-list= (WUP)
;;new-symbols-type-list-of-lists= (((WUP1-3-1TO1-1-2) (WUP1-3-1TO2-1-2) (WUP1-3-1TO3-1-2) (WUP2-3-1TO1-1-2) (WUP2-3-1TO2-1-2) (WUP2-3-1TO3-1-2) (WUP3-3-1TO1-1-2) (WUP3-3-1TO2-1-2) (WUP3-3-1TO3-1-2)))
;;new-symbol-type-spec-list-of-lists= [note: dims not correct] (((("Wup1-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup1-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup1-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup3-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup3-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup3-3-1To3-1-2" (1 2 1 "-" "")))))
;;new-root-list= ("Wup")
;;new-symbol-type-symbol-string-list-of-lists= ((("Wup1-3-1To1-1-2") ("Wup1-3-1To2-1-2") ("Wup1-3-1To3-1-2") ("Wup2-3-1To1-1-2") ("Wup2-3-1To2-1-2") ("Wup2-3-1To3-1-2") ("Wup3-3-1To1-1-2") ("Wup3-3-1To2-1-2") ("Wup3-3-1To3-1-2")))
;;all-new-sym-names-flat-list= (("Wup1-3-1To1-1-2" "Wup1-3-1To2-1-2" "Wup1-3-1To3-1-2" "Wup2-3-1To1-1-2" "Wup2-3-1To2-1-2" "Wup2-3-1To3-1-2" "Wup3-3-1To1-1-2" "Wup3-3-1To2-1-2" "Wup3-3-1To3-1-2"))
;;all-new-symbols-flat-list= ((WUP1-3-1TO1-1-2 WUP1-3-1TO2-1-2 WUP1-3-1TO3-1-2 WUP2-3-1TO1-1-2 WUP2-3-1TO2-1-2 WUP2-3-1TO3-1-2 WUP3-3-1TO1-1-2 WUP3-3-1TO2-1-2 WUP3-3-1TO3-1-2))
;;all-new-symdim-lists-flat-list= ((("Wup1-3-1To1-1-2" (1 2 1 "-" "")) ("Wup1-3-1To2-1-2" (1 2 1 "-" "")) ("Wup1-3-1To3-1-2" (1 2 1 "-" "")) ("Wup2-3-1To1-1-2" (1 2 1 "-" "")) ("Wup2-3-1To2-1-2" (1 2 1 "-" "")) ("Wup2-3-1To3-1-2" (1 2 1 "-" "")) ("Wup3-3-1To1-1-2" (1 2 1 "-" "")) ("Wup3-3-1To2-1-2" (1 2 1 "-" "")) ("Wup3-3-1To3-1-2" (1 2 1 "-" ""))))
;;ALSO
;;CL-USER 16 > WUP3-3-1TO1-1-2  =  ("Wup" (3 3 1 1 1 2) 1)
;;
;;  (make-new-dimsymbol-types  `(("X" ((3 1 1"")(1 2 1  "-")(1 1 1 "-"  )))))
;;  WORKS=
;; (X)
;; (((X1-2-1) (X2-2-1) (X3-2-1)))
;; (((("X1-2-1" (1 1 1 "-" ""))) (("X2-2-1" (1 1 1 "-" ""))) (("X3-2-1" (1 1 1 "-" "")))))
;; ("X")
;; ((("X1-2-1") ("X2-2-1") ("X3-2-1")))
;; (("X1-2-1" "X2-2-1" "X3-2-1"))
;; ((X1-2-1 X2-2-1 X3-2-1))
;; ((("X1-2-1" (1 1 1 "-" "")) ("X2-2-1" (1 1 1 "-" "")) ("X3-2-1" (1 1 1 "-" ""))))
;;
;; (make-new-dimsymbol-types  `(("INPUT" ((3 1 1"")))))
;; (make-new-dimsymbol-types  '(("X" ((5 1 1 )(3 1 1   "-" )(3 1 1 "-")))))
;;
;;  FROM INIT
;; (make-new-dimsymbol-types '(("Wup" ((5 1 1"")(1 3 1  "-")(1 2 1 "-"  ) (3 1 1  "To" )(1 1 1   "-")(1 3 1 "-")))))




;;MAKE-MULTI-DIM-SYMBOL-LIST
;;was make-multi-dim-sequence-list
;;ddd
#|(defun make-multi-dim-symbol-list (symbol-spec-list &key index-syms '(i j f m) (separator "-")( node-separator "to"))
  "In U-ART"
  ;;EG. symbol-spec-list=    ("X" ((,*n-inputs 1 1 )(3 1 1   "-" )(3 1 1 "-"))) 
  ;; symbol-spec-list=  ("Wup" ((,*n-inputs  1 1"")(1 3 1  "-")(1 2 1 "-"  ) TO (,*n-outputs 1 1  "To" )(1 1 1   "-")(1 3 1 "-")))
  (let*
      ((root-str (car symbol-spec-list))
       (dims-spec-list (second symbol-spec-list))
       (cur-root) ;;  root-str)
       (new-root-str)
       (new-root-dimslist)
       (new-seq-list) (new-symbol-list)(new-dim-list-list)
       (rev-dim-lists)
       )
     (multiple-values-bind (n-dims n-items sublists)
                             (find-dim-spec-info dims-spec-list)
    (loop
     for rev-dimspec in (reverse dims-spec-list)  ;;eg (2 1  1)
     for dimspec in dims-spec-list  
     for dimlist in 
     for dim-n from 1 to n-dims
     for index-sym in index-syms
     do
     (let*
         ((subdims)
          (n-syms (car rev-dimspec))
          (begin-n (second rev-dimspec))
          (incr-n (third rev-dimspec))   
          (rev-dim-list (make-one-dim-indexes rev-dimspec))
          )
                        
                        
       ;;MAKE THE LEVEL 1 SYMS and set to SYMLISTS

      ;; make the level 1 subdims list eg (i j f)
     (setf subdims (append subdims (list index-sym)))
     (cond
      ;;first dim
      ((= dim-n 1)
       (cur-root (format nil "~A~A" root index-sym))
       )
      ;;last dim
      ((= dim-n n-dims)
     
       ;;make symlist and set sym to it


       )
      ;;otherwise, add the next sym?? how many
      (t
       

        ))

     ))
    ;;end function
    )))|#

(setf *ALL-NEW-ROOT-LISTS1 nil
      *ALL-NEW-ROOT-LISTS2 nil
      *ALL-NEW-ROOT-LISTS3  nil
      *out1 nil)








           
      ;;     cur-root 
     ;; make the level 1 syms
#|new-seq-list= ("wup1-2-1To" "wup1-2-2To" "wup1-2-3To" "wup1-2-4To")
;;new-symbol-list=(WUP1-2-1TO WUP1-2-2TO WUP1-2-3TO WUP1-2-4TO)
;;new-dim-list-list= (("wup1-2-1To" (4 1 1 "-" "To")) ("wup1-2-2To" (4 2 1 "-" "To")) ("wup1-2-3To" (4 3 1 "-" "To")) ("wup1-2-4To" (4 4 1 "-" "To")))|#
#|     (multiple-value-setq (new-seq-list new-symbol-list new-dim-list-list)
         ;;(make-dim-sequence-list \"wup1-2\" 4 :begin-str  \"-\"  :end-str \"To\")
         (make-dim-sequence-list  cur-root  cur-n-syms
                                  :begin-str begin-str  :end-str end-str))|#

  ;;zzzz

     ;;make level 1 symlists and set to sym
           
  
    ;;end mvb, let*, loop
      


     
   ;;SSSS START HERE  

    
    ;;for each 



        
    ;;end let, make-multi-dim-symbol-list
    


  ;;(make-dim-symbol


;;MAKE-DIMS-FROM-DIMSPEC
;;
;;



;;FIND-DIM-SPEC-INFO
;;
;;ddd
;; NOT USED IN ART2?, DIDN'T USE THIS TYPE dim-spec-list
(defun find-dim-spec-info (dim-spec-list 
                           &key (node-separators '("to" to)))  ;; (separator  "-"))
  "In U-ART, RETURNS (values n-dims n-items sublists)."
  (let
      ((n-dims 0)
       (separator)
       (node-separator)
       (n-items (list-length dim-spec-list))
       (n-subitems 0)
       (sublists)
       )
    (loop
     for item in dim-spec-list
     for n from 1 to n-items
     do
     (cond
      ((listp item)
       (incf n-dims)
       (incf n-subitems))
      ((member item node-separators :test 'equal)
       (setf sublists (append sublists (list n-subitems item))
             n-subitems 0))
      (t nil))
     ;;end loop
     )
    (setf sublists (append sublists (list n-subitems)))

    (values n-dims n-items sublists)
    ;;end let, find-dim-spec-info
    ))
;;TEST
;;  (find-dim-spec-info '((5 1 1 )  (3 1 1)  (3 1 1)))  ;;FOR X
;;  WORKS= 3  5  (3)
;;  (find-dim-spec-info '((5 1 1)  (1 3 1)  (1 2 1) to (3 1 1 )  (1 1 1) (1 3 1))) ;;FOR WUP
;; WORKS= 6  11  (3 TO 3)
     



;;MAKE-MULTI-DIM-SYMBOL-LIST
;;was make-multi-dim-sequence-list
;;ddd
(defun make-multi-dim-symbol-listOLD  (root all-dims-spec-list &key (recurse-flag 99)
                                           (unbind-global-vars-p T) (return-flat-lists-p T) 
                                           (node-separator "To") (set-root-to-flat-list-p T))
 "NEW: EG. root=  \"X\" all-dims-spec-list=  ((,*n-inputs 1 1 )(3 1 1   \"-\" )(3 1 1 \"-\"))) 
root=  \"WUP\"all-dims-spec-list=  ((,*n-inputs  1 1\"\")(1 3 1  \"-\")(1 2 1 \"-\"  ) (,*n-outputs 1 1  \"To\" )(1 1 1   \"-\")(1 3 1 \"-\")))
UPDATE:
In U-ART. Unless make-list-p, returns a list of new sequences of root,begin-str,dim-element,end-str for each value of dim-element from begin-n to n-dim-elements. RETURNS (values  new-sym-nested-lists  new-symbol-nested-lists new-dim-list-nested-lists new-sym-flat-list new-symbol-flat-list new-symdim-flat-list).  ALL-DIMS-SPEC-LIST (sublist1 sublist2 etc).  Each dim sublist =  (n-elements begin-n/or/cur-dim-n  dim-incr  begin-str end-str. If unbind-global-vars-p, then unbinds global vars needed to return right lists. If return-flat-lists-p, then returns unnested lists instead of nested ones. NOTE: Nested-lists are nested by all Dim1 items together.  Use function resort-nested-lists for 2-level/2-dim nested lists with all Dim2 items in same list."
   ;;note the global vars are used ONLY in the called functions, initialized by defparameters
    (setf   *new-sym-nested-lists nil  ;;*new-symbol-nested-lists nil  
            *new-symdim-nested-lists nil
            *append-node-sep-list nil  ) ;; *new-sym-flat-list nil)
    (let
        ((new-sym-nested-lists)
         ;;(new-symbol-nested-lists) 
         (new-symdim-nested-lists)
         (new-sym-flat-list)
         ;;(new-sym-flat-list)
         (new-symdim-flat-list)
         ;;(return-lists '( *new-sym-nested-lists  *new-symbol-nested-lists *new-dim-list-nested-lists))  ;; *new-sym-flat-list))
         ;;added
         (main-root-sym (my-make-symbol (format nil "~A" root)))
         )

  ;;CALL THE MAIN WORK FUNCTION          
   (multiple-value-setq (new-sym-nested-lists  new-symbol-nested-lists new-dim-list-nested-lists) ;;  new-sym-flat-list)
       (make-multi-dim-symbol-list1  root  all-dims-spec-list  :recurse-flag recurse-flag 
                                   :return-flat-lists-p return-flat-lists-p))
                                  ;; :node-separator node-separator))

   ;;set the symbol-vals done in bottom-function? (set-sym-to-root+dims new-symbol-nested-lists new-sym-vals-list) 
   
   (when unbind-global-vars-p
     (loop
      for list in return-lists
      do    
     (makunbound list)
     ;;end loop, when
     )
     ;;needed bec makunbound requires to be re-declared as special
     (setf  *new-sym-nested-lists nil  
             *new-symbol-nested-lists nil *new-dim-list-nested-lists nil) ;; *new-sym-flat-list nil)
     )

   ;;make  flat symbol and symbol-string lists?
   (when return-flat-lists-p
     (loop
      for strlist in new-sym-nested-lists
      do
      (when (and (listp strlist) (= (list-length strlist) 1))
        (setf new-sym-flat-list (append new-sym-flat-list strlist))
      ;;end  when, loop
      ))
   (loop
    for symlist in new-symbol-nested-lists
    do
    (when (and (listp symlist) (= (list-length symlist) 1))
      (setf new-symbol-flat-list (append new-symbol-flat-list symlist))
      ;;end  when, loop
      ))
   (loop
    for symdim-list  in new-dim-list-nested-lists
    do
    ;;(break)
    (when (and (listp symdim-list) (= (list-length symdim-list) 1))       
       (when (listp symdim-list)
         (setf new-symdim-flat-list (append new-symdim-flat-list symdim-list)))
         ;;end  whens, loops
         ))
   ;;if lists don't begin as nested, just set flat lists = other lists
   (when (null new-sym-flat-list)
     (setf new-sym-flat-list  new-sym-nested-lists))
   (when (null new-symbol-flat-list)
     (setf new-symbol-flat-list  new-symbol-nested-lists))
   (when (null new-symdim-flat-list)
     (setf new-symdim-flat-list new-dim-list-nested-lists))

    ;;end outer when return-flat-lists-p
    )

   ;;SET ROOT TO LIST OF SYMS--flat or nested?
   (cond
    (set-root-to-flat-list-p 
     (set main-root-sym (list root new-symbol-flat-list)))
    (t
     (set  main-root-sym (list root new-symbol-nested-lists))))    
   
   (values  new-sym-nested-lists  new-symbol-nested-lists new-dim-list-nested-lists new-sym-flat-list new-symbol-flat-list new-symdim-flat-list)
   ;;end when, make-multi-dim-symbol-list
   ))
;;TEST
;; (make-multi-dim-symbol-list "Wup" `((5 1 1"")(1 3 1  "-")(1 1 1 "-"  ) (3 1 1  "To" )(1 1 1   "-")(1 2 1 "-")) :return-flat-lists-p T)
;;ALSO WUP= (WUP1-3-1TO1-1-2 WUP1-3-1TO2-1-2 WUP1-3-1TO3-1-2 WUP2-3-1TO1-1-2 WUP2-3-1TO2-1-2 WUP2-3-1TO3-1-2 WUP3-3-1TO1-1-2 WUP3-3-1TO2-1-2 WUP3-3-1TO3-1-2 WUP4-3-1TO1-1-2 WUP4-3-1TO2-1-2 WUP4-3-1TO3-1-2 WUP5-3-1TO1-1-2 WUP5-3-1TO2-1-2 WUP5-3-1TO3-1-2)
;; WORKS=
;;new-sym-nested-lists= (("Wup1-3-1To1-1-2") ("Wup1-3-1To2-1-2") ("Wup1-3-1To3-1-2") ("Wup2-3-1To1-1-2") ("Wup2-3-1To2-1-2") ("Wup2-3-1To3-1-2") ("Wup3-3-1To1-1-2") ("Wup3-3-1To2-1-2") ("Wup3-3-1To3-1-2") ("Wup4-3-1To1-1-2") ("Wup4-3-1To2-1-2") ("Wup4-3-1To3-1-2") ("Wup5-3-1To1-1-2") ("Wup5-3-1To2-1-2") ("Wup5-3-1To3-1-2"))
;;new-symbol-nested-lists= ((WUP1-3-1TO1-1-2) (WUP1-3-1TO2-1-2) (WUP1-3-1TO3-1-2) (WUP2-3-1TO1-1-2) (WUP2-3-1TO2-1-2) (WUP2-3-1TO3-1-2) (WUP3-3-1TO1-1-2) (WUP3-3-1TO2-1-2) (WUP3-3-1TO3-1-2) (WUP4-3-1TO1-1-2) (WUP4-3-1TO2-1-2) (WUP4-3-1TO3-1-2) (WUP5-3-1TO1-1-2) (WUP5-3-1TO2-1-2) (WUP5-3-1TO3-1-2))
;;new-dim-list-nested-lists=[note: the dims are NOT right]= ((("Wup1-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup1-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup1-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup3-3-1To1-1-2" (1 2 1 "-" ""))) ;;(("Wup3-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup3-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup4-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup4-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup4-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup5-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup5-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup5-3-1To3-1-2" (1 2 1 "-" ""))))
;;new-sym-flat-list= ("Wup1-3-1To1-1-2" "Wup1-3-1To2-1-2" "Wup1-3-1To3-1-2" "Wup2-3-1To1-1-2" "Wup2-3-1To2-1-2" "Wup2-3-1To3-1-2" "Wup3-3-1To1-1-2" "Wup3-3-1To2-1-2" "Wup3-3-1To3-1-2" "Wup4-3-1To1-1-2" "Wup4-3-1To2-1-2" "Wup4-3-1To3-1-2" "Wup5-3-1To1-1-2" "Wup5-3-1To2-1-2" "Wup5-3-1To3-1-2")
;;new-symbol-flat-list=  (WUP1-3-1TO1-1-2 WUP1-3-1TO2-1-2 WUP1-3-1TO3-1-2 WUP2-3-1TO1-1-2 WUP2-3-1TO2-1-2 WUP2-3-1TO3-1-2 WUP3-3-1TO1-1-2 WUP3-3-1TO2-1-2 WUP3-3-1TO3-1-2 WUP4-3-1TO1-1-2 WUP4-3-1TO2-1-2 WUP4-3-1TO3-1-2 WUP5-3-1TO1-1-2 WUP5-3-1TO2-1-2 WUP5-3-1TO3-1-2)
;;new-symdim-flat-list = (("Wup1-3-1To1-1-2" (1 2 1 "-" "")) ("Wup1-3-1To2-1-2" (1 2 1 "-" "")) ("Wup1-3-1To3-1-2" (1 2 1 "-" "")) ("Wup2-3-1To1-1-2" (1 2 1 "-" "")) ("Wup2-3-1To2-1-2" (1 2 1 "-" "")) ("Wup2-3-1To3-1-2" (1 2 1 "-" "")) ("Wup3-3-1To1-1-2" (1 2 1 "-" "")) ("Wup3-3-1To2-1-2" (1 2 1 "-" "")) ("Wup3-3-1To3-1-2" (1 2 1 "-" "")) ("Wup4-3-1To1-1-2" (1 2 1 "-" "")) ("Wup4-3-1To2-1-2" (1 2 1 "-" "")) ("Wup4-3-1To3-1-2" (1 2 1 "-" "")) ("Wup5-3-1To1-1-2" (1 2 1 "-" "")) ("Wup5-3-1To2-1-2" (1 2 1 "-" "")) ("Wup5-3-1To3-1-2" (1 2 1 "-" "")))




;;MAKE-MULTI-DIM-SYMBOL-LIST1
;;was make-multi-dim-sequence-list1
;;
;;ddd
(defun make-multi-dim-symbol-list1  (current-root current-all-dims-spec-list
                                                  &key  (recurse-flag 99)
                                            return-flat-lists-p)
  "UPDATE THIS. In  Unless make-list-p, returns a list of new sequences of current-root,begin-str,dim-element,end-str for each value of dim-element (either begin-n to n-dim-elements or from the list dim-elements-list. RETURNS (values new-sym-nested-lists new-symbol-nested-lists new-dim-list-nested-lists ).  ALL-DIMS-SPEC-LIST (sublist1 sublist2 etc).  Each dim sublist =  (n-elements cur-dim-n  dim-incr  begin-str end-str).
NEW: EG. current-root=  \"X\" all-dims-spec-list=  ((,*n-inputs 1 1 )(3 1 1   \"-\" )(3 1 1 \"-\"))) 
root=  \"WUP\"all-dims-spec-list=  ((,*n-inputs  1 1\"\")(1 3 1  \"-\")(1 2 1 \"-\"  ) (,*n-outputs 1 1  \"To\" )(1 1 1   \"-\")(1 3 1 \"-\")))
"
  (let*
      ((dim-sublist )
       (n-elements)
       (cur-dim-n)
       (dim-incr)
       (begin-str)
       (end-str)
       (dim-spec-list)
       (dim-subspec-list)
       (new-root-list)
       (new-sym-list)
      ;;(new-symbol-list)
       ;;(new-dim-list-list)
       ;;done here bec only set on last dim
       (set-sym-to-vals-p) ;;???
       (new-string-nested-lists1)
       (new-symbol-nested-lists1)
       (new-dimlist-nested-lists1)
       (new-all-dims-spec-list)
      ;; (test-list)
       )
     ;;COND TO STOP THE RECURSION
     (cond
      ((or (= recurse-flag 0) (null all-dims-spec-list))
       NIL)
      ;;((= recurse-flag 99)
      (t
      ;;"X" all-dims-spec-list=  ((,*n-inputs 1 1 )(3 1 1   "-" )(3 1 1 "-")))  
      ;;"WUP" all-dims-spec-list=  ((,*n-inputs  1 1"")(1 3 1  "-")(1 2 1 "-"  ) (,*n-outputs 1 1  "To" )(1 1 1   "-")(1 3 1 "-"))) etc)
       ;;get the dim parameters
       (setf dim-spec-list (car all-dims-spec-list))             
       (multiple-value-setq (n-elements cur-dim-n dim-incr begin-str end-str)
           (values-list dim-spec-list))

       ;;on last cycle, set the symbol to the sym-vals  (sym-to-vals-p= t)
       (when (= (length all-dims-spec-list) 1)
         (setf set-sym-to-vals-p T))

       ;;ADD THE DIM TO THE CURRENT-ROOT AND GET NESTED LISTS
       (multiple-value-setq (new-sym-list new-symbol-list new-dim-list-list)
           (make-dim-sequence-list current-root  n-elements :begin-n cur-dim-n 
                                   :set-sym-to-vals-p set-sym-to-vals-p
                                   :dim-incr dim-incr  :begin-str begin-str :end-str end-str))

       ;;make lists for new recursion--don't append old because want only latest version??
       (setf new-all-dims-spec-list (cdr all-dims-spec-list)
             new-root-list new-sym-list)

       ;;SSS START HERE,  HOW TO GET THIS TO TOP WITH A NON-GLOBAL???
       ;; COULD I USE CATCH--THROW ETC.
       (cond
        #|(return-flat-lists-p
         (when (<  (length new-all-dims-spec-list) 1)
           (setf  *new-sym-nested-lists (append *new-sym-nested-lists new-sym-list)
                  *new-symbol-nested-lists  (append *new-symbol-nested-lists new-symbol-list )
                  *new-dim-list-nested-lists (append *new-dim-list-nested-lists new-dim-list-list))
           ;;added 2015-09
           (when (and (listp (car new-sym-list)) (= (list-length (car new-sym-list) 1)))
             (setf *new-sym-flat-list (append *new-sym-flat-list (caar new-sym-list))))
         ) )|#
        ;;return nested lists
        (t
         (when (<  (length new-all-dims-spec-list) 1)
           (setf  *new-sym-nested-lists (append *new-sym-nested-lists (list new-sym-list))
                  *new-symbol-nested-lists  (append *new-symbol-nested-lists (list new-symbol-list ))
                  *new-dim-list-nested-lists (append *new-dim-list-nested-lists (list new-dim-list-list))))))

       ;;(afout 'out (format nil "AT #1 new-all-dims-spec-list= ~A~% *new-sym-nested-lists= ~A~%new-root-list= ~A~%"  new-all-dims-spec-list    *new-sym-nested-lists new-root-list ))
       ;;end recurse-flag 99
       )
      (t nil))


     ;; IF  new-all-dims-spec-list = nil, THEN SKIP REST AND RETURN  LAST LISTS FROM ABOVE?
     (cond
      ((> (setf recurse-flag (length new-all-dims-spec-list))  0)

       ;;RECURSE CALL ON CDR OF ORIGINAL ALL-DIMS-SPEC-LIST FOR EACH NEW CURRENT-ROOT IN new-sym-list   
       (loop
        for current-root in new-root-list
        do                             

        (multiple-value-setq (seq-nested-lists1   symbol-nested-lists1
                                                  dim-list-nested-lists1)
            (make-multi-dim-symbol-list1 current-root  new-all-dims-spec-list
                                          :recurse-flag recurse-flag))

        ;;end loop current-root
        )
       ;;end recurse-flag > 0
       )
      ;;if  recurse-flag = 0 no recurse
      (t nil))
       (values *new-sym-nested-lists   *new-symbol-nested-lists   *new-dim-list-nested-lists  *new-sym-nested-lists recurse-flag) ;;  *new-sym-flat-list)
       
       ;;end let, make-multi-dim-symbol-list
       ))
;;TEST
;;  MUST TEST ABOVE MAIN FUNCTION , make-multi-dim-symbol-list





;;MAKE-DIM-STRING-LIST
;;was make-dim-sequence-list
;;
;;ddd
(defun make-dim-string-list (root n-dim-elements &key sym-vals-list
                                    (begin-n 1)(dim-incr 1)
                                          (begin-str "") (end-str "")
                                          dim-elements-list  (make-string-p T) (make-list-p T)
                                           set-sym-to-vals-p
                                          (make-symbol-p T))
  "OLD, REVISE DOCS In U-ART, Unless make-list-p, returns a list of new sequences of root,begin-str,dim-element,end-str for each value of dim-element (either begin-n to n-dim-elements or from the list dim-elements-list. RETURNS (values new-seq-list new-symbol-list new-dim-list-list ).  If set-sym-to-vals-p, then sets the new-symbol = (init-root dims-list n-dim-elements), eg. (\"Wup\" (2 5) 7)."
  (let*
      ((cur-dim-element)
       ;SSS IS THIS RIGHT??
       (end-n (floor (/  (+ (- n-dim-elements 1) begin-n) dim-incr)))
    ;;was (floor (/ (+ (- n-dim-elements begin-n) 1) dim-incr)) couldn't begin with other than 1
       (dim-n)
       (dim-end)
       (pre-seq)
       (new-seq)
       (new-dim-list)
       (new-symbol)
       (sym-vals)
         ;; (initial-root dim-list n-elements value(to be added))
       (return-sym-vals-list)
       (new-seq-list)
       (new-symbol-list)
       (new-dim-list-list)
       )
    ;;(floor (/  (+ (- n-dim-elements 1) begin-n) dim-incr))))
    ;;test for above
   ;; (+ (- n-dim-elements 1) begin-n)
   ;;  (+ (- 1 1) 3) = 3 ;  (+ (- 3 1)  1)
  ;;(end-n  (/ (+  (- 1 1)  3) 1)) = 3;; (/ (+  (- 2 1)  3) 2)
;;  

    (if (null begin-str) (setf begin-str ""))
    (if (null end-str) (setf end-str ""))

    (loop
     for n from begin-n to end-n
     do
     (setf dim-end (* n dim-incr))
     
     (cond
      (dim-elements-list (setf dim-element (nth n dim-elements-list)))
      (t (setf dim-element n)))

     (when make-string-p      ;;was (or make-string-p  set-sym-to-list-p)
       (setf new-seq (format nil "~A~A~A~A" root  begin-str dim-element end-str))
       (when  (or make-symbol-p  set-sym-to-list-p)
         (setf new-symbol (my-make-symbol new-seq)))
       (setf new-seq-list (append new-seq-list (list new-seq))
             new-symbol-list (append new-symbol-list (list new-symbol))))

       ;;for recursion?
     (when  make-list-p 
       (setf new-dim-list 
             (list new-seq (list n-dim-elements dim-element dim-incr begin-str end-str))
             new-dim-list-list (append new-dim-list-list (list new-dim-list))))
       
     ;;setting the symbol to sym-vals ONLY WHEN LAST DIM.
     (when set-sym-to-vals-p
       (multiple-value-bind (dim-list token-list alpha-list)
           (find-integers-in-string new-seq)
       (setf sym-vals (list (car alpha-list) dim-list  n-dim-elements))
       ;;SETS THE NEW-SYMBOL TO SYM-VALS
       (set new-symbol sym-vals)))
     ;;end loop
     )
    
    (values new-seq-list new-symbol-list new-dim-list-list)
    ;;end let, make-dim-string-list      
    ))
;;TEST
;;FOR ART3 --------------------------------------------------------
;; (make-dim-sequence-list "wup1-2" 4 :begin-str "-"  :end-str "To")
;; works= ("wup1-2-1To" "wup1-2-2To" "wup1-2-3To" "wup1-2-4To")
;;(WUP1-2-1TO WUP1-2-2TO WUP1-2-3TO WUP1-2-4TO)
;;(("wup1-2-1To" (4 1 1 "-" "To")) ("wup1-2-2To" (4 2 1 "-" "To")) ("wup1-2-3To" (4 3 1 "-" "To")) ("wup1-2-4To" (4 4 1 "-" "To")))
;;following args have no useful effects? :sym-vals-list '("wup" (7 8 9)) :dim-elements-list '(11 12))


;; (make-multi-dim-symbol-list "Wup" `((5 1 1"")(1 3 1  "-")(1 1 1 "-"  ) (3 1 1  "To" )(1 1 1   "-")(1 2 1 "-")))
;; WORKS= (("Wup1-3-1To1-1-2") ("Wup1-3-1To2-1-2") ("Wup1-3-1To3-1-2") ("Wup2-3-1To1-1-2") ("Wup2-3-1To2-1-2") ("Wup2-3-1To3-1-2") ("Wup3-3-1To1-1-2") ("Wup3-3-1To2-1-2") ("Wup3-3-1To3-1-2") ("Wup4-3-1To1-1-2") ("Wup4-3-1To2-1-2") ("Wup4-3-1To3-1-2") ("Wup5-3-1To1-1-2") ("Wup5-3-1To2-1-2") ("Wup5-3-1To3-1-2"))
;;  ((WUP1-3-1TO1-1-2) (WUP1-3-1TO2-1-2) (WUP1-3-1TO3-1-2) (WUP2-3-1TO1-1-2) (WUP2-3-1TO2-1-2) (WUP2-3-1TO3-1-2) (WUP3-3-1TO1-1-2) (WUP3-3-1TO2-1-2) (WUP3-3-1TO3-1-2) (WUP4-3-1TO1-1-2) (WUP4-3-1TO2-1-2) (WUP4-3-1TO3-1-2) (WUP5-3-1TO1-1-2) (WUP5-3-1TO2-1-2) (WUP5-3-1TO3-1-2))
;;  ((("Wup1-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup1-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup1-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup2-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup3-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup3-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup3-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup4-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup4-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup4-3-1To3-1-2" (1 2 1 "-" ""))) (("Wup5-3-1To1-1-2" (1 2 1 "-" ""))) (("Wup5-3-1To2-1-2" (1 2 1 "-" ""))) (("Wup5-3-1To3-1-2" (1 2 1 "-" ""))))




#|DELETE----------------------------------------
(defun make-new-dimsymbol-types (symbol-spec-lists
                                    &key make-sublists-for-each-dim-p
                                    (set-global-vars-p T)  (return-flat-lists-p T)
                                    (nest-indicator-string "To") nested-inner-list-size)
 "In U-ART.  OLD-REVISE: Returns new symbols of root, begin-str,dim-element,end-str for each value of dim-element from begin-n to n-dim-elements. RETURNS (values new-symbol-type-list  new-symbols-type-list-of-lists   new-symbol-type-spec-list-of-lists  new-root-list   new-symbol-type-symbol-string-list-of-lists  all-new-sym-names-flat-list  all-new-symbols-flat-list all-new-symdim-lists-flat-list).  INPUTS:  For SYMBOL-SPEC-LISTS, EACH symbol-spec-list= (ROOT all-dims-spec-list). ALL-DIMS-SPEC-LIST= (sublist1 sublist2 etc).  Each dim sublist =  (n-elements begin-n/or/cur-dim-n  dim-incr  begin-str end-str. Eg. (\"root\" '((4 1 1 \"C\" \"F\")(3 1 1 \"C\" \"F\"))).
KEYS: If set-global-vars-p, sets global * versions of all return vars.  If return-flat-lists-p, then returns unnested lists instead of nested ones. NOTE: Nested-lists are nested by all Dim1 items together.  Use function resort-nested-lists for 2-level/2-dim nested lists with all Dim2 items in same list."
 (when set-global-vars-p
  (setf   *new-symbol-type-list nil  *new-symbols-type-list-of-lists  nil
            *new-symbol-type-spec-list-of-lists nil  *new-root-list nil
            *new-symbol-type-symbol-string-list-of-lists nil ))
  (let*    
      ((n-symbol-types  (length symbol-spec-lists))
      ;; (n-symbols 1)
      ;; (dim-i-end)
      ;; (dim-j-end)
       ;;outputs
       (root-sym)
       (new-symbols-list)
       (new-symbol-type)
       (new-symbol-type-list)
       (new-sym-names-flat-list)  ;;new
       (new-symbols-flat-list) ;;new
       (new-symdim-lists-flat-list) ;;new
       (all-new-sym-names-flat-list)  ;;new
       (all-new-symbols-flat-list) ;;new
       (all-new-symdim-lists-flat-list) ;;new
       (all-dims-spec-list) ;;new
       (new-seq-nested-lists)
       (new-symbol-nested-lists)
       (new-dim-list-nested-lists)
       (new-symbol-type-spec-list)
       (new-symbol-type-symbol-string-list)
       (new-symbols-type-list-of-lists)
       (new-symbol-type-spec-list-of-lists)
       (new-symbol-type-symbol-string-list-of-lists)       
       (new-root-list)
       (dimspecs-n)
       (inner-list)
       (outer-list)
       )
    ;;(afout 'out (format nil "2 symbol-spec-lists= ~A~%" symbol-spec-lists))
    (loop
     for symbol-spec-list in symbol-spec-lists
     ;;for dim-spec-list in symbol-spec-lists
     ;;for symbol-n from 1 to  n-symbol-types
     ;;    with n-symbols = (car dim-spec-list)
     do
     (setf root (car symbol-spec-list)
           all-dims-spec-list (second symbol-spec-list)
           root-sym (my-make-symbol root)
           dimspecs-n 0)
     ;;(afout 'out (format nil "dim-spec-list= ~A~%" dim-spec-list))
     ;;eg SingleDim (,nInputs ("Input" ((1 1)) "" ""))
     ;;eg DoubleDim (,nOutputs ("Wup" ((1 1)(1 1)) "" ""))

     ;;added 2015-09
       ;;all-dims-spec-list=  ((3 1 1"")(1 3 1  "-")(1 1 1 "-"  ) (3  1 1  "To" )(1 1 1   "-")(1 2 1 "-"))
       ;;dimspecs= (3 1 1"")  or (1 3 1  "-") or  (3  1 1  "To" )

      ;;If nest-indicator-string, find nested-inner-list-size
     (when nest-indicator-string
       (dolist (dimspecs all-dims-spec-list)
         (incf dimspecs-n) ;;first = 1
         (cond 
          ;;if  "To" is begin-str, uses N of same dimspecs
          ((string-equal (fourth dimspecs) nest-indicator-string)
           (setf nested-inner-list-size (car dimspecs)))
          ;;if  "To" is end-str, uses N of NEXT dimspecs
          ((string-equal (fifth dimspecs) nest-indicator-string)
           (setf nested-inner-list-size (car (nth dimspecs-n dimspecs))))   ;;next list      
        (t  NIL ))  ;;was (setf nested-inner-list-size nil)))
       ;;end  dolist,when
       ))

     ;;SSS FIX new-seq-nested-lists RETURNING NIL
     ;;FIND THE NEW SYMBOLS, ETC
     (multiple-value-setq (new-seq-nested-lists  new-symbol-nested-lists new-dim-list-nested-lists  new-sym-names-flat-list new-symbols-flat-list new-symdim-lists-flat-list)
         (make-multi-dim-symbol-list  root  all-dims-spec-list
                                        :return-flat-lists-p  return-flat-lists-p))
        ;;old (make-new-dim-symbols  n-symbols (second dim-spec-list)
          ;;                        :make-sublists-for-each-dim-p make-sublists-for-each-dim-p))

     (setf  new-root-list (append new-root-list (list root))
           new-symbol-type-list (append new-symbol-type-list 
                                         (list root-sym))            
           new-symbols-type-list-of-lists (append new-symbols-type-list-of-lists
                                                  (list new-symbol-nested-lists))
           new-symbol-type-spec-list-of-lists (append new-symbol-type-spec-list-of-lists
                                                      (list new-dim-list-nested-lists))
           new-symbol-type-symbol-string-list-of-lists 
                (append new-symbol-type-symbol-string-list-of-lists 
                      (list new-seq-nested-lists))
           all-new-sym-names-flat-list (append all-new-sym-names-flat-list 
                                           (list new-sym-names-flat-list))
           all-new-symbols-flat-list  (append all-new-symbols-flat-list
                                            (list new-symbols-flat-list))
           all-new-symdim-lists-flat-list (append all-new-symdim-lists-flat-list
                                            (list new-symdim-lists-flat-list)))


   ;;sss
;; (values new-symbol-type-list  Xnew-symbols-type-list-of-lists             new-symbol-type-spec-list-of-lists  new-root-list             Xnew-symbol-type-symbol-string-list-of-lists  all-new-sym-names-list)       

     ;;added 2015-09 may be elsewhere also??
     ;;make a flat list if list is eg. ((WUP1-3-2TO1-1-3) (WUP1-3-2TO2-1-3) (WUP2-3-2TO1-1-3) (WUP2-3-2TO2-1-3) (WUP3-3-2TO1-1-3) (WUP3-3-2TO2-1-3))
#|     (dolist (item  new-symbol-nested-lists)
       (cond 
        ((listp item)
         (setf new-symbol-flat-list (append new-symbol-flat-list  item)))
        (t setf  new-symbol-flat-list (append new-symbol-flat-list (list item))))
       ;;end dolist
       )|#
     ;;make a nested list 
     (when  nested-inner-list-size
       (loop
        for item in new-symbols-flat-list
        do
        (loop
         for n from 1 to nested-inner-list-size
         do
         (setf inner-list (append inner-list (list item)))
         ;;end inner-loop
         )
        (setf outer-list (append outer-list (list inner-list)))
        ;;reset inner-list
        (setf inner-list nil)
        ;;end outer loop
        )         
       (setf new-symbol-nested-lists outer-list)
       ;;end when
       )

     ;; SSSS START HERE FIXING WHAT X SET TO
     ;;SET NEW SYMBOLS TO LISTS 
 ;;  causes errors
#|   (cond
     ;;If want to manually control the nested-inner-list-size
      (nested-inner-list-size
       (set (my-make-symbol (format nil "~A-flat" root))   new-symbols-flat-list)
       (set  root-sym  new-symbol-nested-lists))
      (t
       (set  root-sym  new-symbols-flat-list)
       (set (my-make-symbol (format nil "~A-flat" root))  new-symbols-flat-list)))|#

     ;;end BIG OUTER symbol-spec-lists loop
     )
    
    (when set-global-vars-p 
      (setf *new-symbol-type-list new-symbol-type-list
            *new-symbols-type-list-of-lists  new-symbols-type-list-of-lists
            *new-symbol-type-spec-list-of-lists  new-symbol-type-spec-list-of-lists
            *new-root-list new-root-list
            *new-symbol-type-symbol-string-list-of-lists new-symbol-type-symbol-string-list-of-lists
            *all-new-sym-names-flat-list  all-new-sym-names-flat-list
            *all-new-symbols-flat-list all-new-symbols-flat-list
            *all-new-symdim-lists-flat-list all-new-symdim-lists-flat-list))

    (values new-symbol-type-list  new-symbols-type-list-of-lists
            new-symbol-type-spec-list-of-lists  new-root-list
            new-symbol-type-symbol-string-list-of-lists  all-new-sym-names-flat-list 
            all-new-symbols-flat-list all-new-symdim-lists-flat-list)
    ;;end let, make-new-dimsymbol-types
    ))|#