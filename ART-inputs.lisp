;;*************************** ART-inputs.lisp *******************************
;;
;;INPUTS FOR ART
;;
;;SOME DEVELOPED AS A DIGITAL LANGUAGE TO REPRESENT NATURAL LANGUAGE
;;

;;IDEA FOR LETTERS, NUMBERS, ETC some analogy to programming language
;; USE PATTERNS NOT JUST PLACES
;;first few places for type (upper/lower case, letter, punctuation, number, operator
;; next for aA, bB, cC ... 0, 1, 2....  - + * /  decimal 
;;Examples
;;TO GET A SPECIFIC INPUT COMBINE TYPE ELEMENTS WITH SPECIFIC MEANING ELEMENTS (EG combine (digit 0  =0  "TypeLetter") with   (digit 1 =0   "TypeUppercase")   with ANY DIGIT 2 with, for digits 3-7 =  (0 1 0 1 1  "M") ,
;;PRODUCES INPUT= (0) + (0) + (0) + (0 1 0 1 1) = (0 0 0 0 1 0 1 1 ... plus digits for numbers, punct, operators)
;;

(defun initialize-input-meanings ()
  "In ART-inputs.lisp, initializes ART stored input lists"
  (declare (special *input-meaning-type-list* *letters-meaning-list* *numbers-meaning-list*   *punct-meaning-list* *operator-meaning-list* *art-symbol-list*))

;;EXAMPLE INPUT 
;; 2-type, 5-letter, 4-punct, 4-number, 4-operator
;;combine the type with the 4-digit category
;; 0 0 0=letter,  0 0 0 0 1 = b;  (0 1 0 0 0 0 1)
;; 0 0 1=number, 1 0 0 0 = 7;  (0 1 1 0 0 0)
;; 1 0 0=punctuation, 0 0 0 1 = ","; (1 0 0 0 0 0 1)
;; 1 0 1=operator, 0 10 0 = =; (1 0 1 0 1 0 0)


 ;;PLACE, VALUE, MEANING|#
 (setf *input-meaning-type-list*
       '((0 0 0  "TypeLetter" *letters-meaning-list*)
         (0 0 1  "TypeNumber" *numbers-meaning-list*)
         (1 0 0  "TypePunctuation" *punct-meaning-list*)
         (1 0 1  "TypeOperator" *operator-meaning-list*)
         ))
  
            
 ;;ACTUAL DIGITS FOR MEANING--first doesn't represent a place
 (setf *letters-meaning-list*
         '((0 0 0 0 0 0  "a")
         (0 0 0 0 0 1 "b")
         (0 0 0 0 1 0   "c")
         (0 0 0 0 1 1  "d")
         (0 0 0 1 0 0   "e")
         (0 0 0 1 0 1  "f")
         (0 0 0 1 1 0  "g")
         (0 0 0 1 1 1 "h")
         (0 0 1 0 0 0  "i")
         (0 0 1 0 0 1   "j")
         (0 0 1 0 1 0   "k")
         (0 0 1 0 1 1  "l")
         (0 0 1 1 0 0  "m")
         (0 0 1 1 0 1  "n")
         (0 0 1 1 1 1 "o")
         (0 1 0 0 0 0   "p")
         (0 1 0 0 0 1   "q")
         (0 1 0 0 1 0  "r")
         (0 1 0 0 1 1 "s")
         (0 1 0 1 0 0  "t")
         (0 1 0 1 0 1  "u")
         (0 1 0 1 1 0  "v")
         (0 1 0 1 1 1 "w")
         (0 1 1 0 0 0 "x")
         (0 1 1 0 0 1 "y")
         (0 1 1 0 1 0 "z")
;;end lowercase
           (1 0 0 0 0 0   "A")
         (1 0 0 0 0 1 "B")
         (1 0 0 0 1 0   "C")
         (1 0 0 0 1 1  "D")
         (1 0 0 1 0 0   "E")
         (1 0 0 1 0 1  "F")
         (1 0 0 1 1 0  "G")
         (1 0 0 1 1 1 "H")
         (1 0 1 0 0 0  "I")
         (1 0 1 0 0 1   "J")
         (1 0 1 0 1 0   "K")
         (1 0 1 0 1 1  "L")
         (1 0 1 1 0 0  "M")
         (1 0 1 1 0 1  "N")
         (1 0 1 1 1 1 "O")
         (1 1 0 0 0 0   "P")
         (1 1 0 0 0 1   "Q")
         (1 1 0 0 1 0  "R")
         (1 1 0 0 1 1 "S")
         (1 1 0 1 0 0  "T")
         (1 1 0 1 0 1  "U")
         (1 1 0 1 1 0  "V")
         (1 1 0 1 1 1 "W")
         (1 1 1 0 0 0 "X")
         (1 1 1 0 0 1 "Y")
         (1 1 1 0 1 0 "Z")
         (1 1 1 0 1 1 "")
         (1 1 1 1 0 0 "")
         (1 1 1 1 0 1 "")
         (1 1 1 1 1 0 "")
         (1 1 1 1 1 1 "")
         ))

   ;;Fifth digit is the number represented
  (setf *numbers-meaning-list*
        '((0 0 0 0  0)
          (0 0 0 1  1)
          (0 0 1 0  2)
          (0 0 1 1 3)
          (0 1 0 0  4)
          (0 1 0 1  5)
          (0 1 1 1  6)
          (1 0 0 0  7)
          (1 0 0 1   8)
          (1 0 1 0  9)
         ;;  (1 0 1 1  .)
          (1 1 0 0 "")
          (1 1 0 1 "")
          (1 1 1 0 "")
          (1 1 1 1 "")
          ))
