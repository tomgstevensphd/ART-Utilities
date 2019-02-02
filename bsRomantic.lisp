;;**************** bsRomantic.java ****************
;;
;;Tom G. Stevens PhD
;;  Success and Happiness Attributes Questionnaire (SHAQ) File
;;
;;  Converted from original SHAQ java file of same name (with .java extension)
;;  Originally written my Dr. Stevens in @ 2000
;;  Converted to lisp file in 2014
;;

 '(
 ( ( PC-INSTANCES
 "bsRomantic.java"
 ("[]questionInstancesArray1)")
 ("\"romSrq1Surprise\"" "1" "romSrq1SurpriseQ" "\"int\"" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight;")
 ("\"romSrq4Fantasize\"" "2" "romSrq4FantasizeQ" "\"int\"" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight;")
 ("\"romSrq5Celebr\"" "3" "romSrq5CelebrQ" "\"int\"" "FrAnswerPanel.LikeUs7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight;")
 ("\"romSrq12RomPlaces\"" "4" "romSrq12RomPlacesQ" "\"int\"" "FrAnswerPanel.LikeUs7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight;")
 ("\"romSrq13Attract\"" "5" "romSrq13AttractQ" "\"int\"" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight;")
 ("\"romSrq14Play\"" "6" "romSrq14PlayQ" "\"int\"" "FrAnswerPanel.LikeUs7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight;")
 ("\"romSrq42Charm\"" "7" "romSrq42CharmQ" "\"int\"" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight;")
 ("[]questionInstancesArray=newPCategory[totalQuestions];")
 ("[]helpArray=null;")
 ("[]helpResourcesArray;")
  )
 ( STRING-VARS
 "bsRomantic.java"
 (ROMSRQ1SURPRISEQ "INSTRUCTIONS FOR ALL QUESTIONS ON THIS SCALE:
" "  Apply all questions on this scale to your closest relationship. If you are married or in a close romantic relationship, apply them to that relationship. OR, you may apply them to an imagined future relationship.  OR, if you want help in working on a particular relationship, answer according to how the questions apply to that relationship.

" "Question 1. I do something different to surprise my partner such as buy flowers, leave a love note, or buy a present for no special event at least once a week.")
 (ROMSRQ4FANTASIZEQ "I frequently fantasize about my partner.")
 (ROMSRQ5CELEBRQ "My partner and I celebrate special days together almost once a month.")
 (ROMSRQ12ROMPLACESQ "My partner and I go out to romantic places just to be alone together at least once a week.")
 (ROMSRQ13ATTRACTQ "I am extremely attracted to my partner sexually.")
 (ROMSRQ14PLAYQ "My partner and I both enjoy playful interactions with each other several times per week.")
 (ROMSRQ42CHARMQ "My partner is extremely charming and romantic.")
  )
 ( STATIC-VARS
 "bsRomantic.java"
  )
 ( EXTRA-LINES
 "bsRomantic.java"
 "package CaresProject2;"
 "/**"
 " * Title:        CaresProject2"
 " * Description:  Your description"
 " * Copyright:    Copyright (c) 1999"
 " * Company:      CSULB"
 " * @author Tom Stevens PhD"
 " * @version"
 " */"
 "public class bsRomantic  extends bsInterpersonal"
 "  public bsRomantic()"
 "  {"
 "  }"
 "  {"
 "    questionInstancesArray = questionInstancesArray1;"
 "  }"
 "  /**"
 "   * This method to be called from higher-order creating class"
 "   */"
 "  public static void createbsRomanticInstances()"
 "   {"
 "    questionInstancesArray[0] = romSrq1Surprise;"
 "    questionInstancesArray[1] = romSrq4Fantasize;"
 "    questionInstancesArray[2] = romSrq5Celebr;"
 "    questionInstancesArray[3] = romSrq12RomPlaces;"
 "    questionInstancesArray[4] = romSrq13Attract;"
 "    questionInstancesArray[5] = romSrq14Play;"
 "    questionInstancesArray[6] = romSrq42Charm;"
 "  //new"
 "  bsRomantic  bsRomanticInstance ="
 "       new bsRomantic(questionInstancesArray);"
 "  classInstance = bsRomanticInstance;"
 "  }"
 "  public static void makebsRomanticQuestionFrames()"
 "  {"
 "//"
 "   bsRomanticMakeFrQuJRadioButtonsInstance ="
 "       new MakeFrQuJRadioButtons(className, totalQuestions,"
 "          firingOrderArray, questionInstancesArray,questionFramesArray);"
 "    questionFramesArray ="
 "      bsRomanticMakeFrQuJRadioButtonsInstance.makeJRadioButtonFrames("
 "         totalQuestions, firingOrderArray, questionInstancesArray);"
 "    isFramesCreated = true;"
 "       questionFramesArray[0]);"
 "    questionFramesArray[0].setVisible(true);"
 "        //ObjectAnalyzer.myToStringArray(radioButtonQuestionFrames);"
 "  }"
 "  public static String className = \"bsRomantic\";"
 "  public static String printName = \"\";"
 "  public static String description = \"\";"
 "  /**"
 "   * Most of below were copied from FrameQuestionJRadioButtons"
 "   *   BUT WITH STATIC REMOVED IN most CASES--"
 "   *   except where the variable referred to many individual questions within"
 "   *   the same frame, scale, or group."
 "   */"
 "  public static String frameTitle = \"Romantic Attitudes and Habits\";"
 "  public static int frameDimWidth = 805;"
 "  public static int frameDimHeight = 460;"
 "   /**"
 "   * Question frame and multi-question related variables"
 "   */"
 "  public static int totalQuestions = 7;"
 "  /**"
 "   * set the frame firing order to [0] if it is to be replaced by"
 "   * the defaultFiringOrder method--see below."
 "   */"
 "  public static int[] firingOrderArray = MyMethods.makeAscendingArray(1,totalQuestions);"
 "  public static FrameQuestionJRadioButtons[] questionFramesArray ="
 "      new FrameQuestionJRadioButtons[totalQuestions];"
 "  public static FrAnswerPanel likeMe7 = FrAnswerPanel.LikeUs7;"
 "  public static boolean isFramesCreated = false;"
 "  public static MakeFrQuJRadioButtons"
 "    bsRomanticMakeFrQuJRadioButtonsInstance ="
 "      new MakeFrQuJRadioButtons(className, totalQuestions,"
 "          firingOrderArray, questionInstancesArray,"
 "          questionFramesArray);"
 NIL
 NIL
 "  public static String helpLink = \"http://www.csulb.edu/~tstevens/success\";"
 "  public static String helpInfo = \"Romanantic attitudes and habits generally enhance people's sexual relationship happiness and satisfaction, and can make a difference in attractiveness to the opposite sex.\";"
 "  public static HelpResource helpResource;"
  )
 ( DELETED-LINES
 "bsRomantic.java"
 "    //USE FOLLOWING FRAME TO SPEED UP THE COPYING PROCESS--"
 "    // ONLY HAVE TO COPY THE NAME ONCE THIS WAY:"
 "//    PCategory x8 = new PCategory(\"x1\",8, Q, \"int\",  FrAnswerPanel.LikeUs7,questionInstancesArray, frameTitle, frameDimWidth, frameDimHeight);"
 "//    questionInstancesArray[7] = x1;"
 "//    PCategory x9 = new PCategory(\"x1\",9, Q, \"int\",  FrAnswerPanel.LikeUs7,questionInstancesArray, frameTitle, frameDimWidth, frameDimHeight);"
 "//    questionInstancesArray[8] = x1;"
 "//    PCategory x10= new PCategory(\"x1\",10, Q, \"int\",  FrAnswerPanel.LikeUs7,questionInstancesArray, frameTitle, frameDimWidth, frameDimHeight);"
 "//    questionInstancesArray[9] = x1;"
 "//    PCategory x11= new PCategory(\"x1\",11, Q, \"int\",  FrAnswerPanel.LikeUs7,questionInstancesArray, frameTitle, frameDimWidth, frameDimHeight);"
 "//    questionInstancesArray[10] = x1;"
 "//    PCategory x12= new PCategory(\"x1\",12, Q, \"int\",  FrAnswerPanel.LikeUs7,questionInstancesArray, frameTitle, frameDimWidth, frameDimHeight);"
 "//    questionInstancesArray[11] = x1;"
 "//    PCategory x13= new PCategory(\"x1\",13, Q, \"int\",  FrAnswerPanel.LikeUs7,questionInstancesArray, frameTitle, frameDimWidth, frameDimHeight);"
 "//    questionInstancesArray[12] = x1;"
 "//    PCategory x14= new PCategory(\"x1\",14, Q, \"int\",  FrAnswerPanel.LikeUs7,questionInstancesArray, frameTitle, frameDimWidth, frameDimHeight);"
 "//    questionInstancesArray[13] = x1;"
 "//    PCategory x1 = new PCategory (\"x8\", 18,"
 "//      \"Check all that apply to you.\",\"int\", \"\","
 "//      \"Click on OK below when finished\", 9, FrAnswerPanel.NonStandard,"
 "//      x1TextArray, FrAnswerPanel.Values9to1Array,"
 "//      \"multiple\",questionInstancesArray, frameTitle, frameDimWidth, frameDimHeight);"
 " //   itemInstanceList.addLast(srq );"
 "    //to test a few"
 "  //create a class instance (recall that the questions are PCategory instances"
 "  //  and cannot directly access class static variables)."
 "    //Create the class instance to hold class information--after other stuff created."
 "  //end new"
 "  //end method"
 "    //make a MakeFrQuJRadioButtons instance for storing all of the"
 "    //  data that relates to bsRomantic type frames"
 "    //make an instance so can make non-static methods work:"
 "  //get null pointer error below without this"
 "    //keep the frames in lower level file"
 "   // System.out.println(ObjectAnalyzer.myToString(MakeFrQuJRadioButtons.makeFrQuJRadioButtonsInstance));"
 "  //end method"
 "  //Values for item, scales, and questionnaire subparts"
 "  //defaults for frame title, etc."
 "  //public  PCategory currentQuestInstance;"
 "// public static String[] x1TextArray = {\" \","
 "//        \" \", \" \", \" \","
 "//        \" \", \" \", \" \","
 "//        \" \", \" \", \" \","
 "//        \" \", \" \""
 "//        };"
 "//   public static final String x10Label = \" \";"
 "    //SRQ--ROMANCE"
 "//from \"teasing\" to \"playful interactions\""
 "//70public static final String romSrq70OthersAttractQ = \"Most people think that my partner is physically attractive.\";"
 "   //for resources/recommendations"
 "//end class"
  )
 ( PRINT-LINES
 "bsRomantic.java"
 "    System.out.println (\"questionInstancesArray[0]= \"+ questionInstancesArray[0]);"
 "    System.out.println (\"questionInstancesArray[1]= \"+ questionInstancesArray[1]);"
 "    System.out.println (\"questionInstancesArray[2]= \"+ questionInstancesArray[2]);"
 "    System.out.println (\"questionInstancesArray[3]= \"+ questionInstancesArray[3]);"
 "    System.out.println(\"questionInstancesArray= \"+ questionInstancesArray);"
 "  System.out.println(\"bsRomantic's classInstance= \"+ classInstance);"
 "    System.out.println(\"+++++++++From \"+ className + \" ++++++++++\");"
 "    System.out.println(\"totalQuestions= \"+ totalQuestions);"
 "    System.out.println(\"questionInstancesArray= \"+ questionInstancesArray);"
 "    System.out.println(\"questionInstancesArray[0]= \"+ questionInstancesArray);"
 "    System.out.println(\"firingOrderArray= \"+ firingOrderArray);"
 "    System.out.println(\"firingOrderArray[0]= \"+ firingOrderArray[0]);"
 "    System.out.println(\"questionFramesArray= \"+ questionFramesArray);"
 "    System.out.println(\"isFramesCreated= \"+isFramesCreated);"
 "    System.out.println(\"questionFramesArray[0]= to setVisible(true) \"+"
  )
 )
NIL

 

   ) 

 ;;end of file
