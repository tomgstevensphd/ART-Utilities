;;*********************************SHAQ-top-classes.lisp *******************************
;;MOVED TOP-CLASS TO CLASSES-PERSIIM



;;(defun my-defclass (class-sym superclasses slot-spec-list &key class-options  instance-initargs)
  "in u-clos,lisp, like defclass, except adds slots, parents, children. makes a class instance called *classname-inst and fills in parents slot with superclass; also esauto defines accessors for all slots in slot-list. default-args is used to set the class instance slot-values. it makes a slot by creating a slot-spec that writes in (:initarg :name     :accessor name ) and appends any added slot-keys such as   :initform initial top-class name :documentation name. instance-initargs adds these "
#|(my-defclass new-class4 
                           (class1 class2) 
                           ((new-slot1 :documentation "test docs1" :initform 99) 
                            (new-slot2  :documentation "test docs2"))
                           (:default-initargs :new-slot2 'init-value2) 
                           (:documentation "this is the class doc"))|#



(my-defclass per-biog (persim)
             (
              ;;SSS START HERE -- RENAME WITH SPSS VAR NAMES -- PUT THESE NAMES AS OLD IN DOC???
              (name    :documentation "full name":type :string) ;;   :initform "initform")
              (first-name    :documentation "first-name" :type :string) ;;  :initform "initform")
              (middle-name    :documentation "middle-name":type :string) ;;   :initform "initform")
              (last-name    :documentation "last-name":type :string) ;;  :initform "initform")
              (user-id    :documentation "user-id string" :type :string) ;;  :initform "initform")
              (age   :documentation "age"  :initform :type :integer )
              (age-string    :documentation "age-string":type :string) ;;  :initform "initform")
              (ethnic-int    :documentation "ethnic-int 0"  :type :integer) ;;:initform "initform")
              (ethnic-name :documentation "ethnic-name"  :type :string) ;; )
              (sex-int    :documentation "sex-int -male 1-female??" :type :integer) ;;  :initform "initform")
              (sex  :documentation "sex--male or female string") ;;:initform "initform")
              (usa    :documentation "usa" :type :boolean) ;; :initform T)
              (zipcode   :documentation "zipcode string" :type :string) ;; :initform "initform")
              (nation   :documentation "nation" :type :string) ;;   :initform "initform")
              (date    :documentation "date"  :type :string) ;;  :initform "initform")
              (email    :documentation "email" :type :string) ;;   :initform "initform")
              (email2    :documentation "email2"  :type :string) ;;  :initform "initform")
              ;;BIOGRAPHICAL DATA
              (marital-status    :documentation "marital-status " :type :integer) ;; :initform "initform")
              (occcupation-code    :documentation "occcupation-code "  :initform "initform")
              (education-level    :documentation "education-level "  :initform "initform")
              (annual-income   :documentation " "  :initform "initform")
              (hourswk   :documentation "hours work/week "  :initform "initform")
              (hourswk-string    :documentation "hours work/week string "  :initform "initform")
              ;;USER TYPE INFO
              (wants-selfhelp   :documentation "wants-selfhelp ":type :boolean  :initform false)
              (experienced-selfhelp    :documentation "experienced-selfhelp ":type :boolean  :initform false)
              (previous-user    :documentation "previous-user ":type :boolean  :initform false)
              (wants-thorough    :documentation "wants-thorough ":type :boolean  :initform false)
              (wants-speed   :documentation "wants-speed ":type :boolean  :initform false)
              (working-adult    :documentation "working-adult ":type :boolean  :initform false)
              (retired    :documentation "retired ":type :boolean  :initform false)
              (U100    :documentation "U100 ":type :boolean  :initform false)
              (credit-csulb    :documentation "credit-csulb ":type :boolean  :initform false)
              (credit-other    :documentation "credit-other ":type :boolean  :initform false)
              (college-student-other    :documentation "college-student-other ":type :boolean  :initform false)
              (academic-help-only    :documentation "academic-help-only ":type :boolean  :initform false)
              (research-subject    :documentation "research-subject ":type :boolean  :initform false)
              (faculty-or-administrator    :documentation "faculty-or-administrator ":type :boolean  :initform false)
              (course-credit    :documentation "course-credit ":type :boolean  :initform false)
              ;;  if any kind of college student above set true
              (college-student    :documentation "college-student ":type :boolean  :initform false)
              ;;  //if any kind of student set true
              (student :documentation "student":type :boolean  :initform false)
              (wants-specific-help    :documentation "wants-specific-help ":type :boolean  :initform false)
              (specific-questionnaire    :documentation "specific-questionnaire ":type :boolean  :initform false)
              ;; //if research subject
              (researcher-name    :documentation "researcher-name ":type :boolean  :initform false)
              (researcher-email   :documentation "researcher-email " :type :boolean   :initform false)
              ;;USER GOALS
              (goal-happy   :documentation " " :type :boolean  :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " " :type :boolean  :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " ":type :boolean   :initform false)
              (    :documentation " " :type :boolean  :initform false)
              #|              (    :documentation " "  :initform "initform")
              (    :documentation " "  :initform "initform")
              (    :documentation " "  :initform "initform")
              (    :documentation " "  :initform "initform")
              (    :documentation " "  :initform "initform")|#
              ))