(setf  *punct-meaning-list*
       '(
        (0 0 0 0   ".")
         (0 0 0 1   ",")
         (0 0 1 0   ";")
         (0 0 1 1  ":")
         (0 1 0 0   "?")
         (0 1 0 1   "!")
         (0 1 1 0   "quote")
         (0 1 1 1  "double-quote")
         (1 0 0 0   "newline")
         (1 0  0 1 "\(")
        (1 0 1 0   "\)")
         (1 0 1 1  "[")
         (1 1 0 0   "]")
         (1 1 1 0   "-")
         (1 1 1 1  " ") ;;this is blank space
         ))


;;MUST CHANGE TO CHARS??
(setf *operator-meaning-list*
      '((0 0 0 0  +)
        (0 0 0 1  -)
        (0 0 1 0  *)
        (0 0 1 1  /)
        (0 1 0 0  =)
        (0 1 0 1  >)
        (0 1 1 0  <)
        (0 1 1 1  $)
      ;;  (1 0 0 0  #)
        (1 0 0 1  %)
       ;; (1 0 1 0   .)
        (1 0 1 1  !)
     ;;   (1 1 0 0  |)
     ;;   (1 1 1 0   \\)
        ))
  
(setf *ART-symbol-list*
    (append   *input-meaning-type-list* *letters-meaning-list* *numbers-meaning-list*
              *punct-meaning-list* *operator-meaning-list*))
)

;;PUT INSIDE A FUNCTION LATER

(initialize-input-meanings)



