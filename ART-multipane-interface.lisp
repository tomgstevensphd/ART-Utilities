;;******************************** ART-multipane-interface.lisp *****************
;;
;;
;;

;;config the editor
 (my-config-editor-after-start)


;;ART-MULTIPANE-INTERFACE
;;
;; NOTE: Tried making graph windows scrollable, finally worked putting the output-pane inside a simple-layout which could scroll.  Otherwise, top of graph was cut off.
;;However, using scrolling made it so slow that I decided only to scroll the larger frame and keep the windows to small size--having to adjust the y-axis output to fit the window.
;;
;;  
;;ddd
(capi:define-interface ART-multipane-interface ()
  ((input-points
    :initarg :input-points
    :accessor input-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (X-points
    :initarg :X-points
    :accessor X-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (XI-2-2-points
    :initarg :XI-2-2
    :accessor XI-2-2
    :initform nil
    :type  :list
    :documentation "temp storage")
   (XI-L-3-points
    :initarg :XI-L-3-points
    :accessor XI-L-3-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (YI-L-2-points
    :initarg :YI-L-2-points
    :accessor YI-L-2-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (YI-L-3-points
    :initarg :YI-L-3-points
    :accessor YI-L-3-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (YI-3-3-POINTS
    :initarg :YI-3-3-POINTS
    :accessor YI-3-3-POINTS
    :initform nil
    :type  :list
    :documentation "temp storage")
   (resetnin-points
    :initarg :resetnin-points
    :accessor resetnin-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (resetnout-points
    :initarg :resetnout-points
    :accessor resetnout-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (wup-points
    :initarg :wup-points
    :accessor wup-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (wdn-points
    :initarg :wdn-points
    :accessor wdn-points
    :initform nil
    :type  :list
    :documentation "temp storage")
 #|  (uup-points
    :initarg :uup-points
    :accessor uup-points
    :initform nil
    :type  :list
    :documentation "temp storage")
   (udn-points
    :initarg :udn-points
    :accessor udn-points
    :initform nil
    :type  :list
    :documentation "temp storage")|#
      )
  (:PANES
   ;;OUTPUT PANES
   (output-pane-1
    capi:output-pane
    :display-callback  'display-inputs-callback
    :visible-min-height 100
    :visible-max-height 100
    ;;works  :vertical-scroll t
    ;;works  :scroll-height 500
    ;;  :scroll-if-not-visible-p T  ;;NO EFFECT
    ;;   :scroll-vertical-page-size 400 ;;NO EFFECT
    ;;  :scroll-horizontal-page-size 400 ;;NO EFFECT
    :internal-min-width 680
    )
   #|(output-pane-2
    capi:output-pane
    :visible-min-height 130
    :visible-max-height 130
    :display-callback 'display-v-activity-callback)|#
   (output-pane-2
    capi:output-pane
    :visible-min-height 130
    :visible-max-height 130
    :display-callback  'display-XI-2-2-activity-callback)
   (output-pane-3
    capi:output-pane
    :visible-min-height 130
    :visible-max-height 130
    :display-callback 'display-wup-callback)
   (output-pane-4
    capi:output-pane
    :visible-min-height 130
    :visible-max-height 130
    :display-callback 'display-wdn-callback)
   (output-pane-5
    capi:output-pane
    :visible-min-height 130
    :visible-max-height 130
    :display-callback  'display-y-outputs-callback)
   (output-pane-6
    capi:output-pane
    :visible-min-height 60
    :visible-max-height 60
    :display-callback  'display-resets-callback)
   #|(output-pane-7
    capi:output-pane
    ;;define later  :display-callback 'display-inputs-callback
    )|#
   ;;RICH TEXT PANES
   (rich-text-pane-1
    capi:rich-text-pane
    :visible-min-height 110
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    :x 5
    :y 5)
   (rich-text-pane-2
    capi:rich-text-pane
    :visible-min-height 110
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    ;; :x 5    :y 5
    )
   (rich-text-pane-3
    capi:rich-text-pane
    :visible-min-height 145
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    ;; :x 5    :y 5
    )
   (rich-text-pane-4
    capi:rich-text-pane
    :visible-min-height 145
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    ;; :x 5    :y 5
    )
   (rich-text-pane-5
    capi:rich-text-pane
    :visible-min-height 100
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    ;; :x 5    :y 5
    )
   (rich-text-pane-6
    capi:rich-text-pane
    :visible-min-height 100
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    ;; :x 5    :y 5
    )
   (rich-text-pane-7
    capi:rich-text-pane
    :visible-min-height 132
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    ;; :x 5    :y 5
    )

   (rich-text-pane-out1
    capi:rich-text-pane
    :visible-min-height 30
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    ;; :x 5    :y 5
    )
   (rich-text-pane-out2
    capi:rich-text-pane
    :visible-min-height 10
    :visible-min-width 50
    ;; :scroll-if-not-visible-p T
    ;; :x 5    :y 5
    )
   ;;PUSH-BUTTON-PANELS--not used yet
   #| (push-button-panel-1
    capi:push-button-panel
    :cancel-button "Cancel"
    :help-key :help
    :items '("Button 1" "Button 2" "Button 3")
    :callbacks '(button-1-callback button-2-callback button-3-callback)
    :callback-type :interface
    ;; :scroll-if-not-visible-p t
    :toolbar-title "select"
    ;; :widget-name "widget"
    :selection-callback 'selection-callback1
    :visible-min-height 20
    :visible-min-width 300
    :background :green
    :foreground :black
    :horizontal-scroll t
    :visible-border t)

   (push-button-panel-2
    capi:push-button-panel
    :cancel-button "Cancel"
    :help-key :help
    :items '("Button 4" "Button 5" "Button 6")
    :callbacks '(button-4-callback button-5-callback button-6-callback)
    :callback-type :interface
    ;; :scroll-if-not-visible-p t
    :toolbar-title "select"
    ;; :widget-name "widget"
    :selection-callback 'selection-callback1
    :visible-min-height 20
    :visible-min-width 300
    :background :red
    :foreground :black
    :horizontal-scroll t
    :visible-border t)
   |#
   ;;end panes
   )

  ;;LAYOUTS
  (:layouts
   #|(simple-layout-1
    capi:simple-layout
    '(grid-layout-1)
    :X 0
    :Y 0
    ;;:vertical-scroll t
  ;;  :scroll-initial-y  240
    )|#
   (grid-layout-1
    capi:grid-layout
    '(column-layout-1 column-layout-2))
   (column-layout-1
    capi:column-layout
    '(output-pane-1 output-pane-2 output-pane-3 output-pane-4 output-pane-5 output-pane-6  rich-text-pane-out1) ;; output-pane-7 push-button-panel-1)
    ;;   :visible-min-height 1000
    ;;   :vertical-scroll T  ;;doesn't work
    ;;    :scroll-height 1000
    ;;  :scroll-vertical-page-size 1000
    ;; :scroll-if-not-visible-p T 
    )
   (Column-layout-2
    capi:column-layout
    '(rich-text-pane-1 rich-text-pane-2 rich-text-pane-3 rich-text-pane-4 rich-text-pane-5 rich-text-pane-6 rich-text-pane-7 rich-text-pane-out2) ;; push-button-panel-2)
    )
   #|  was used to scroll the output pane, but loading took too long
    (output-layout-3
    capi:simple-layout
    '(output-pane-3)
    :visible-min-height 130
    :scroll-height 400
    :vertical-scroll T)|#
   )
  (:menu-bar menu-1 menu-3 menu-4)
  (:menus
   (menu-4
    "Menu-4"
    ())
   (menu-3
    "Menu-3"
    ())
   (menu-2
    "Menu-2"
    ())
   (menu-1
    "Menu-1"
    (menu-2)))
  (:default-initargs
   ;; :best-height 700
   :best-width  1000
   :best-x 15
   :best-y -5
   :visible-min-height 750
   :external-max-height 800
   ;; :display-state 
   #|   :vertical-scroll T
    :scroll-height 1000
    :scroll-vertical-page-size 1000|#
   :scroll-if-not-visible-p T    
   :layout 'grid-layout-1  ;;or  'simple-layout-1
   :title "ART Output"
   ;;:iconify-callback 'ART-multipane-interface-inconify-callback
   ;;end ART-multipane-interface
   ))
  



;;GRAPH-ART
;;
;;ddd
(defun graph-ART (title &key (graph-var-slots *art-graph-var-slots ))                              
  "In ART--multipane-interface,"
;;  (setf out nil)
;;mmm1
 ;;(initialize-ART-data)
  (let*
      ((ART-instance);;  (title "new-instance-title") ; ;works   
       (main-slots '(output-pane-1 output-pane-2 output-pane-3 output-pane-4 
                               output-pane-5 output-pane-6  output-pane-7
                               rich-text-pane-1  rich-text-pane-2 rich-text-pane-3 rich-text-pane-4 
                               rich-text-pane-5 rich-text-pane-6 rich-text-pane-7))
       (graph-slots (append graph-var-slots  main-slots))
       )
    ;;(BREAK)
    (setf  ART-instance  (make-instance 'ART-multipane-interface :title title))

    (with-slots (eval graph-slots)  ART-instance ;;(art-inst-sym)  ;;was 

      ;;FOR INPUTS GRAPH
      (setf (slot-value ART-instance 'input-points) *inputI-1-1-points)
            
     ;; (display-inputs-callback  output-pane-1 0 0 100 100) ;; rich-text-pane-1 *input-points)
      ;;FOR XI-2-1 GRAPH  ;;was V-Activity GRAPH
      ;;(setf (slot-value ART-instance 'XI-2-1-points)  *XI-2-1-points) 
                        ;;was 'v-activity-points) *v-activity-points)
     ;; (display-v-activity-callback output-pane-2 0 0 100 100) ;;rich-text-pane-2 *v-activity-points)
      ;;FOR XI-2-2 GRAPH   ;; P GRAPH
      (setf (slot-value ART-instance 'XI-2-2-points) *XI-2-2-points)
            ;;was p) *p-points)
      ;;FOR WUP GRAPH
      (setf (slot-value ART-instance 'wup-points) *WUPI-3-2TOI-1-3-points)
    ;; (display-wup-callback  output-pane-3 0 0 100 100) ;; rich-text-pane-3 *wup-points)
      ;;FOR WDN GRAPH
      (setf (slot-value ART-instance 'wdn-points) *WDNI-1-3TOI-3-2-points)
    ;; (display-wdn-callback   output-pane-4 0 0 100 100);; rich-text-pane-4 *wdn-points)
    ;;LATER INCLUDE UUP AND UDN??
#|      ;;FOR UUP GRAPH
      (setf (slot-value ART-instance 'Uup-points) *UUPI-3-2TOI-1-3-points)
    ;; (display-Uup-callback  output-pane-3 0 0 100 100) ;; rich-text-pane-3 *Uup-points)
      ;;FOR UDN GRAPH
      (setf (slot-value ART-instance 'Udn-points) *UDNI-1-3TOI-3-2-points)
    ;; (display-Udn-callback   output-pane-4 0 0 100 100);; rich-text-pane-4 *Udn-points)|#

      ;;FOR YI-3-3-output GRAPH  ;;wasY-OUTPUT GRAPH
      (setf (slot-value ART-instance 'YI-3-3-points) *YI-3-3-POINTS)
      ;;(display-y-outputs-callback  output-pane-5 0 0 100 100) ;; rich-text-pane-5 *Y-POINTS)
      ;;FOR RESETS GRAPH SSS START HERE, FIX LATER
      (setf (slot-value ART-instance 'resetnin-points) *resetninI-2-2-points)
      (setf (slot-value ART-instance 'resetnout-points) *resetnoutI-2-2-points)

      ;;seems ok (setf *out-reset (append *out-reset (list (format nil "In graph-ART, Cycle= ~A; *reset-points= ~A~% slot reset-points= ~A" *art-learn-cycle-n  *reset-points (slot-value ART-instance 'reset-points)))))
     ;; (display-resets-callback output-pane-6 0 0 100 100) 
    ;;  (fout out)
    ;;end with-slots
      )
    
    ;;DISPLAY THE INSTANCE
    (capi:display ART-instance)

    ;;end let,graph-ART
    ))


;;ART-multipane-interface-INCONIFY-CALLBACK
;;
;;ddd
;;NOT NEEDED, SOLVED PROBLEM OF GETTING VARS RESET WHEN ICONIFYING BY STORING VALS INSIDE INSTANCE SLOTS
#|(defun ART-multipane-interface-inconify-callback (interface iconified-p)
  "In ART-multipane-interface. Interface calls it with iconified-p = T when iconified, iconified-p= NIL when restored. Use to restore contents of panes?? FINISH"
  (let
      ((graph-data )
       (text-win-data)  
       )
    (with-slots (input-points  v-activity-points wup-points wdn-points y-output-points reset-points) interface
      (when (null iconified-p)
      (setf *input-points (slot-value interface 'input-points)
            *wup-points (slot-value interface 'wup-points)
            *wdn-points (slot-value interface 'wdn-points)
            *y-output-points (slot-value interface 'y-output-points)
            *reset-points (slot-value interface 'reset-points))
            
     ;;(graph-ART-test "new-title" interface)

      ;;(setf  *out-icon (append *out-icon (list (format nil "FROM INSIDE ART-multipane-interface-inconify-callback, INTERFACE= ~A~% *input-points= ~A, ~%*y-output-points= ~A" interface *input-points *y-output-points))))
     
      ;;end when,with-slots
      ))
    ))|#





;; ttt --------------------------------  TEST AREA ----------------------------------
#|(defun graph-ART-X (title)
  "In ART--multipane-interface,"
;;  (setf out nil)
;;mmm1
 ;;(initialize-ART-data)
  (let*
      ((xx);;  (title "new-instance-title") ; ;works    
       )
    (setf *ART-instance  (make-instance 'ART-multipane-interface :title title))
    (capi:display *ART-instance)

    (with-slots (output-pane-1 output-pane-2 output-pane-3 output-pane-4 
                               output-pane-5 output-pane-6  output-pane-7
                               rich-text-pane-1  rich-text-pane-2 rich-text-pane-3 rich-text-pane-4 
                               rich-text-pane-5 rich-text-pane-6 rich-text-pane-7 ) *ART-instance

      ;;FOR INPUTS GRAPH
      ;;(display-inputs-callback  output-pane-1 0 0 100 100) ;; rich-text-pane-1 *input-points)
      ;;FOR V-Activity GRAPH
   ;;   (display-v-activity-callback output-pane-2 0 0 100 100) ;;rich-text-pane-2 *v-activity-points)
      ;;FOR WUP GRAPH
   ;;   (display-wup-callback  output-pane-3 0 0 100 100) ;; rich-text-pane-3 *wup-points)
      ;;FOR WDN GRAPH
    ;;  (display-wdn-callback   output-pane-4 0 0 100 100);; rich-text-pane-4 *wdn-points)
      ;;FOR Y-OUTPUT GRAPH
     ;; (display-y-outputs-callback  output-pane-5 0 0 100 100) ;; rich-text-pane-5 *Y-output-points)
      ;;FOR RESETS GRAPH
     ;; (display-resets-callback output-pane-6 0 0 100 100) 
    ;;  (fout out)
      )))|#
;;TEST
;;  (graph-ART-x "testx")


(defun testami ()
  (setf out nil)
  (let
      ((instance (make-instance 'ART-multipane-interface))
       )
    (capi:display instance)
    (fout out)
  ))

;; (testami)

;;;--NEXT MAKE SO WILL REDRAW WHEN ICONIFY MAXIMIZED
;;(setf  *ART-instance (make-instance 'ART-multipane-interface))
#|
(defun initialize-ART-data ()
  (setf 
   *I-points '((0 (40 0) "0") (1 (80 0.4) "1") (2 (120 0.9) "2") (3 (160 0.4) "3") (4 (200 0) "4"))
   *x-points '((0 (40 0) "0") (1 (80 0.4) "1") (2 (120 0.7) "2") (3 (160 0.4) "3") (4 (200 0.4) "4"))
   *wup-points '((0 (40 0) "0") (1 (80 0.2) "1") (2 (120 0.3) "2") (3 (160 0.2) "3") (4 (200 0.1) "4"))
   *wdn-points '((0 (40 0) "0") (1 (80 0.0) "1") (2 (120 0.1) "2") (3 (160 0.4) "3") (4 (200 0.2) "4"))
   *y-points  '((0 (40 0) "0")  (1 (80 1.0) "1")  (2 (120 0) "2"))
   *I-cell-list '(In0 In1 In2 In3 In4)
   *x-list '(x0 x1 x2 x3 x4)
   *wup-list '(wu0 wu1 wu2 wu3 wu4)
   *wdn-list '(wd0 wd1 wd2 wd3 wd4)
   *Y-cell-list '(y1 y2 y3))
  )

(defun testai ()
  (setf out nil)
  (initialize-ART-data)
  (let*
      ((x)
    
       )
    (setf *ART-instance  (make-instance 'ART-multipane-interface))
    (capi:display *ART-instance)
    (with-slots (output-pane-1 output-pane-2 output-pane-3 output-pane-4 
                               output-pane-5 output-pane-6  output-pane-7
                               rich-text-pane-1  rich-text-pane-2 rich-text-pane-3 rich-text-pane-4 
                               rich-text-pane-5 rich-text-pane-6 rich-text-pane-7 ) *ART-instance
      ;;FOR INPUTS GRAPH
      (display-inputs-callback  output-pane-1 0 0 100 100) ;; rich-text-pane-1 *I-points)
      ;;FOR V-Activity GRAPH
      (display-v-activity-callback output-pane-2 0 0 100 100) ;;rich-text-pane-2 *x-points)
      ;;FOR W-UP GRAPH
      (display-wup-callback  output-pane-3 0 0 100 100) ;; rich-text-pane-3 *wup-points)
      ;;FORW-DOWN GRAPH
      (display-wdn-callback   output-pane-4 0 0 100 100);; rich-text-pane-4 *wdn-points)
      ;;FOR Y-OUTPUT GRAPH
      (display-y-outputs-callback  output-pane-5 0 0 100 100) ;; rich-text-pane-5 *Y-points)
      (fout out)
      )))
|#

;;---------------------------------------------
;;FOR INPUTS GRAPH
;ddd
(defun  display-inputs-callback (output-pane-1 x y width height)  
;;NOTE: rich-text-pane-1NOT ok even tho referenced inside of WITH-SLOTS, if not add from display-callback ex in hhh help section below (or use *ART-instance??)
   ;;(initialize-ART-data)
   (incf *art-graph-win-counter)
   (let
       ((self (capi:top-level-interface output-pane-1))
        (input-points1)
        ;;(self  (my-make-new-symbol *art-graph-win-root *art-graph-win-counter))
        )
     ;;(set self (capi:top-level-interface output-pane-1))
   (with-slots (rich-text-pane-1 input-points) self ;;  (eval self ) ;;was  ;;was *ART-instance ;; (CAPI:TOP-LEVEL-INTERFACE output-pane-1)
     ;;(setf (slot-value self  'input-points) *input-points)
     (setf input-points1 (slot-value self 'input-points))
     ;;main function
      (write-to-graph+text-pane  self output-pane-1 rich-text-pane-1
                       input-points1  ;;was *input-points  
                       *x-max 70 50 30 :begin-num 0 
                         :label-margin 10 :graph-color :orange
                     :x-mark-interval 40 :y-mark-interval 10  :half-hash-length 3 
                     :label-margin 10
                           :x-edit-pane-label "INPUT DATA: "
                             :y-label-list nil
                             ;;not needed? :x-increment  20 
                             :y-increment  1.00
                            :x-label-color  :black  :y-label-color :black
                             :x-string "INPUT Cells" 
                             :y-string "" ;; '("AA" "BB" "CC" "DD" "YY")
                              :x-string-margin 30 :y-element-space 10
                              :x-string-color :red   :y-string-color :blue
                              :center-x-string-p t  :center-y-string-p t
                              :scale-to-y-max-val-p T
                              :x-multiplier 1.0  :y-multiplier 1.0  :y-floor-value 0)
   ;;end with-slots,let, display-inputs-callback
   )))


;;FOR XI-2-2-ACTIVITY GRAPH
;;
;;ddd
(defun display-XI-2-2-activity-callback (output-pane-2 x y width height)
   ;;(initialize-ART-data)
   (let
       ((self (capi:top-level-interface output-pane-2))
        )
   (with-slots (rich-text-pane-2  XI-2-2-POINTS) self ;;was *ART-instance ;; (CAPI:TOP-LEVEL-INTERFACE output-pane-2)
    ;; (setf (slot-value self  'v-activity-points) *v-activity-points)
      (write-to-graph+text-pane self  output-pane-2 rich-text-pane-2
       (slot-value self 'XI-2-2-POINTS)  ;;was *v-activity-points
       *x-max 100 50 30 :begin-num 0 
                         :label-margin 10 :graph-color :red 
                     :x-mark-interval 40 :y-mark-interval 10  :half-hash-length 3 
                     :label-margin 10
                            :x-edit-pane-label " F2-Activity DATA:" ;;*x-list
                             :y-label-list nil
                             ;;not needed? :x-increment  20 
                             ;;SSS  STOPPED PRINTING 10 20 30 ... ON Y-AXIS AFTER
                             ;; I CHANGED THE *N-OUTPUTS TO A LOCAL VAR &
                             ;; RELATED CHANGES -- FIX THIS
                             :y-increment  *v-activity-y-increment  ;;= 1.0?
                            :x-label-color :black :y-label-color :black
                             :x-string "F2-Activity STM Cells" 
                             :y-string "" ;; '("AA" "BB" "CC" "DD" "YY")
                              :x-string-margin 30 :y-element-space 10
                              :x-string-color :red  :y-string-color :blue
                              :center-x-string-p t :center-y-string-p t
                              :scale-to-y-max-val-p T
                              :x-multiplier 1.0  :y-multiplier 1.0  :y-floor-value 0);;y was 50
      ;;end with-slots, let, display-v-activity-callback
      )))

#|
;;FOR X ACTIVITY
;;
;;ddd
(defun display-XI-2-2-activity-callback (output-pane-2 x y width height)
   ;;(initialize-ART-data)
   (let
       ((self (capi:top-level-interface output-pane-2))
        )
   (with-slots (rich-text-pane-2  p-points) self ;;was *ART-instance ;; (CAPI:TOP-LEVEL-INTERFACE output-pane-2)
    ;; (setf (slot-value self  'p-points) *p-points)
      (write-to-graph+text-pane self  output-pane-2 rich-text-pane-2
       (slot-value self 'XI-2-2-points)  ;;was *p-points
       *x-max 100 50 30 :begin-num 0 
                         :label-margin 10 :graph-color :red 
                     :x-mark-interval 40 :y-mark-interval 10  :half-hash-length 3 
                     :label-margin 10
                            :x-edit-pane-label " P DATA:" ;;*x-list
                             :y-label-list nil
                             ;;not needed? :x-increment  20 
                             ;;SSS  STOPPED PRINTING 10 20 30 ... ON Y-AXIS AFTER
                             ;; I CHANGED THE *N-OUTPUTS TO A LOCAL VAR &
                             ;; RELATED CHANGES -- FIX THIS
                             :y-increment  *v-activity-y-increment  ;;= 1.0?
                            :x-label-color :black :y-label-color :black
                             :x-string "P STM Cells" 
                             :y-string "" ;; '("AA" "BB" "CC" "DD" "YY")
                              :x-string-margin 30 :y-element-space 10
                              :x-string-color :red  :y-string-color :blue
                              :center-x-string-p t :center-y-string-p t
                              :scale-to-y-max-val-p T
                              :x-multiplier 1.0  :y-multiplier 1.0  :y-floor-value 0);;y was 50
      ;;end with-slots, let, display-XI-2-2-activity-callback
      )))|#


;;FOR W-UP GRAPH
(defun display-wup-callback  (output-pane-3 x y width height)
   ;;(initialize-ART-data)
   (let
       ((self (capi:top-level-interface output-pane-3))
        (wup-points1)
        )
   (with-slots (rich-text-pane-3 wup-points) self ;;was *ART-instance ;; (CAPI:TOP-LEVEL-INTERFACE output-pane-3)
     (setf wup-points1 (slot-value self 'wup-points))
     ;;main function
      (write-to-graph+text-pane self    output-pane-3 rich-text-pane-3
       wup-points1 ;;was *wup-points  
       *x-max 100 40 30  ;;was 20 20
       :multiple-graphs-p t
       :begin-num 0 
                         :label-margin 10 :graph-color :blue 
                     :x-mark-interval 40 :y-mark-interval 10  :half-hash-length 3 
                     :label-margin 10
                            :x-edit-pane-label "Wup DATA:"
                             :y-label-list nil
                             ;;not needed? :x-increment  20 
                             :y-increment 1.0 ;;was 10.0
                            :x-label-color :black :y-label-color :black
                             :x-string "Wup (Weights-LTM)"
                             :y-string "" ;; '("AA" "BB" "CC" "DD" "YY")
                              :x-string-margin 30 :y-element-space 10
                              :x-string-color :red :y-string-color :blue
                              :center-x-string-p t :center-y-string-p t
                              :scale-to-y-max-val-p T
                              :x-multiplier 1.0  :y-multiplier 1.0 :y-floor-value 0
                              :display-instance-p NIL)
   ;;end with-slots, let, display-wup-callback
   )))

;;FORW-DOWN GRAPH
(defun display-wdn-callback (output-pane-4  x y width height)
  ;;(initialize-ART-data)
  (let
      ((self (capi:top-level-interface output-pane-4))
       (wdn-points1)        
       )
     
    (with-slots (rich-text-pane-4 wdn-points) self ;;was *ART-instance ;;(CAPI:TOP-LEVEL-INTERFACE output-pane-4)
      (setf wdn-points1 (slot-value self 'wdn-points))
      ;;main function
      (write-to-graph+text-pane self    output-pane-4 rich-text-pane-4
                                wdn-points1 ;;*wdn-points  
                                *x-max 100 50 30
                                :multiple-graphs-p T    :begin-num 0 
                                :label-margin 10 :graph-color :green 
                                :x-mark-interval 40 :y-mark-interval 10  :half-hash-length 3 
                                :label-margin 10
                                :x-edit-pane-label "Wdn DATA:"
                                :y-label-list nil
                                ;;not needed? :x-increment  20 
                                :y-increment 1.0  ;;was 10.0
                                :x-label-color :black :y-label-color :black
                                :x-string "W Down (Weights-LTM)" 
                                :y-string "" ;; '("AA" "BB" "CC" "DD" "YY")
                                :x-string-margin 30 :y-element-space 10
                                :x-string-color :red :y-string-color :blue
                                :center-x-string-p t :center-y-string-p t
                                :scale-to-y-max-val-p T
                                :x-multiplier 1.0  :y-multiplier 1.0 :y-floor-value 0
                                :display-instance-p NIL)
      ;;end with-slots, let, display-wdn-callback
      )))


;;FOR Y-OUTPUT GRAPH
(defun display-y-outputs-callback (output-pane-5 x y width height)
   ;;(initialize-ART-data)
   ;; (incf *art-graph-win-counter)
   (let
       ((self (capi:top-level-interface output-pane-5))
        (Y-POINTS1)
        ;;(self  (my-make-new-symbol *art-graph-win-root *art-graph-win-counter))
        )
     ;;(set self (capi:top-level-interface output-pane-5))
   (with-slots (rich-text-pane-5 YI-3-3-POINTS)  self ;;was self ;;was *ART-instance ;;(CAPI:TOP-LEVEL-INTERFACE output-pane-5)
     (setf Y-POINTS1 (slot-value self  'YI-3-3-POINTS))
     ;;main function
      (write-to-graph+text-pane (eval self)   output-pane-5 rich-text-pane-5
       Y-POINTS1   ;;*Y-POINTS
       *x-max 100 50 30 :begin-num 0 
                         :label-margin 10 :graph-color :red 
                     :x-mark-interval 40 :y-mark-interval 10  :half-hash-length 3 
                     :label-margin 10
                            :x-edit-pane-label "Y-OUTPUT DATA:"
                             :y-label-list nil
                             ;;not needed? :x-increment  20 
                             :y-increment 1.0 ;;was 10.0
                            :x-label-color :black :y-label-color :black
                             :x-string "Y-OUTPUT Cells" 
                             :y-string "" ;; '("AA" "BB" "CC" "DD" "YY")
                              :x-string-margin 30 :y-element-space 10
                              :x-string-color :red :y-string-color :blue
                              :center-x-string-p t :center-y-string-p t
                              :scale-to-y-max-val-p T
                              :x-multiplier 1.0  :y-multiplier 1.0  :y-floor-value 0
                              :display-instance-p NIL)
   ;;end with-slots, let, display-y-outputs-callback
   )))


;;  works  (txx 5) returns 7
#|(defun txx (x &key (key1 7))
  key1)|#  

;;DISPLAY-RESETS-CALLBACK
;;
;;ddd
(defun display-resets-callback (output-pane-6 x y width height)
   ;;(initialize-ART-data)
   (let
       ((self (capi:top-level-interface output-pane-6))
        (reset-points1)
        (reset-points2)
        )
   (with-slots (rich-text-pane-6 resetnin-points resetnout-points) self ;;was *ART-instance ;;(CAPI:TOP-LEVEL-INTERFACE output-pane-5)
     (setf reset-points1 (slot-value self  'resetnin-points)
           reset-points2 (slot-value self  'resetnout-points))
     ;;main function
      (write-to-graph+text-pane  self  output-pane-6 rich-text-pane-6
       reset-points1  ;;was
        *x-max 25 30 30 :begin-num 0 
                         :multiple-graphs-p  T :append-point-list reset-points2
                         :label-margin 10 :graph-color :red 
                     :x-mark-interval 40 :y-mark-interval 10  :half-hash-length 3 
                     :label-margin 10
                            :x-edit-pane-label "RESET DATA:" ;; sss change to reset0 etc
                             :y-label-list nil
                             ;;not needed? :x-increment  20 
                             :y-increment 1.0 ;;was  .20
                            :x-label-color :black :y-label-color :black
                             :x-string "RESET Cells" 
                             :y-string "" ;; '("AA" "BB" "CC" "DD" "YY")
                              :x-string-margin 30 :y-element-space 10
                              :x-string-color :red :y-string-color :blue
                              :center-x-string-p t :center-y-string-p t
                              :scale-to-y-max-val-p T
                              :x-multiplier 1.0  :y-multiplier 1.0 :y-floor-value 0
                              :display-instance-p NIL)
   ;;end with-slots, let, display-resets-callback
   )))




;;WRITE-TO-GRAPH+TEXT-PANE
;;
;;ddd
(defun write-to-graph+text-pane (ART-instance output-pane rich-text-pane 
                                             point-list x-max y-max x-margin y-margin 
                                             &key multiple-graphs-p  append-point-list
                                             begin-num  label-margin graph-color
                                             x-mark-interval  y-mark-interval  half-hash-length  
                                             label-margin
                                             x-label-color  y-label-color
                                             x-edit-pane-label  y-label-list
                                             x-increment  y-increment
                                             x-string y-string x-string-margin y-element-space 
                                             (x-font-list '(:family "Times New Roman" 
                                                            :weight 'normal :size 5))
                                             (y-font-list '(:family "Times New Roman" 
                                                            :weight 'normal :size 6))
                                             (text-pane-font-list '(:family "Times New Roman" 
                                                            :weight 'normal :size  9))                                  
                                             x-string-color y-string-color
                                             center-x-string-p   center-y-string-p
                                             x-multiplier (y-multiplier 1.0)  y-floor-value
                                             display-instance-p
                                             (find-x-incr-p T)
                                             (scale-to-y-max-val-p T)
                                             )  
  "In ART-multipane-interface.lisp, writes a graph to output-pane and text-info 
     to rich-text-pane  ARGS:   ART-instance output-pane rich-text-pane 
                                             point-list x-max y-max x-margin y-margin 
                                             &key multiple-graphs-p  append-point-list
                                             begin-num  label-margin graph-color
                                             x-mark-interval  y-mark-interval  half-hash-length  
                                             label-margin
                                             x-label-color  y-label-color
                                             x-edit-pane-label  y-label-list
                                             x-increment  y-increment
                                             x-string y-string x-string-margin y-element-space 
                                             (x-font-list '(:family \"Times New Roman\"
                                                            :weight 'normal :size 5))
                                             (y-font-list '(:family \"Times New Roman\"
                                                            :weight 'normal :size 6))
                                             (text-pane-font-list '(:family  \"Times New Roman\"
                                                            :weight 'normal :size  9))                                  
                                             x-string-color y-string-color
                                             center-x-string-p   center-y-string-p
                                             x-multiplier (y-multiplier 1.0)  y-floor-value
                                             display-instance-p
                                             (find-x-incr-p T)
                                             (scale-to-y-max-val-p T)
                            x-multiplier y-multiplier :Y-FLOOR-VALUE won't allow y value below y-floor-value if not nil.  NOTE: Put cell-list in x-label-list. INPUT point-list eg.  Eg. 1-dim: *INPUT-POINTS = (((1) (40 0.11) \"input1\") ... ((3) (120 0.33) \"input3\")), for 2-dim: *WUP-POINTS = ((:DIMSIM 1 ((1 (40 0.11) \"wup1-1\" (1 1)) (1 (80 0.12) \"wup1-2\" (1 2)))) (:DIMSIM 1 ((1 (40 0.12) \"wup1-2\" (1 2)) (2 (80 0.22) \"wup2-2\" (2 2)))))."

  ;;no display outside function??  (if display-instance-p  (capi:display interface-instance))
  (let
      (( info-text)
       (x-label-list)
       (point-label-list)
       (point-value-list)
       (y-value-list)
       (max-value)
       (point-list1)
       )

    ;;added 2016-01
    (when append-point-list
        (cond
         ((equal (caar point-list) :dimsim)
          (setf point-list (append point-list 
                                   (list (list :dimsim (incf (length point-list))) append-point-list))))
         (t 
           (setf point-list (list (list :dimsim 1 point-list)(list :dimsim 2 append-point-list))))))


  ;;FIND NEEDED PARAMETERS FOR
   ;;         DRAW-GRAPH-WINDOW & TEXT PANE
  ;;Find the x-incr to make x-axis marks/labels
  (when find-x-incr-p
    (loop
     for item in point-list
     do
     (let
         ((point1)
          (point2)
          (x1pix)
          (x2pix)
          )
       ;;if item is a dimlist
       (when (equal (car item) :dimsim)
         (setf point-list1 (third item)
               item (third point-list1)))

      ;;added
#|      (when (listp (car item))
        (setf  item (car item)))|#

       (when (listp item)
       (cond 
        ((and (null point1) (listp item))
         (setf  point1 item
                x1pix (car (second item))))
        ((null point2)
         (setf point2 item
               x2pix (car (second item))
               x-mark-interval (- x2pix x1pix))
         (return))
        (t nil))
       ;;end let,loop,when,when
       ))))

  ;;WRITE TEXT TO RICH-TEXT-PANE
  (multiple-value-setq ( info-text MAX-VALUE point-label-list point-value-list)
      (write-cell-text rich-text-pane  point-list :pane-label x-edit-pane-label
                       :graph-color-list *graph-color-list
                     ;;  :font-list text-pane-font-list
                       ))

  ;;IF scale-to-y-max-val-p, CALCULATE THE Y-HEIGHT/SCALING FOR WINDOW 
  ;; Use  MAX-VALUE (of all graph values) to adjust the y-multiplier
  ;; Normally y-multiplier arg = 1.0, pixels in graph  (y-max only deals with axis)
  ;; y-max is usually 100, the number of pixels on y-axis
  (when scale-to-y-max-val-p
    (if (= max-value 0)(setf max-value 0.000001))
    (setf  y-multiplier (* y-multiplier (/  y-max  max-value)))
    ;;adjust y-values also    
    (if (= y-multiplier 0)(setf y-multiplier 0.000001))
    (setf y-increment (* 10 (/ y-increment y-multiplier))))           

  ;;DRAW GRAPH IN OUTPUT-PANE
  (draw-graph-window output-pane  point-list  
                     x-max  y-max  x-margin  y-margin
                     :multiple-graphs-p multiple-graphs-p
                     ;;not needed bec new point-list created above  :append-point-list append-point-list
                     :graph-color-list *graph-color-list :graph-color (car *graph-color-list)
                     :begin-num begin-num
                     :label-margin label-margin 
                     :x-mark-interval x-mark-interval :y-mark-interval y-mark-interval 
                     :half-hash-length half-hash-length 
                     :label-margin label-margin
                     :x-label-list  point-label-list ;; x-label-list
                     :y-label-list nil  ;;was y-value-list, too long!
                     :x-increment  x-increment :y-increment  y-increment
                     :x-font-list x-font-list :y-font-list y-font-list
                     :x-label-color x-label-color :y-label-color y-label-color
;; y-string is actually "" at this point most of the time, so gets values later
                     :x-string x-string :y-string y-string 
                     :x-string-margin x-string-margin :y-element-space y-element-space
                     :x-string-color x-string-color :y-string-color y-string-color
                     :center-x-string-p center-x-string-p 
                     :center-y-string-p center-y-string-p
                     :x-multiplier x-multiplier  :y-multiplier y-multiplier
                     :y-floor-value y-floor-value
                     )
;;test
;;   (draw-graph-window nil '((:dimsim 1 ((0 (50 30) "P1")(1 (100 200) "P2")(3 (150 75)"P3")(4 (200 300)"P4"))))  400 400 100 100) = works

  ;;end let, write-to-graph+text-pane
  ))

#|
;;original version--works well for one pane
(defun testai ()
  (setf out nil)
  (setf *point-list *input-points)
  (let
      ((ART-instance (make-instance 'ART-multipane-interface))
       )
    (capi:display ART-instance)
    (with-slots (output-pane-1 output-pane-2 output-pane-3 output-pane-4 output-pane-5
                                            output-pane-6  output-pane-7
                        rich-text-pane-1  rich-text-pane-2 rich-text-pane-3 rich-text-pane-4 
                        rich-text-pane-5 rich-text-pane-6 rich-text-pane-7 ) ART-instance
      
      (draw-graph-window output-pane-1  *point-list     250 60 50 20 :begin-num 0 
                         :label-margin 10 :graph-color :blue 
                     :x-mark-interval 40 :y-mark-interval 10  :half-hash-length 3 
                     :label-margin 10
                            :x-label-list '(c0 c1 c2 c3 c4)
                             :y-label-list nil
                             ;; :x-increment  10 
                             :y-increment  .20
                            :x-label-color :black :y-label-color :black
                             :x-string "ART Cells" 
                             :y-string "" ;; '("AA" "BB" "CC" "DD" "YY")
                              :x-string-margin 30 :y-element-space 10
                              :x-string-color :red :y-string-color :blue
                              :center-x-string-p t :center-y-string-p t
                              :x-multiplier 1.0  :y-multiplier 50)

      (write-cell-text rich-text-pane-1 '(C0 C1 C2 C3 C4) *point-list)

        (fout out)
        )))
|#








;; HHH ----------------------------------------------- HELP SECTION ---------------------------------

    ;;works     (multiple-value-bind (a b)  (values-list  '(this that)) (values a b))
 ;;works  (multiple-value-bind (a b) (values 1 2) (setf this 77)  (values a b))
;;example-works  (multiple-value-setq  (a b c)  (eval (append `(values)  (list 1 2 3))))
;;(values-list '(a b)) = a b

#|
(setq collector (capi:contain
                 (make-instance 'capi:collector-pane)))
  (setq *test-stream*
      (capi:collector-pane-stream collector))
(capi:contain
 (make-instance 'capi:collector-pane
                :stream *test-stream*))
(format *test-stream* "Hello World~%")
;;Finally, this example shows how to create a collector pane
;;onto the â€œBackground Outputâ€ stream.
(capi:contain (make-instance 'capi:collector-pane
                             :buffer-name "Background Output"))
|#


;;-------------------------------------  FORMAT ITERATION ----------------------------

#|
XXX
22.3.7.4 TILDE LEFT-BRACE: ITERATION

~{str~}

This is an iteration construct. The ARGUMENT SHOULD BE A LIST, which is used as a set of arguments AS IF FOR A RECURSIVE CALL TO FORMAT. The string STR is used repeatedly as the control string. 
EACH ITERATION CAN ABSORB AS MANY ELEMENTS OF THE LIST AS IT LIKES AS ARGUMENTS; if str uses up two arguments by itself, then two elements of the list will get used up each time around the loop.
 IF BEFORE ANY ITERATION STEP THE LIST IS EMPTY, then the iteration is TERMINATED. 
Also, if a PREFIX PARAMETER N is given, then there will be AT MOST N REPETITIONS of processing of str.
 Finally, the ~^ DIRECTIVE CAN BE USED TO TERMINATE THE ITERATION PREMATURELY.

For example:

 (format nil "The winners are:~{ ~S~}." 
         '(fred harry jill)) 
=>  "The winners are: FRED HARRY JILL."                           
 (format nil "Pairs:~{ <~S,~S>~}." 
         '(a 1 b 2 c 3))
=>  "Pairs: <A,1> <B,2> <C,3>."

me works: :(format nil "Testing ~{Inside this ~S,,more here ~S end.    ~}" '(1 2 3 4 5 6))
=> "Testing Inside this 1,,more here 2 end.    Inside this 3,,more here 4 end.    Inside this 5,,more here 6 end.  

~:{str~} is similar, but the argument should BE A LIST OF SUBLISTS. At each repetition step, one sublist is used as the set of arguments for processing str; on the next repetition, a new sublist is used, whether or not all of the last sublist had been processed. For example:

 (format nil "Pairs:~:{ <~S,~S>~} ." 
                 '((a 1) (b 2) (c 3)))
=>  "Pairs: <A,1> <B,2> <C,3>."
~@{str~} is similar to ~{str~}, but INSTEAD OF USING ONE ARGUMENT THAT IS A LIST, ALL THE REMAINING ARGUMENTS ARE USED AS THE LIST OF ARGUMENTS for the iteration. ME- ABOVE LIST VERSION IS '(a 1 b 2 c 3), here NON-LIST VERSION 'a 1 'b 2 'c 3
 Example:
 (format nil "Pairs:~@{ <~S,~S>~} ." 'a 1 'b 2 'c 3)
=>  "Pairs: <A,1> <B,2> <C,3>."
If the iteration is terminated before all the remaining arguments are consumed, then any arguments not processed by the iteration remain to be processed by any directives following the iteration construct.
~:@{str~} combines the features of ~:{str~} and ~@{str~}. All the remaining arguments are used, and each one must be a list. On each iteration, the next argument is used as a list of arguments to str. Example:

 (format nil "Pairs:~:@{ <~S,~S>~} ." 
              '(a 1) '(b 2) '(c 3)) 
=>  "Pairs: <A,1> <B,2> <C,3>."
Terminating the repetition construct with ~:} instead of ~} forces str to be processed at least once, even if the initial list of arguments is null. However, this will not override an explicit prefix parameter of zero.
If str is empty, then an argument is used as str. It must be a format control and precede any arguments processed by the iteration. As an example, the following are equivalent:

    (apply #'format stream string arguments)
 ==  (format stream "~1{~:}" string arguments)
This will use string as a formatting string. The ~1{ says it will be processed at most once, and the ~:} says it will be processed at least once. Therefore it is processed exactly once, using arguments as the arguments. This case may be handled more clearly by the ~? directive, but this general feature of ~{ is more powerful than ~?.
|#

;; Writer in function was following text
#|     (let 
          ((cell-list '(c0 c1 c2 c3 c4))
           (value)
           (value-list)
           )
        (dolist (point *point-list)
          (setf value (second (second point))
                value-list (append value-list (list value))))
        (eval `(multiple-value-setq ,cell-list  ,(append `(values)  value-list)))
            
        ;;example-works  (multiple-value-setq (a b c)  (eval (append `(values)  (list 1 2 3))))
          
        (setf (capi:rich-text-pane-text rich-text-pane-1) (format nil 
                                                 "     INPUT-X: ~%C0= ~A  C1= ~A  C2= ~A  C3= ~A  C4= ~A~%"  c0 c1 c2 c3 c4))
|#

;;XXX ------------------------- SWITCHABLE LAYOUTS ------------------
#|
7.5.1 SWITCHABLE LAYOUTS (in CapiUserMan)
A switchable layout allows you to place CAPI objects on top of one another
and determine which object is displayed on top through Lisp code, possibly
linked to a button or menu option through a callback. Switchable layouts are
set up using a switchable-layout element in a make-instance. As with the
other layouts, such as column-layout and row-layout, the elements to be
organized are given as a list to the :description keyword. Here is an example:
|#
#|
(defun testsw ()
  (setq red-pane (make-instance 'capi:output-pane
                                :background :red))
  (setq green-pane (make-instance 'capi:output-pane
                                  :background :green))
  (setq blue-pane (make-instance 'capi:output-pane
                                 :background :blue))

  ;;now for the switchable-layout
  (setq switching-panes (make-instance
                         'capi:switchable-layout
                         :description (list  green-pane red-pane)))
  (capi:contain switching-panes))
||#
;; XXX ------------- CREATING "PERMENANT" OUTPUT" in output-pane
;; 
#|
Call that output paneâ€™s display-callback function, passing it the
output-pane and the region in question.
For example, to create a pane that has a permanent circle drawn inside it, do
the following:
|#
;;this works--keeps circle if minimized
#|
(defun draw-a-circle (pane x y
                           width height)
  (gp:draw-circle pane 100 100 50))
(capi:contain
 (make-instance
  'capi:output-pane
  :display-callback 'draw-a-circle)
 :best-width 300
 :best-height 300)
|#
#|
Notice that the callback in this example ignores the region that needs redrawing
and just redraws everything. This is possible because the CAPI clips the
drawing to the region that needs redisplaying, and hence only the needed part
of the drawing gets done. For maximum efficiency, it would be better to only
draw the minimum area necessary.
|#
#| xxx
Initargs :DISPLAY-CALLBACK
Called to display the object.
Accessors drawn-pinboard-object-display-callback
Description The display-callback is called with
 the OUTPUT PANE to draw on,
the DRAWN-PINBOARD-OBJECT itself, and the X, Y, WIDTH AND
HEIGHT of the object, and it is expected to redraw that section.
The display-callback should not draw outside the objectâ€™s
bounds.
An alternative way of doing this is to create a subclass of
pinboard-object and to provide a method for draw-pinboard-
object.
FROM LW EXAMPLES
example of a display-callback ARGs (also note how they referenced the 
superordinate INTERFACE.
(defun display-test-image-functions (PANE X Y WIDTH HEIGHT)
  (with-slots (image) (CAPI:TOP-LEVEL-INTERFACE pane)

|#