#|
  public String name = "";
  public String firstName = "";
  public String middleName ="";
  public String lastName ="";
  public String userID = "";
  //only stored as string for now--fix later
  public int age = 0;
  public String ageString = "";
  public int ethnicInt = 0;
  public String ethnic = "";
  public int sexInt = 0;
  public String sex = "";  //"male" or "female"--no caps!
  public String eMailOfInstructor = "" ;
  public boolean isUSA = true;
  public String zipCode = "";
  public String otherCountry= "";
  public String nation = "";
  //date
  public String date = Config.dateString;

 public String Phone ="";
  public String Phone2 ="";
  public String eMailAddress ="";//email results to student??
  public String eMail2Address ="";
  public String StreetAddr = "";
  public String Apt = "";
  public String City = "";
  public String State = "";
  public String Zip = "";
  public String StreetAddr2 = "";
  public String Apt2 = "";
  public String City2 = "";
  public String State2 = "";
  public String Zip2 = "";
  //Biographical data
  public int maritalStatus = 0;
  public int occupationCode= 0;
  public int educationLevel= 0;
  public int annualIncome= 0;
  //only stored as string for now--fix later
  public int hoursWorkPerWeek= 0;
  public String hoursWorkPerWeekString = "";
  //userType information
  public boolean isWantsSelfHelp = false;
  public boolean isExperiencedSelfHelp = false;
  public boolean isPreviousUser = false;
  public boolean isWantsThorough = false;
  public boolean isWantsSpeed = false;
  public boolean isWorkingAdult = false;
  public boolean isRetired = false;
  public boolean isU100 = false;
  public boolean isCreditCSULB = false;
  public boolean isCreditOther = false;
  public boolean isCollegeStudentOther = false;
  public boolean isAcademicHelpOnly = false;// && Person.person.isAcademicHelpOnly == false)
  public boolean isResearchSubject = false;
  public boolean isInstructorWantsCredit = false;
  public boolean isFacultyOrAdmin = false;
  //if any of above wanting credit set to true
  public boolean isCourseCredit = false;
  //if any kind of college student set true
  public boolean isCollegeStudent = false;
  //if any kind of student set true
  public boolean isStudent = false;
  public boolean isWantsSpecificHelp = false;
  public boolean isSpecificQuestionnaire = false;

  //if research subject
  public String researcherName = "";
  public String researcherEmail = "";
    //CARES goals
  //      "Complete assessment to maximize my happiness
//      "Make good grades and achieve academic success",
//      "Improve my self-esteem",
//      "Overcome procrastination or improve self-motivation",
//      "Choose a major or career",
//      "Get more control of my life or improve time management",
//      "Improve my marriage or any kind of relationship",
//      "Meet people or improve related skills",
//      "Overcome loneliness, fear of being alone, or fear of rejection",
//      "Better understand my basic values and inner motivating forces",
//      "Cope with unhappiness, apathy, sadness, grief, or depression",
//      "Cope with stress, anxiety, fear, or guilt",
//      "Overcome Anger or Aggression",
//      "Job Search skills"
  public boolean isGoalHappy = false;
  public boolean isGoalAcademic = false;
  public boolean isGoalEmotCope = false;
  public boolean isGoalEsteem = false;
  public boolean isGoalProcrastinate = false;
  public boolean isGoalCareerChoice = false;
  public boolean isGoalCareerChoiceOnly = false;
  public boolean isGoalTimeManage = false;
  public boolean isGoalRelationship = false;
  public boolean isGoalMeetPeople = false;
  public boolean isGoalAlone = false;
  public boolean isGoalValues = false;
  public boolean isGoalDepression = false;
  public boolean isGoalAnxiety = false;
  public boolean isGoalAnger = false;
  public boolean isGoalCompleteAssess = false;
  public boolean isGoalCompleteNoAcademic = false;
  public boolean isGoalCompleteAssessPlusCareer = false;
  public boolean isGoalJobSearch = false;
  public boolean isGoalNotForSelf = false;
  //public boolean isGoal