;;FIND-SENTENCE-DIGITS
;;
;;ddd
(defun find-sentence-digits (sentence &key omit-separators-p)
  "In ART-inputs, sentenece can be a long string, a list of strings, or a list of lists of char-strings.  RETURNS (values sentence-comp-digits-lists sentence-simple-digit-lists word-string-list). "
  (let
      ((charstr-list)
       (charlist)
       ;;(word-list)
       (word-lists)
       (compound-digits-list)
       (sentence-comp-digits-lists)
       (simple-digit-lists) 
       (sentence-simple-digit-lists)
       (word-string-list)
        (symbol-type)
        (separator)
        (compound-digits)
        (digit-list)
        (symbol-string)
        )

    ;;PRE-PROCESS DEPENDING UPON SENTENCE INPUT
    (cond
     ((stringp sentence)
      (multiple-value-setq (charstr-list charlist word-lists)
          (convert-string-to-char-strings sentence :list-words-p T))
      )
     ((listp sentence)
      (loop
       for item in sentence
       do
       (cond
        ((stringp item)
         (multiple-value-setq (charstr-list charlist)
          (convert-string-to-char-strings sentence))
         (setf word-list (append word-list charstr-list)))
        (item
         (setf word-lists (append word-lists (list item)))))
       ;;end loop, listp sentence
       ))
     (t nil))

      ;;NOW PROCESS EACH WORD-LIST SUBLIST
      (when (listp word-lists)
        (loop
         for word-list in word-lists
         do
         (cond
          ((listp word-list)
           (multiple-value-setq (compound-digits-list simple-digit-lists word-string
                                                      symbol-type)
               (find-word-digits word-list))
           (setf sentence-comp-digits-lists (append sentence-comp-digits-lists
                                                    (list compound-digits-list))
                 sentence-simple-digit-lists (append sentence-simple-digit-lists 
                                                     (list simple-digit-lists))
                 word-string-list  (append word-string-list (list word-list))))            
          ((null omit-separators-p)
           (multiple-value-setq (compound-digits digit-list symbol-string symbol-type)
               (find-symbol-digits word-list))
           (setf sentence-comp-digits-lists (append sentence-comp-digits-lists
                                                    (list compound-digits))
                 sentence-simple-digit-lists (append sentence-simple-digit-lists 
                                                     (list digit-list))
                 word-string-list  (append word-string-list (list word-list)))
           ;;end null omit-separators-p clause
           )
          (t nil))
         ;;end loop, when
         ))
        (values sentence-comp-digits-lists sentence-simple-digit-lists word-string-list)
    ;;end let, find-sentence-digits
    ))
;;TEST
;;  (find-sentence-digits "This is a sentence.")
       






;;FIND-WORD-DIGITS
;;
;;ddd
(defun find-word-digits (word)
  "In ART-inputs, Translates the characters of WORD string into their ART-digital code representation. RETURNS (values compound-digits-list simple-digit-lists  word-string-list  symbol-type).  Input may be string or symbol, returns strings for all except numbers. Returns lists of digits--each representing one letter-symbol; a list of compound-digits and a list of simple digits w/o the type.  COMPOUND-DIGITS = first 3 digits=type, last part? digits=symbol. word-string can be either a string or a list of char-strs "
  (let
      ((char-list)
       (comp-digits)
       (simple-digits)
       (compound-digits-list)
       (simple-digit-lists)
       (symbol-type)
       (word-string-list)
       (symbol)
       )

    ;;PRE-PROCESS TO GET SEPARATE WORDS (separators, etc)
    (cond
     ((stringp word)
      (setf  word-string-list (convert-string-to-char-strings word)))
     ((listp word)
      (when (stringp (car word))
        (setf word-string-list word)))
     ;;do later??
     ((symbolp word) 
      NIL)
     (t nil))

    ;;NOW CREATE THE WORD DIGITS LIST    
    (loop
     for char-str in word-string-list
     do
     (multiple-value-setq (compound-digits digit-list symbol-string symbol-type)
         (find-symbol-digits char-str))
     (setf compound-digits-list (append compound-digits-list (list compound-digits))
           simple-digit-lists (append simple-digit-lists (list digit-list)))
     ;;end loop
     )
     (values compound-digits-list simple-digit-lists  word-string-list  symbol-type)
    ;;end let, find-word-digits
    ))
;;TEST
;; (find-word-digits "this")
;; works= ((0 0 0 0 1 0 1 0 0) (0 0 0 0 0 0 1 1 1) (0 0 0 0 0 1 0 0 0) (0 0 0 0 1 0 0 1 1))   ((0 1 0 1 0 0) (0 0 0 1 1 1) (0 0 1 0 0 0) (0 1 0 0 1 1))   ("t" "h" "i" "s")   "TypeLetter"



;;FIND-SYMBOL-DIGITS
;;
;;ddd
(defun find-symbol-digits (char-string)
  "In ART-inputs, Translates the characters of single-symbol string into their ART-digital code representation. RETURNS (values compound-digits digit-list symbol-string symbol-type).  Input may be string or symbol, returns strings for all except numbers. COMPOUND-DIGITS = first 3 digits=type, last 4-? digits=symbol."
  (setf out nil)
  (let*
      ((code-type)
       (digit-list)
       (compound-digits)
       (symbol-string)
       (symbol-type)
       (symbol-meaning-list)
       (type-digits)       
       #|       (symbol-type-lists '(*input-meaning-type-list* *letters-meaning-list* 
          *numbers-meaning-list* *punct-meaning-list* *operator-meaning-list*))|#
       )
    (block alpha
    (loop
     for symbol-type-list in *input-meaning-type-list*
     do
     (setf  symbol-type (fourth symbol-type-list)
            symbol-meaning-list (car (last symbol-type-list))
            type-digits (butlast symbol-type-list 2))
     (afout 'out (format nil " symbol-type= ~A~%  symbol-meaning-list= ~A~%  type-digits= ~A~% " symbol-type   symbol-meaning-list  type-digits ))
     (loop
      for symbol-list in (eval symbol-meaning-list)
      ;;with symbol-string
      ;;with compound-digits
      do
      (setf symbol-string (car (last symbol-list))
            compound-digits nil)
    ;; (afout 'out (format nil "symbol-list= ~A~% symbol-string= ~A~% char-string= ~A~% compound-digits= ~A~% "symbol-list symbol-string char-string compound-digits))
      (cond
       ;;works for symbol or string values of the symbol
       ((or (equal symbol-string char-string)
            (equal (format nil "~A" symbol-string) (format nil "~A" char-string)))
        (setf digit-list (butlast symbol-list)
              compound-digits (append type-digits digit-list))
        (return-from alpha (values compound-digits digit-list symbol-string symbol-type)))
       (t nil))
      ;;end loops and block alpha
      )))
    ))