//  public boolean
//  public boolean
//  public boolean
//  public boolean
//  public boolean
//  public boolean
//  public boolean

|#









;;CLASS TEMPLATE --KEEP BLANK
;;
;;
;;ddd
#|
(my-defclass          
 ;;superclasses
 ( )
  ;;begin slots
  ((
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   ;;end slots
   )
 ;;begin class-options
 '(:default-nitargs
   
   )
 ;;begin class instance-initargs
 '(
   :documentation " "
   ;;end class instance-initargs
   )
 ;;end class def
 )
|#

#|(multiple-value-setq (class class-sym  class-inst class-inst-sym)
              (my-defclass new-class4 
                           (class1 class2) 
                           ((new-slot1 :documentation "test docs1" :initform 99) 
                            (new-slot2  :documentation "test docs2"))
                           (:default-initargs :new-slot2 'init-value2) 
                           (:documentation "this is the class doc")))|#


#|(my-defclass  person        
 ;;superclasses
 (top-class)
  ;;begin slots
  ((name
    :documentation "name" 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
 (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
 (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
 (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
 (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
 (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   (
    :documentation " " 
    )
   ;;end slots
   )
 ;;begin class-options
 '(:default-nitargs
   
   )
 ;;begin class instance-initargs
 '(
   :documentation " "
   ;;end class instance-initargs
   )
 ;;end class def
 )|#













;;hhh ------------------------------------ HELP ----------------------------------------------
;;


;;JJJ -------------------------------------- FROM JAVA SHAQ ----------------------------------------------
;;
;;TOP? QUESTION CLASS  PCategory WITH DEFAULTS FILLED IN SLOTS
#|
public PCategory(String pcName1, int itemNum1, String questionText1,
      String scoreType1, FrAnswerPanel answerPanelType1,
      PCategory[] itemInstanceArray1,
      String frameTitle1, int frameDimWidth1, int frameDimHeight1,
      HelpLink helpLink1, String helpInfo1)
      //try laterPCategory classCreatingInstance1)
  {
      System.out.println("Creating PCategory for= "+ pcName1);
      name = pcName1;
      itemNum = itemNum1;
      scoreType = scoreType1;
      questionText = questionText1;
      itemInstanceArray = itemInstanceArray1;
      answerPanelType = answerPanelType1;
      numResponsesPerQuestion = answerPanelType.numResponsesPerQuestion;//classCreatingInstance = classCreatingInstance1;
      frameTitle = frameTitle1;
      frameDimWidth = frameDimWidth1;
      frameDimHeight = frameDimHeight1;
      //calculated items
      isScale = false;
      pCIndex = (itemNum -1);
      //looked up from StandardFrAnswerPanel types
      choiceType = answerPanelType.choiceType;
      numResponsesPerQuestion = answerPanelType.numResponsesPerQuestion;
      valueType = answerPanelType.valueType;
      intAnswerValueArray = answerPanelType.intAnswerValueArray;
      answerTextArray = answerPanelType.answerTextArray;
      //copied from above not sure needed
      intAnswerValueArray = answerPanelType.intAnswerValueArray;
      answerTextArray = answerPanelType.answerTextArray;
      answerInstructions = answerPanelType.answerInstructions;
      //end copied
      isReversedItem = answerPanelType.isReversedItem;
      isScoredReverse = answerPanelType.isScoredReverse;
      //added to store and print texts of answers
      helpLink = helpLink1;
      helpInfo = helpInfo1;
       //from helpLink object
       helpLinkName = helpLink.helpLinkName;
       //helpURL = helpLink.helpURL;
       urlString = helpLink.urlString;
       if (helpInfo == "")
       {helpInfo = helpLink.helpInfo;}
       //end from helpLink object

      if (choiceType == "multiple")
      {
        multiAnswerTextArray = new String[answerTextArray.length];
        MyMethods.initializeExistingArray(multiAnswerTextArray, "x");
      }
  }
|#