;;TEST
;;test -- works for below
;;  (find-symbol-digits "C")
;; works, returns values= (0 0 0 1 0 0 0 1 0)  (1 0 0 0 1 0)  "C"  "TypeLetter"
;;  (find-symbol-digits 8) or  (find-symbol-digits  "8") both work and return below
;; works, returns values= (0 0 1 1 0 0 1)  (1 0 0 1)  8  "TypeNumber"
;; (find-symbol-digits  'a)
;; works, returns values  (0 0 0 1 0 0 0 0 0) (1 0 0 0 0 0) "A" "TypeLetter"
;;(find-symbol-digits  ",") or (find-symbol-digits  ',)
;; works, returns values  (1 0 0 0 0 0 1) (0 0 0 1) "," "TypePunctuation"
;;(find-symbol-digits  '+) or (find-symbol-digits  "+")
;; works, returns values (1 0 1 0 0 0 0) (0 0 0 0) + "TypeOperator"
;;  (find-symbol-digits  ".")




;;xxx FROM ART.lisp
;; FOR AUTO GENERATING PATTERNS FROM SIMPLE DESCRIPTIONS
;;USE
;; (ART-pattern-generator n-inputs pattern-list1 pattern-type1) ;; :randomize t)
;;  OR (ART-pattern-generator n-inputs pattern-list2 pattern-type2 :num-cyclesp t)  ETC
#|
(defun testpg ()
  (setf out nil)
  (let*
      ((n-inputs 3)
       (pattern-list1 '((3 (1 0 1) "S1")(2(0 1 0) "S2"))) 
       (pattern-type1 'equal)
       ;;works, returns (((1 0 1) "S1") ((1 0 1) "S1") ((1 0 1) "S1") ((0 1 0) "S2") ((0 1 0) "S2"))
       ;;with randomize t returns (((1 0 1) "S1") ((1 0 1) "S1") ((0 1 0) "S2") ((1 0 1) "S1") ((0 1 0) "S2"))
       ;; with num-cyclesp t returns ((3 (1 0 1) "S1") (2 (0 1 0) "S2"))
       (pattern-list2 '((2 ((> .7)(< 0.3)(> 0.6))  "S1")(3 ((= 0.5)(> 0.8)(< 0.6))"S2" )))
       ;; w/or randomize works, returns (((0.92205954 0.16652395 0.84966165) "S1") ((0.92205954 0.16652395 0.84966165) "S1") ((0.5 0.9885243 0.2871696) "S2") ((0.5 0.9885243 0.2871696) "S2") ((0.5 0.9885243 0.2871696) "S2"))
       ;;w randomize t works, returns (((0.796799 0.16920913 0.96542407) "S1") ((0.5 0.97509367 0.1302892) "S2") ((0.796799 0.16920913 0.96542407) "S1") ((0.5 0.97509367 0.1302892) "S2") ((0.5 0.97509367 0.1302892) "S2"))
       ;;with num-cyclesp t works, returns ((2 (0.96480257 0.11676551 0.88210607) "S1") (3 (0.5 0.97711325 0.0067082406) "S2"))
       (pattern-type2 'formula)
       (result)
       )
  ;;  (setf result (ART-pattern-generator 9 pattern-list1 pattern-type1 :randomize t));; :num-cyclesp t))
    ;; works returns  ((1 0 1) (1 0 1) (1 0 1) (0 1 0) (0 1 0))
    (setf result (ART-pattern-generator n-inputs pattern-list2 pattern-type2 :num-cyclesp t))   ;; :randomize t))
   ;; (afout 'out (format nil "testpg result= ~A~%" result))
    (fout out)
    result
    ))
|#



;; ORIGINAL TEST-PATTERNS ----------------------------------------------------------
;; DEFINE SOME TEST PATTERNS:
;; NOTE: CHANGED--Now the input pattern list can be preceded by the num-cycles for that patter
;;  which REPLACES  the normal num-cycles for running ART2 at the top level.
;;original


#|
;;A (1 0 1 0 1) ;;A
;;B (0 1 0 1 0)  ;;B
;;C (1 0 0 1 0)  ;;C
;;D (0 1 0 0 0)  ;;D
;;E (0 0 1 1 0)   ;;E
(setq test-PatternsA1
      '(  ((1 0 1 0 1)) ;;A
           ((1 0 1 0 1));;A 
           ((1 0 1 0 1)) ;;A    
           ((1 0 1 0 1)) ;;A 
          ((0 1 0 1 0))  ;;B
          ((0 1 0 1 0))  ;;B
          ((0 1 0 1 0))  ;;B
          ((0 1 0 1 0))  ;;B
        ))
;;works -- A gradually increases strength of  Y-Output1 (becomes cells "A"); B gradually increases strength of  Y-Output2 (becomes cells "B")





(setq test-patterns15
      '(
        ((0.0 0.4 0.9 0.4 0.0))
        ((1.0 0.3 0.0 0.3 1.0))
        ((0.75 0.5 0.02 0.05 0.07))
        ((0.02 0.41 0.91 0.36 0.08))
        ((1.1 0.12 0.0 0.3 1.0))
        ((0.0 0.2 0.9 0.4 0.0))
        ((0.93 0.31 0.0 0.78 1.0))
        ((0.6 0.6 0.02 0.05 0.07))
        ((0.79 0.54 0.02 0.08 0.07))
        ((0.0 0.45 0.7 0.25 0.0))
        ((1.0 0.3 0.0 0.3 0.65))
        ((0.0 0.4 0.9 0.4 0.0))
        ((0.0 0.5 0.75 0.5 0.0))
        ((1.0 0.2 0.0 0.4 0.8))
        ((0.82 0.46 0.02 0.09 0.01))
        ))

(setq test-patterns2
      '(
        ((0.9 0.9 0.9 0.1 0.1))
        ((0.7 0.9 0.8 0.1 0.2))
        ))
(setq test-patterns6
      '(
        ((0.0 0.4 0.9 0.4 0.0))
        (2 (1.0 0.3 0.0 0.3 1.0))
        ((0.75 0.5 0.02 0.05 0.07))
        ((0.02 0.41 0.91 0.36 0.08))
        ((1.1 0.12 0.0 0.3 1.0))
        ((0.0 0.2 0.9 0.4 0.0))
        ))
      
;;  (setq *test-patterns test-patterns6)
|#





;;MOVED FROM ART2.lisp


;;
;;ART-PATTERN-GENERATOR
;; (5((< 5)(>.5)(< .5)(> .5)))
;;mmm11
;;ddd
(defun ART-pattern-generator (n-inputs pattern-list pattern-type 
                                        &key randomize num-cyclesp)
  "In ART.lisp, generates patterns for inputs. pattern-list is form of ((num-cycles (pattern)).. ).  pattern-type is either 'equal or 'formula. If 'equal, then patterns identical to the one provided are generated. If 'formula, the either a value or a list (operator value), operators = < > are used. < and > generate random numbers below or above the value. If :num-cyclesp is T, then the :num-cycles is included in each output list. num-cyclesp nil causes generation of separate patterns with no num-cycles in list (use if want to randomize all patterns).  :randomize T causes the final list-of-lists to be randomized."

  (let*
      ((num-patterns (list-length pattern-list))
       (new-pattern-list) ;;overall list of lists
       (pattern)
       (new-pattern)
       (label)
       (n-pattern-cycles)
       )
    (loop
     for sublist in pattern-list
     for n from 0 to num-patterns
     ;;with n-pattern-cycles
     ;;with pattern ;; can be list of values or (operator value) lists which reduce to a single value
     ;;with new-pattern ;;a list of values
     ;;with label ;;usually the S or s-r label
     do
     (setf n-pattern-cycles (car sublist)
           pattern (second sublist)
           label (third sublist)
           new-pattern nil)
           
     ;;(afout 'out (format nil "In ART-pattern-generator, n-pattern-cycles= ~A pattern-type= ~A pattern= ~A~%" n-pattern-cycles pattern-type pattern))
     (cond
      ;;alike-repeat use only if all values in a pattern are identical to repeats of same pattern
      ((equal pattern-type 'equal)
       (cond
        ((null num-cyclesp)
         (loop
          for cycle-n  from 1 to n-pattern-cycles
          do
          ;;was (dotimes (cycle-n n-pattern-cycles)
          (setf new-pattern-list (append new-pattern-list (list (list pattern label))))
          (afout 'out (format nil "new-pattern-list= ~A~%"  new-pattern-list))))
        (t 
         (setf new-pattern-list (append new-pattern-list (list sublist)))))
       )
      ((equal pattern-type 'formula)
       ;;work on the pattern list elements
       (loop
        for element in pattern
        with operator
        with value
        with new-value
        do
        (cond
         ((listp element)
          (setf operator (car element)
                value (second element))
          (cond
           ((equal operator '=)
            (setf new-value value))
           ((equal operator '<)
            (setf new-value (random value)))
           ((equal operator '>)
            (setf new-value (+ value (random (- 1 value)))))
           (t nil))
          (setf new-pattern (append new-pattern (list new-value)))
          ;;end listp
          )
         (t "Element is not a list"))
        ;;end loop
        )
       ;;make copies of it for n-pattern-cycles it is used
       (cond
        ((null n-pattern-cyclesp)
         (loop
          for cycle-n  from 1 to n-pattern-cycles
          do
           (setf new-pattern-list (append new-pattern-list (list (list new-pattern label)))))
         )
        (t
         (setf new-pattern-list 
               (append new-pattern-list (list (list  n-pattern-cycles new-pattern label))))))
       ;;end pattern = random
       )
     (t nil))
     ;;reset new-pattern
      (setf new-pattern nil)

    ;;randomize new-pattern-list??
    (cond
     ((equal randomize t)
      (setf new-pattern-list (organize-sublists new-pattern-list :randomize t)))
     (t nil))
    ;;end loop
    )
    (afout 'out (format nil "new-pattern-list= ~A" new-pattern-list))
  new-pattern-list
  ))


;;   (testpg)
#|
(defun testpg ()
  (setf out nil)
  (let*
      ((n-inputs 3)
       (pattern-list1 '((3 (1 0 1) "S1")(2(0 1 0) "S2"))) 
       (pattern-type1 'equal)
       ;;works, returns (((1 0 1) "S1") ((1 0 1) "S1") ((1 0 1) "S1") ((0 1 0) "S2") ((0 1 0) "S2"))
       ;;with randomize t returns (((1 0 1) "S1") ((1 0 1) "S1") ((0 1 0) "S2") ((1 0 1) "S1") ((0 1 0) "S2"))
       ;; with n-pattern-cyclesp t returns ((3 (1 0 1) "S1") (2 (0 1 0) "S2"))
       (pattern-list2 '((2 ((> .7)(< 0.3)(> 0.6))  "S1")(3 ((= 0.5)(> 0.8)(< 0.6))"S2" )))
       ;; w/or randomize works, returns (((0.92205954 0.16652395 0.84966165) "S1") ((0.92205954 0.16652395 0.84966165) "S1") ((0.5 0.9885243 0.2871696) "S2") ((0.5 0.9885243 0.2871696) "S2") ((0.5 0.9885243 0.2871696) "S2"))
       ;;w randomize t works, returns (((0.796799 0.16920913 0.96542407) "S1") ((0.5 0.97509367 0.1302892) "S2") ((0.796799 0.16920913 0.96542407) "S1") ((0.5 0.97509367 0.1302892) "S2") ((0.5 0.97509367 0.1302892) "S2"))
       ;;with num-cyclesp t works, returns ((2 (0.96480257 0.11676551 0.88210607) "S1") (3 (0.5 0.97711325 0.0067082406) "S2"))
       (pattern-type2 'formula)
       (result)
       )
  ;;  (setf result (ART-pattern-generator n-inputs pattern-list1 pattern-type1 :randomize t));; :num-cyclesp t))
    ;; works returns  ((1 0 1) (1 0 1) (1 0 1) (0 1 0) (0 1 0))
    (setf result (ART-pattern-generator n-inputs pattern-list2 pattern-type2 :num-cyclesp t))   ;; :randomize t))
   ;; (afout 'out (format nil "testpg result= ~A~%" result))
    (fout out)
    result
    ))
|#


 #|    (loop 
       for n from 1 to 10
       with x
       with y = '(99 98)
       do
       (setf x  (list 'a n))
       collect n
      ;; append y
       )|#
    


;;xxx --------------------------------------------- END MATERIAL -----------------------------------------
;;

;;SET-PATTERN
; Set up a learning pattern in the input neurons:
;;ddd
(defun set-pattern (pl nInputs nOutputs)
  "In ART-inputs, Sets up a learning pattern in the input nodes with random changes."
  (let
      ((len (length pl))
       )
  (cond
   ((not (equal len nInputs))
    (print (list "Error in setPattern input:" pl))
    (error "Error in setPattern input:")
      (setq *pattern-cycle-n 0)
      ;;(zero-activations nInputs nOutputs)
      )
   (t
      (loop
       for i from 1 to  len
       do
        (setsymval 'input (list i 1 1) (+ (pop pl) (frandom -0.08 0.08)))
      ;;end loop, t, cond
      )))
  ;;end let,setPattern
  ))










