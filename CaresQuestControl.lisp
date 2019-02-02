;;**************************** CaresQuestControl.lisp **********************
;;
;; COPY OF CaresQuestControl.java
;;
#|
package CaresProject2;

/**
 * Title:        Your Product Name
 * Description:  Your description
 * Copyright:    Copyright (c) 1999
 * Company:      CSULB
 * @author Tom Stevens PhD
 * @version
 *
 * @todo Find a way to randomly give U100 (and other??) users different combos
 * of scales for research to shorten time it takes to answer them.
 *
 * TO ADD A SCALE: (1) create a pUse static variable (2) Optional create a new
 * FrameUserGoals button and isDo variable AND/OR a specific questoinnaire button
 * (3) make if statements below for each isDo or specific questionnaire
 * (4) Create a    if (isGo == true && pUsebsSelfManagement == firePriority)
 * clause to fire the frame and questions
 *
 */

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class CaresQuestControl implements ActionListener
{

  public CaresQuestControl()
  {
  }

  /**
   * Overall question control method. This method should be called repeatedly
   * by putting it in every place where an OK or GO button makes the program
   * move on AND by taking over when one question set finishes??
   *
   * Therefore, make sure that there are if statements that keep previously
   * asked questions from refiring if or when the function runs on another cycle
   *
   * To assign priorities and control the firings, use isFireArray's that
   * are standard ones for different purposes, each with unique profiles of
   * which sets of questions will fire.
   *
   * IMPORTANT WARNINGS:
   *
   */
  public static void manageFiringQue(ActionEvent evt)
  {
    System.out.println("===========> manageFiringQue fired by Action event= "+ evt.getActionCommand()+ "end\n");
    System.out.println("Current firePriority= "+ firePriority);
    System.out.println("isGo= "+ isGo);
//do as one   if (isGo == true && isCreateInstancesAndArrays == true)
//   {
     //==============================================================
     //1-INITIALIZE THE DataStorageStructures (Do this earlier??)
     //person-related data store here near end of entire process
     if (isInitializeDataArrays == true)
     {
       isInitializeDataArrays = false;
//       DataStorage.initializeDataStoreArrays();

       initializeFirePriorityStack();
//       pCalcScaleScores = assignFirePriority(920);
       assignFirePriority(930,"pCalcScaleScores");
       assignFirePriority(940,"pUserFeedback");
       assignFirePriority(950,"pPrintTextResults");
       assignFirePriority(10,"pPrimaryLogic");
       assignFirePriority(30,"pSecondaryLogic");
       assignFirePriority(50,"pTertiaryLogic");
//       pPrintTextResults = assignFirePriority(950);
//       pPrimaryLogic = assignFirePriority(10);
//       pSecondaryLogic = assignFirePriority(12);
//       pTertiaryLogic = assignFirePriority(14);
     }

     //==============================================================
     //2-INTRODUCTORY FRAMES
       //FramePurpose framePurpose = new FramePurpose();
       //this.setVisible(false);
//     if(isGo == true && isFireframePurpose == true)
//     {
//       isGo = false;
//       FramePurpose framePurpose = new FramePurpose();
//       isFireframePurpose = false;
//       isFireframePermission = true;
//       framePurpose.setVisible(true);
//     }

     if(isGo == true && isFireframePermission == true)
     {
       isGo = false;
       FramePermission framePermission = new FramePermission();
       isFireframePermission = false;
       isFrameUserType = true;
       framePermission.setVisible(true);
       if (printDetails == true)
       {
         System.out.println ("framePermission set visible; isGo= " + isGo);

       }
     }

     //==============================================================
     //3-DO INITIAL ASSESSMENT TO DETERMINE QUESTIONS TO BE ASKED
     //First, get identifying data:
     if (isGo == true && isFrameUserType == true)
     {
       isGo = false;
       System.out.println("Creating FrameUserType");
       FrameUserType frameUserType = new FrameUserType();
       isFrameUserType = false;
       isFrameUserGoals = true;
       frameUserType.setVisible(true);
       if (printDetails == true)
       {
         System.out.println("frameUserType set visible; isGo= " + isGo);
       }
     }

     if (isGo == true && isFrameUserGoals == true)
     {
       isGo = false;
       //System.out.println("Creating FrameUserGoals");
       FrameUserGoals frameUserGoals = new FrameUserGoals();
       isFrameUserGoals = false;
       isPersonDataFrame = true;
       frameUserGoals.setVisible(true);
       if (printDetails == true)
       {
         System.out.println("frameUserGoals set visible; isGo= " + isGo);
       }

     }
     //12q
     if (isGo == true && isPersonDataFrame == true)
     {
      isGo = false;
       //reset
      PersonDataFrame personDataFrame = new PersonDataFrame();
      isPersonDataFrame = false;
      isFirePersonBio = true;
 //for test only     pUseiLifeThemes = 1;
      personDataFrame.setVisible(true);
      if (printDetails == true)
      {
        System.out.println("personDataFrame set visible; isGo= " + isGo);
      }

     }

     //new 8-01
     if (isGo == true && isFrameCourseCredit == true)
     {
      isGo = false;
       //reset
      FrameCourseCredit frameCourseCreditInstance = new FrameCourseCredit();
      isFrameCourseCredit = false;
 //for test only     pUseiLifeThemes = 1;
      frameCourseCreditInstance.setVisible(true);
     }
     if (isGo == true && isFrameResearchSubject == true)
     {
      isGo = false;
       //reset
      FrameResearchSubject frameResearchSubjectInstance = new FrameResearchSubject();
      isFrameResearchSubject = false;
 //for test only     pUseiLifeThemes = 1;
      frameResearchSubjectInstance.setVisible(true);
     }

     //edn new 8-01
     //start here test to make sure the makeFrames system is working, recall

     //9q
     if (isGo == true && isFirePersonBio == true
          && Person.person.isPreviousUser == false)
     {
       isGo = false;
       resetFirePriority();
       //System.out.println("START PersonBio");
       PersonBio.createPersonBioInstances();
       PersonBio.makePersonBioFrames();
       //System.out.println("From CaresQuestControl----> PersonBioFrames made");
      //error message: System.out.println("radioButtonQuestionFrames[0].name= "+ PersonBio.questionFramesArray[0].name);
       isFirePersonBio = false;
       //do here to prevent repeated firing of isStudent if

       //isGo is set within the makePersonBioFrames or otherwise the student
       // frames are fired
       if(printDetails == true)
       {
         System.out.println("From CaresQuestControl----> PersonBioFrames made; isGo= " + isGo);
       }

     }

     //==============================================================
     //3-PRIMARY LOGIC, Decide which question arrays are to be used--in what order
     //        But DO NOT CREATE OR FIRE FRAMES HERE--could lead to too
     //        much redundancy if do it for each type of user.
     //        SECONDARY LOGIC means that some firePriority numbers are assigned
     //        after all the primary ones, depending upon when higher priority issues are
     //        fired first.
     //  Some isVariable could be assigned one firePriority initially in the
     //        Primary logic, then reassigned to higher or lower values later
     //
     //  LOGIC FIRING ORDER: Primary, Secondary,and Tertiary logic sections should
     //        fire right after each other, then should NEVER refire.
     //
     //  DYNAMIC LOGIC: It is still possible to reassign logic numbers during execution.

//  public boolean isGoalWantsSelfHelp = false;
//  public boolean isExperiencedSelfHelp = false;
//  public boolean isGoalWantsThorough = false;
//  public boolean isWantsSpeed = false;
//  public boolean isWorkingAdult = false;
//  public boolean isRetired = false;
//  public boolean isU100 = false;
//  public boolean isCreditCSULB = false;
//  public boolean isCreditOther = false;
//  public boolean isCollegeStudentOther = false;
//  public boolean isInstructorWantsCredit = false;
//  public boolean isFacultyOrAdmin = false;
//  //if any of above wanting credit set to true
//  public boolean isCourseCredit = false;
//  //if any kind of college student set true
//  public boolean isCollegeStudent = false;
//  //if any kind of student set true
//  public boolean isStudent = false;
//  public boolean isWantsSpecificHelp = false;
//  isSpecificQuestionnaire

     //gets checked only in beginning
     //START HERE DO iSelf EARLY--BECAUSE OF ALL OVERVIEW QUESTIONS
     if (isGo == true && pPrimaryLogic == firePriority)
     {
       //isGo not reset, because want SECONDARY LOGIC to fire next.
       System.out.println("PRIMARY LOGIC FIRING");
       //let them choose areas or questionnaires--go to GOALS to determine
       //  priorities next:


       if (Person.person.isWantsSpecificHelp == true)
       {//pWantsSpecificHelp = assignFirePriority(500);
        //assign help categories 400-499
        assignFirePriority(500,"pWantsSpecificHelp");
        }
       //not a U100 student
       if (Person.person.isSpecificQuestionnaire == true) //&&
        // Person.person.isU100 == false && Person.person.isCourseCredit == false)
       {
        //must assign next firePriority bec must fire before sec logic
          assignFirePriority(firePriority+1,"pSpecificQuestionnaire");
        }
       if (Person.person.isAcademicHelpOnly == true) //&&
        {
        //must assign next firePriority bec must fire before sec logic
          assignPriorityValuesToArray(680,5,pSTandLEARN1FireArray);
        }
       //create special frame for instructors
       if (Person.person.isInstructorWantsCredit == true)
       {//pInstructorWantsCredit  = assignFirePriority(50);
        //use 50-59;
          assignFirePriority(50,"pInstructorWantsCredit");
        }
       if (Person.person.isResearchSubject == true)
       {
          assignFirePriority(57,"pResearchSubject");
        }
       if(Person.person.isGoalCompleteAssess ||
            Person.person.isWantsThorough ||
            Person.person.isGoalCompleteNoAcademic)
       {
         if(Person.person.isStudent == true &&
           Person.person.isGoalCompleteNoAcademic == false)
         {
            assignPriorityValuesToArray(610,1,pCOMPLETEStFireArray);
         }
         else
         {
            assignPriorityValuesToArray(610,1,pCOMPLETENStFireArray);
         }
       }
       if(Person.person.isGoalCompleteAssessPlusCareer)
       {
         assignPriorityValuesToArray(0,1,pCOMPLETEStFireArray);
         assignPriorityValuesToArray(0,1,pCOMPLETENStFireArray);
         assignPriorityValuesToArray(610,1,pCOMPLETwCarFireArray);
       }
       //make sure that students get asked basic student questions
       //  UNLESS CHECK ABOVE WANT SPECIFIC Questionnaire OR HELP
       //  but allow that they may get asked non-academic questions first
       //  if they indicate other interests??
       if (Person.person.isStudent == true && Person.person.isAcademicHelpOnly == false &&
            Person.person.isGoalCareerChoiceOnly == false &&
            Person.person.isGoalCompleteNoAcademic == false)
       {isStudent = true;
        pStudent = assignFirePriority(700);
        assignFirePriority(700,"pStudent");
        //use 700-800 for student related to give specifics first if
        // not for credit
       }
       //these students will more likely get academic questions early
       if (Person.person.isCourseCredit == true &&
            Person.person.isAcademicHelpOnly == false
            && Person.person.isGoalCareerChoiceOnly == false)
       {isCourseCredit = true;
        //set pStudent to higher priority
        //pCourseCredit = assignFirePriority(300);
        assignFirePriority(300,"pCourseCredit");
        //use 400-500 for student stuff and 500-600 for stuff course credit
        //  has priority over (eg. relationship??, etc. UNLESS says taking
        //  for specific problem or wants specific quest too??
        }
       //these will definitely get academic questions early
       if (Person.person.isU100 == true)
       {isU100 = true;
        //pU100 = assignFirePriority(200);
        //use 200-300 for academic success & related
        assignFirePriority(200,"pU100");
        // also do all level 1 assess here.
        // for career decision goal, put it here too
        //  do other issues they might have checked later.
        }


//template
//       if (Person.person == true)
//       { = ;
//         assignFirePriority();
//       }


       //use these to determine num questions in each category
       //  not so much for the priority of categories
//       if (Person.person.isWantsThorough == true)
//       {isWantsThorough  =  ;}
//       if (Person.person.isWantsSpeed == true)
//       {  =  ;}

       pPrimaryLogic = -1;
       resetFirePriority();

     //end isPrimaryLogic if
     }

     //==============================================================
     //4-SECONDARY LOGIC AREA:  These are changed after the primary logic is
     //    completed.
     //
     if (isGo == true && pSecondaryLogic == firePriority)
     {
       System.out.println("SECONDARY LOGIC FIRING");
        pSecondaryLogic = -1;
        resetFirePriority();
        isGo = true;

       //if check want to specific/general problem,
       //  give priority to content areas
       //if want general assessment, general to be happy
       //  do values & general first plus level 1 question in various areas.
       //START HERE AND COMPLETE AFTER CREATE THE DIFFERENT LEVELS OF
       //  QUESTION ARRAYS

//       if (isStudent == firePriority || isU100 == firePriority || isCourseCredit == firePriority)
       if (isStudent == true && isU100 == false && isCourseCredit == false
             && Person.person.isAcademicHelpOnly == false
             && Person.person.isGoalCareerChoiceOnly == false)
       {
          assignPriorityValuesToArray(410,5,pSTUDENTFireArray);

          //set rest of questions to be asked for ALL student to 1;
          //isGo = true;
       }
       if (isStudent == true && isU100 == false && isCourseCredit == true
             && Person.person.isAcademicHelpOnly == false
             && Person.person.isGoalCareerChoiceOnly == false)
       {
         assignPriorityValuesToArray(310,5,pCREDITFireArray);
          //set rest of questions to be asked for ALL student to 1;
          //isGo = true;
       }
       if (isU100 == true)
       {
         //if student set to use StudentBasicData and other student frames
         //TEST SECTION ONLY RIGHT NOW

          assignPriorityValuesToArray(210,5,pU100isFireArray);

         //isGo = true;
       }

       if (Person.person.isGoalAcademic == true && Person.person.isAcademicHelpOnly == false)
       {
           //same as student??? or auto more intensive questions???
           assignPriorityValuesToArray(620,5,pSTandLEARN1FireArray);
           //pUsebsSelfManagement = assignFirePriority(680);
           assignFirePriority(680,"pUsebsSelfManagement");
       }
       if (Person.person.isGoalCareerChoiceOnly == true)
       {
           assignPriorityValuesToArray(610,5,pCareerOnlyFireArray);
       }
       if (Person.person.isGoalProcrastinate == true)
       {
         assignPriorityValuesToArray(660,5,pGlProcFireArray);
       }
       if (Person.person.isGoalTimeManage == true)
       {
         assignPriorityValuesToArray(700,5,pSMFireArray);
       }
       if (Person.person.isGoalRelationship == true)
       {
         assignPriorityValuesToArray(810,5,pPEOPLE1FireArray);
       }
       if (Person.person.isGoalHappy == true)
       {
        //"complete means full on life values + emotional plus all non-academic??"
        assignPriorityValuesToArray(610,3,pCOMPLETENStFireArray);
       }
       if (Person.person.isGoalAnxiety == true)
       {
        assignPriorityValuesToArray(610,5,pGlAnxietyFireArray);
       }
       if (Person.person.isGoalDepression == true)
       {
        assignPriorityValuesToArray(610,5,pGlDepressFireArray);
       }
       if (Person.person.isGoalAnger == true)
       {
        assignPriorityValuesToArray(660,5,pGlAngerFireArray);
       }
       if (Person.person.isGoalEsteem == true)
       {
        assignPriorityValuesToArray(660,5,pSELF1AllFireArray);
        //pUsebsAssertiveCR = assignFirePriority(690);
        assignFirePriority(690,"pUsebsAssertiveCR");
       }
       if (Person.person.isGoalCareerChoice == true ||
            Person.person.isGoalCompleteAssessPlusCareer ||
            Person.person.isGoalCareerChoiceOnly)
       {
          assignFirePriority(891,"pUseFrameCareerGo");
             //career choice brochure + later questions for Students
//          if (Person.person.isStudent == true)
//          {
//            //do major choice questions
//          }
       }
       if (Person.person.isGoalJobSearch == true)
       {
         //no questions?  just refer to help??
       }
       if (Person.person.isGoalValues == true)
       {
         //life themes + ?
         assignPriorityValuesToArray(660,5,pGlProcFireArray);
       }
       if (Person.person.isGoalAlone == true)
       {
         //meet people, depression, questions, fear questions, relat Qs??
         //refer to fear of alone handout + some bk sections?
         assignPriorityValuesToArray(660,5,pGlProcFireArray);
       }
       if (Person.person.isGoalMeetPeople == true)
       {
         //meet people handout //relation questions??
         assignPriorityValuesToArray(660,5,pGlAloneFireArray);
       }

       //from FrameSpecificQuestionnaire
       if (FrameSpecificQuestionnaire.isDoiLifeThemes == true)
       {  //pUseiLifeThemes = assignFirePriority(500);
          assignFirePriority(300,"pUseiLifeThemesAch");
          assignFirePriority(301,"pUseiLifeThemesSoc");
          assignFirePriority(302,"pUseiLifeThemesNeg");
          assignFirePriority(303,"pUseiLifeThemes");
       }
       if (FrameSpecificQuestionnaire.isDoiTopBV == true)
       {
          //pUseiTopBV = assignFirePriority(505);
          assignFirePriority(305,"pUseiTopBV");
       }
       if (FrameSpecificQuestionnaire.isDoiTopBV2 == true)
       {
          //pUseiTopBV2 = assignFirePriority(510);
          assignFirePriority(310,"pUseiTopBV2");
       }
       if (FrameSpecificQuestionnaire.isDoiWorldview == true)
       {
         //pUseiWorldview  = assignFirePriority(515);
         assignFirePriority(315,"pUseiWorldview");
       }
       if (FrameSpecificQuestionnaire.isDoiWorldviewFears == true)
       {
         //pUseiWorldview  = assignFirePriority(515);
         assignFirePriority(317,"pUseiWorldviewFears");
       }
       if (FrameSpecificQuestionnaire.isDoiSelf == true)
       {
          //pUseiSelf = assignFirePriority(520);
          assignFirePriority(320,"pUseiSelf");
       }
//       if (FrameSpecificQuestionnaire.isDoiSelf2 == true)
//       {
//           //pUseiSelf2= assignFirePriority(525);
//           assignFirePriority(325,"pUseiSelf2");
//       }
       if (FrameSpecificQuestionnaire.isDoiIEcontrol == true)
       {
         //pUseiIEcontrol  = assignFirePriority(530);
         assignFirePriority(330,"pUseiIEcontrol");
       }
//       if (FrameSpecificQuestionnaire.isDoiIEcontrol2 == true)
//       {
//          //pUseiIEcontrol2 = assignFirePriority(535);
//          assignFirePriority(335,"pUseiIEcontrol2");
//       }
       if (FrameSpecificQuestionnaire.isDobsSelfManagement == true)
       {
          //pUsebsSelfManagement = assignFirePriority(540);
          assignFirePriority(340,"pUsebsSelfManagement");
       }
       if (FrameSpecificQuestionnaire.isDobsEmotionManagement == true)
       {
          //pUsebsEmotionManagement = assignFirePriority(545);
          assignFirePriority(345,"pUsebsEmotionManagement");
       }
       if (FrameSpecificQuestionnaire.isDoStudentBasicData == true)
       {
          //pUseStudentBasicData1 = assignFirePriority(410);
          assignFirePriority(260,"pUseStudentBasicData1");
       }
       if (FrameSpecificQuestionnaire.isDoStudentBasicData2 == true)
       {
          //pUseStudentBasicData2 = assignFirePriority(415);
          assignFirePriority(265,"pUseStudentBasicData2");
       }
       if (FrameSpecificQuestionnaire.isDobsLearning == true)
       {
          //pUsebsLearning = assignFirePriority(420);
          assignFirePriority(270,"pUsebsLearning");
       }
       if (FrameSpecificQuestionnaire.isDobsLearningAreas == true)
       {
          pUsebsLearningAreas = assignFirePriority(425);
          assignFirePriority(275,"pUsebsLearningAreas");
       }
       if (FrameSpecificQuestionnaire.isDobsLearningDisable == true)
       {
          //pUsebsLearningDisable = assignFirePriority(430);
          assignFirePriority(280,"pUsebsLearningDisable");
       }
       if (FrameSpecificQuestionnaire.isDoiAcademicMotivation == true)
       {
          assignFirePriority(285,"isDoiAcademicMotivation");
       }
       if (FrameSpecificQuestionnaire.isDobsAssertiveCR == true)
       {
          //pUsebsAssertiveCR = assignFirePriority(570);
          assignFirePriority(370,"pUsebsAssertiveCR");
       }
       if (FrameSpecificQuestionnaire.isDobsIntimacy == true)
       {
          //pUsebsIntimacy = assignFirePriority(575);
          assignFirePriority(375,"pUsebsIntimacy");
       }
       if (FrameSpecificQuestionnaire.isDobsIndependentRel == true)
       {
          //pUsebsIndependentRel = assignFirePriority(580);
          assignFirePriority(380,"pUsebsIndependentRel");
       }
       if (FrameSpecificQuestionnaire.isDobsLiberatedRole == true)
       {
           //pUsebsLiberatedRole= assignFirePriority(585);
           assignFirePriority(385,"pUsebsLiberatedRole");
       }
       if (FrameSpecificQuestionnaire.isDobsRomantic == true)
       {
          //pUsebsRomantic = assignFirePriority(590);
          assignFirePriority(390,"pUsebsRomantic");
       }
       if (FrameSpecificQuestionnaire.isDoRealDepression == true)
       {
          assignFirePriority(395,"pUseRealDepression");
       }
       if (FrameSpecificQuestionnaire.isDoRealAnxiety == true)
       {
          assignFirePriority(397,"pUseRealAnxiety");
       }
       if (FrameSpecificQuestionnaire.isDoRealAnger == true)
       {
          assignFirePriority(399,"pUseRealAnger");
       }
       if (FrameSpecificQuestionnaire.isDoFrameCareerGo == true)
       {
          assignFirePriority(893,"pUseinCareer");
       }

//     if (Person.person. == true)
//     {
//     }
     //end secondary Logic
     }

     //==============================================================
     //5--TERTIARY LOGIC SECTION
     if (isGo == true && pTertiaryLogic == firePriority)
     {
         isGo = true;
         pTertiaryLogic = -1;
          System.out.println("TERTIARY LOGIC FIRING");
          //pTertiaryLogic = -1;
          //resetFirePriority();

        if (isStudent == true || isCourseCredit == true || isU100 == true)
        {
//          if (Student.student.currentGpa < 3.5 || Student.student.hsGpa < 3.5)
//            { //pUsebsLearningAreas = assignFirePriority();
            assignFirePriority(pUsebsLearning+1,"pUsebsLearningAreas"); //}
            if (Student.student.currentGpa < 3.0 || Student.student.hsGpa < 3.00)
            { //pUsebsLearningDisable = assignFirePriority(630);
              assignFirePriority(pUsebsLearning+2,"pUsebsLearningDisable");}
            assignFirePriority(pUsebsLearning+4,"pUseiAcademicMotivation");
        }
//        if (isCourseCredit == true)
//        {
//          if (Student.student.currentGpa < 3.5 || Student.student.hsGpa < 3.5)
//          { //pUsebsLearningAreas = assignFirePriority(425);
//            assignFirePriority(pUsebsLearning+1,"pUsebsLearningAreas");
//            }
//          if (Student.student.currentGpa < 2.5 || Student.student.hsGpa < 3.00)
//          { //pUsebsLearningDisable = assignFirePriority(430);
//            assignFirePriority(pUsebsLearning+1,"pUsebsLearningDisable");
//            }
//        }
//        if (isU100 == true)
//        {
//          if (Student.student.currentGpa < 3.5 || Student.student.hsGpa < 3.5)
//          { //pUsebsLearningAreas = assignFirePriority(225);
//            assignFirePriority(pUsebsLearning+1,"pUsebsLearningAreas");
//           }
//          if (Student.student.currentGpa < 2.5 || Student.student.hsGpa < 3.00)
//          { //pUsebsLearningDisable = assignFirePriority(230);
//            assignFirePriority(pUsebsLearning+2,"pUsebsLearningDisable");
//            }
//        }
     }

     //6-LOGIC WORKING MEMORY gets checked EVERY CYCLE TO DYNAMICALLY REVISE PRIORITIES
     //   MUST ALWAYS CHECK TO SEE IF Qs were previously fired (= -1);
     if (isGo == true)
     {



     //end logic working memory
     }

     //==============================================================
     //7--CREATE the QUESTION INSTANCES & FIRE FRAMES FOR ALL CLASSES
     //   before do scales. Can't create scales until questions done
     //   Make this more sophisticated (does person want this type of help?)


     //FrameSpecificQuestionnaire
     System.out.println("pSpecificQuestionnaire= "+pSpecificQuestionnaire);
     if (isGo == true && pSpecificQuestionnaire == firePriority)
     {
       isGo = false;
       pSpecificQuestionnaire = -1;

       FrameSpecificQuestionnaire frameSpecificQuestionnaireInstance =
         new FrameSpecificQuestionnaire();
//       frameSpecificQuestionnaireInstance.setLocation(0,0);
//       frameSpecificQuestionnaireInstance.setSize(800,550);
       frameSpecificQuestionnaireInstance.setVisible(true);
     }

     //   If student, collect student data:
     //
     //StudentBasicData
     //20q
     System.out.println("pUseStudentBasicData1= "+pUseStudentBasicData1);
     if (isGo == true && pUseStudentBasicData1 == firePriority)
     {
        System.out.println("pUseStudentBasicData1 FIRED");
        isGo = false; //reset in FrQ...
        pUseStudentBasicData1 = -1;
        resetFirePriority();
        StudentBasicData.createStudentBasicDataInstances();
        StudentBasicData.makeStudentQuestionFrames();
        System.out.println("From Cares Control----> StudentBasicDataFrames made");
//        System.out.println("radioButtonQuestionFrames[0]= "+ StudentBasicData.questionFramesArray[0]);
     }
     //StudentBasicData2
     //12q
     //System.out.println("pUseStudentBasicData2= "+pUseStudentBasicData2);
     if (isGo == true && pUseStudentBasicData2 == firePriority)
     {
        //System.out.println("pUseStudentBasicData2 FIRED");
        isGo = false; //reset in FrQu...
        pUseStudentBasicData2 = -1;
        resetFirePriority();
        StudentBasicData2.createStudentBasicData2Instances();
        StudentBasicData2.makeStudentBasicData2QuestionFrames();
        //System.out.println("From Cares Control----> StudentBasicDataFrames made");
//        System.out.println("radioButtonQuestionFrames[0]= "+ StudentBasicData.questionFramesArray[0]);

     }
       //Template for making frames
       // q
//     if (isGo == true && pUseTemplate == firePriority)
//     {
//       pUseTemplate = -1;
//       isGo = false;
//       resetFirePriority();
//       System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING Template |||||||||||||||||||||||||\n");
//       Template.createTemplateInstances();
//       Template.makeTemplateQuestionFrames();
//       System.out.println("||||||||| From CaresQuestControl----> TemplateQuestionFrames made||||||||||||");
//       System.out.println("radioButtonQuestionFrames[0].name= "+ Template.questionFramesArray[0].name);
//       isUseTemplate = false;
//       //isGo is set within the makeTemplateFrames or otherwise the student
//       // frames are fired
//     }
     //bsLearning
     //20q
     if (isGo == true && pUsebsLearning == firePriority)
     {
       pUsebsLearning = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("START bsLearning");
       bsLearning.createbsLearningInstances();
       bsLearning.makebsLearningQuestionFrames();
       //System.out.println("From CaresQuestControl----> bsLearningQuestionFrames made");
      //error System.out.println("radioButtonQuestionFrames[0].name= "+ bsLearning.questionFramesArray[0].name);
       //isGo is set within the makebsLearningFrames or otherwise the student
       // frames are fired
     }
     //bsLearningAreas
     //12q
     if (isGo == true && pUsebsLearningAreas == firePriority)
     {
       pUsebsLearningAreas = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("START bsLearning");
       bsLearningAreas.createbsLearningAreasInstances();
       bsLearningAreas.makebsLearningAreasQuestionFrames();
       //System.out.println("From CaresQuestControl----> bsLearningAreasQuestionFrames2 made");
      //error System.out.println("radioButtonQuestionFrames[0].name= "+ bsLearning.questionFramesArray[0].name);
       //isGo is set within the makebsLearningFrames or otherwise the student
       // frames are fired
     }
     //bsLearningDisable
     //13q
     if (isGo == true && pUsebsLearningDisable == firePriority)
     {
       pUsebsLearningDisable = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("START bsLearning");
       bsLearningDisable.createbsLearningDisableInstances();
       bsLearningDisable.makebsLearningDisableQuestionFrames();
       //System.out.println("From CaresQuestControl----> bsLearningDiableQuestionFrames made");
      //error System.out.println("radioButtonQuestionFrames[0].name= "+ bsLearning.questionFramesArray[0].name);
       //isGo is set within the makebsLearningFrames or otherwise the student
       // frames are fired
     }
     if (isGo == true && pUseiAcademicMotivation == firePriority)
     {
       pUseiAcademicMotivation = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("START iAcademicMotivation");
       iAcademicMotivation.createiAcademicMotivationInstances();
       iAcademicMotivation.makeiAcademicMotivationQuestionFrames();
     }
     //iLifeThemesAch
     //34q
     if (isGo == true && pUseiLifeThemesAch == firePriority)
     {
       pUseiLifeThemesAch = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iLifeThemesAch |||||||||||||||||||||||||\n");
       iLifeThemesAch.createiLifeThemesAchInstances();
       iLifeThemesAch.makeiLifeThemesAchQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iLifeThemesAchQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iLifeThemesAch.questionFramesArray[0]);
       //  isUseiLifeThemesAch = false;
       //isGo is set within the makeiLifeThemesAchFrames or otherwise the student
       // frames are fired
     }
     //iLifeThemesSoc
     //34q
     if (isGo == true && pUseiLifeThemesSoc == firePriority)
     {
       pUseiLifeThemesSoc = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iLifeThemesSoc |||||||||||||||||||||||||\n");
       iLifeThemesSoc.createiLifeThemesSocInstances();
       iLifeThemesSoc.makeiLifeThemesSocQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iLifeThemesSocQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iLifeThemesSoc.questionFramesArray[0]);
       //  isUseiLifeThemesSoc = false;
       //isGo is set within the makeiLifeThemesSocFrames or otherwise the student
       // frames are fired
     }
     //iLifeThemesNeg
     //34q
     if (isGo == true && pUseiLifeThemesNeg == firePriority)
     {
       pUseiLifeThemesNeg = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iLifeThemesNeg |||||||||||||||||||||||||\n");
       iLifeThemesNeg.createiLifeThemesNegInstances();
       iLifeThemesNeg.makeiLifeThemesNegQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iLifeThemesNegQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iLifeThemesNeg.questionFramesArray[0]);
       //  isUseiLifeThemesNeg = false;
       //isGo is set within the makeiLifeThemesNegFrames or otherwise the student
       // frames are fired
     }
     //iLifeThemes
     //34q
     if (isGo == true && pUseiLifeThemes == firePriority)
     {
       pUseiLifeThemes = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iLifeThemes |||||||||||||||||||||||||\n");
       iLifeThemes.createiLifeThemesInstances();
       iLifeThemes.makeiLifeThemesQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iLifeThemesQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iLifeThemes.questionFramesArray[0]);
       //  isUseiLifeThemes = false;
       //isGo is set within the makeiLifeThemesFrames or otherwise the student
       // frames are fired
     }

     //bsSelfManagement
     //12q
     if (isGo == true && pUsebsSelfManagement == firePriority)
     {
       pUsebsSelfManagement = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING bsSelfManagement |||||||||||||||||||||||||\n");
       bsSelfManagement.createbsSelfManagementInstances();
       bsSelfManagement.makebsSelfManagementQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> bsSelfManagementQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ bsSelfManagement.questionFramesArray[0]);
       //  isUsebsSelfManagement = false;
       //isGo is set within the makebsSelfManagementFrames or otherwise the student
       // frames are fired
     }

     //bsEmotionManagement
     //17q
     if (isGo == true && pUsebsEmotionManagement == firePriority)
     {
       pUsebsEmotionManagement = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING bsEmotionManagement |||||||||||||||||||||||||\n");
       bsEmotionManagement.createbsEmotionManagementInstances();
       bsEmotionManagement.makebsEmotionManagementQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> bsEmotionManagementQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ bsEmotionManagement.questionFramesArray[0]);
       //  isUsebsEmotionManagement = false;
       //isGo is set within the makebsEmotionManagementFrames or otherwise the student
       // frames are fired
     }

     //iWorldview
     //21q
     if (isGo == true && pUseiWorldview == firePriority)
     {
       pUseiWorldview = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iWorldview |||||||||||||||||||||||||\n");
       iWorldview.createiWorldviewInstances();
       iWorldview.makeiWorldviewQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iWorldviewQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iWorldview.questionFramesArray[0]);
       //  isUseiWorldview = false;
       //isGo is set within the makeiWorldviewFrames or otherwise the student
       // frames are fired
     }
     if (isGo == true && pUseiWorldviewFears == firePriority)
     {
       pUseiWorldviewFears = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iWorldviewFears ||||||||||||||||||||\n");
       iWorldviewFears.createiWorldviewFearsInstances();
       iWorldviewFears.makeiWorldviewFearsQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iWorldviewFearsQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iWorldviewFears.questionFramesArray[0]);
       //  isUseiWorldview = false;
       //isGo is set within the makeiWorldviewFearsFrames or otherwise the student
       // frames are fired
     }
     //iIEcontrol
     //7 or 17q make 2 parts??
     if (isGo == true && pUseiIEcontrol == firePriority)
     {
       pUseiIEcontrol = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iIEcontrol |||||||||||||||||||||||||\n");
       iIEcontrol.createiIEcontrolInstances();
       iIEcontrol.makeiIEcontrolQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iIEcontrolQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iIEcontrol.questionFramesArray[0]);
       //  isUseiIEcontrol = false;
       //isGo is set within the makeiIEcontrolFrames or otherwise the student
       // frames are fired
     }
     //added 3-14-02
//      if (isGo == true && pUseiIEcontrol2 == firePriority)
//     {
//       pUseiIEcontrol2 = -1;
//       isGo = false;
//       resetFirePriority();
//       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iIEcontrol |||||||||||||||||||||||||\n");
//       iIEcontrol2.createiIEcontrol2Instances();
//       iIEcontrol2.makeiIEcontrol2QuestionFrames();
//       //System.out.println("||||||||| From CaresQuestControl----> iIEcontrolQuestionFrames made||||||||||||");
//       //System.out.println("radioButtonQuestionFrames[0]= "+ iIEcontrol.questionFramesArray[0]);
//       //  isUseiIEcontrol = false;
//       //isGo is set within the makeiIEcontrolFrames or otherwise the student
//       // frames are fired
//     }
     //iTopBV
     //53
     if (isGo == true && pUseiTopBV == firePriority)
     {
       pUseiTopBV = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iTopBV |||||||||||||||||||||||||\n");
       iTopBV.createiTopBVInstances();
       iTopBV.makeiTopBVQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iTopBVQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iTopBV.questionFramesArray[0]);
       //  isUseiTopBV = false;
       //isGo is set within the makeiTopBVFrames or otherwise the student
       // frames are fired
     }
     //added 3-14-02
      if (isGo == true && pUseiTopBV2 == firePriority)
     {
       pUseiTopBV2 = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iTopBV |||||||||||||||||||||||||\n");
       iTopBV2.createiTopBV2Instances();
       iTopBV2.makeiTopBV2QuestionFrames();
     }
     //iSelf
     //48q
     if (isGo == true && pUseiSelf == firePriority)
     {
       pUseiSelf = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iSelf |||||||||||||||||||||||||\n");
       iSelf.createiSelfInstances();
       iSelf.makeiSelfQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> iSelfQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ iSelf.questionFramesArray[0]);
       //  isUseiSelf = false;
       //isGo is set within the makeiSelfFrames or otherwise the student
       // frames are fired
     }
     //added 3-14-02
//     if (isGo == true && pUseiSelf2 == firePriority)
//     {
//       pUseiSelf2 = -1;
//       isGo = false;
//       resetFirePriority();
//       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING iSelf2 |||||||||||||||||||||||||\n");
//       iSelf2.createiSelf2Instances();
//       iSelf2.makeiSelf2QuestionFrames();
//       //System.out.println("||||||||| From CaresQuestControl----> iSelf2QuestionFrames made||||||||||||");
//       //System.out.println("radioButtonQuestionFrames[0]= "+ iSelf2.questionFramesArray[0]);
//       //  isUseiSelf2 = false;
//       //isGo is set within the makeiSelf2Frames or otherwise the student
//       // frames are fired
//     }
     //eHappy
     //16
     if (isGo == true && pUseeHappy == firePriority)
     {
       pUseeHappy = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING eHappy |||||||||||||||||||||||||\n");
       eHappy.createeHappyInstances();
       eHappy.makeeHappyQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> eHappyQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ eHappy.questionFramesArray[0]);
       //  isUseeHappy = false;
       //isGo is set within the makeeHappyFrames or otherwise the student
       // frames are fired
     }
     //RealHealth
     //3q
     if (isGo == true && pUseRealHealth == firePriority)
     {
       pUseRealHealth = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING RealHealth |||||||||||||||||||||||||\n");
       RealHealth.createRealHealthInstances();
       RealHealth.makeRealHealthQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> RealHealthQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ RealHealth.questionFramesArray[0]);
       //  isUseRealHealth = false;
       //isGo is set within the makeRealHealthFrames or otherwise the student
       // frames are fired
     }
     //RealPeople
     //7q
     if (isGo == true && pUseRealPeople == firePriority)
     {
       pUseRealPeople = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING RealPeople |||||||||||||||||||||||||\n");
       RealPeople.createRealPeopleInstances();
       RealPeople.makeRealPeopleQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> RealPeopleQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ RealPeople.questionFramesArray[0]);
       //  isUseRealPeople = false;
       //isGo is set within the makeRealPeopleFrames or otherwise the student
       // frames are fired
     }
     //RealAch
     //0 make a scale based upon PersonBio, Educ, GPA, job, etc questions

     //RealResources
     //1q

     //CURRENT TOTAL

     //COMPLETE SOON---------------------------------
     //SRQ
     //72??q
     //bsAssertiveCR
     if (isGo == true && pUsebsAssertiveCR == firePriority)
     {
       pUsebsAssertiveCR = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING bsAssertiveCR |||||||||||||||||||||||||\n");
       bsAssertiveCR.createbsAssertiveCRInstances();
       bsAssertiveCR.makebsAssertiveCRQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> bsAssertiveCRQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ bsAssertiveCR.questionFramesArray[0]);
       //  isUsebsAssertiveCR = false;
       //isGo is set within the makebsAssertiveCRFrames or otherwise the student
       // frames are fired
     }
     //bsIntimacy
     if (isGo == true && pUsebsIntimacy == firePriority)
     {
       pUsebsIntimacy = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING bsIntimacy |||||||||||||||||||||||||\n");
       bsIntimacy.createbsIntimacyInstances();
       bsIntimacy.makebsIntimacyQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> bsIntimacyQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ bsIntimacy.questionFramesArray[0]);
       //  isUsebsIntimacy = false;
       //isGo is set within the makebsIntimacyFrames or otherwise the student
       // frames are fired
     }
     //bsEquality
//     if (isGo == true && pUsebsEquality == firePriority)
//     {
//       pUsebsEquality = -1;
//       isGo = false;
//       resetFirePriority();
//       System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING bsEquality |||||||||||||||||||||||||\n");
//       bsEquality.createbsEqualityInstances();
//       bsEquality.makebsEqualityQuestionFrames();
//       System.out.println("||||||||| From CaresQuestControl----> bsEqualityQuestionFrames made||||||||||||");
//       System.out.println("radioButtonQuestionFrames[0]= "+ bsEquality.questionFramesArray[0]);
//       //  isUsebsEquality = false;
//       //isGo is set within the makebsEqualityFrames or otherwise the student
//       // frames are fired
//     }
     //bsIndependentRel
     if (isGo == true && pUsebsIndependentRel == firePriority)
     {
       pUsebsIndependentRel = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING bsIndependentRel |||||||||||||||||||||||||\n");
       bsIndependentRel.createbsIndependentRelInstances();
       bsIndependentRel.makebsIndependentRelQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> bsIndependentRelQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ bsIndependentRel.questionFramesArray[0]);
       //  isUsebsIndependentRel = false;
       //isGo is set within the makebsIndependentRelFrames or otherwise the student
       // frames are fired
     }
     //bsRomantic
     if (isGo == true && pUsebsRomantic == firePriority)
     {
       pUsebsRomantic = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING bsRomantic |||||||||||||||||||||||||\n");
       bsRomantic.createbsRomanticInstances();
       bsRomantic.makebsRomanticQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> bsRomanticQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ bsRomantic.questionFramesArray[0]);
       //  isUsebsRomantic = false;
       //isGo is set within the makebsRomanticFrames or otherwise the student
       // frames are fired
     }
     //bsLiberatedRole
     if (isGo == true && pUsebsLiberatedRole == firePriority)
     {
       pUsebsLiberatedRole = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING bsLiberatedRole |||||||||||||||||||||||||\n");
       bsLiberatedRole.createbsLiberatedRoleInstances();
       bsLiberatedRole.makebsLiberatedRoleQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> bsLiberatedRoleQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ bsLiberatedRole.questionFramesArray[0]);
       //  isUsebsLiberatedRole = false;
       //isGo is set within the makebsLiberatedRoleFrames or otherwise the student
       // frames are fired
     }
     //eDepression
//     if (isGo == true && pUseeDepression == firePriority)
//     {
//       pUseeDepression = -1;
//       isGo = false;
//       resetFirePriority();
//       System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING eDepression |||||||||||||||||||||||||\n");
//       eDepression.createeDepressionInstances();
//       eDepression.makeeDepressionQuestionFrames();
//       System.out.println("||||||||| From CaresQuestControl----> eDepressionQuestionFrames made||||||||||||");
//       System.out.println("radioButtonQuestionFrames[0]= "+ eDepression.questionFramesArray[0]);
//       //  isUseeDepression = false;
//       //isGo is set within the makeeDepressionFrames or otherwise the student
//       // frames are fired
//     }
     //eAnxiety
//     if (isGo == true && pUseeAnxiety == firePriority)
//     {
//       pUseeAnxiety = -1;
//       isGo = false;
//       resetFirePriority();
//       System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING eAnxiety |||||||||||||||||||||||||\n");
//       eAnxiety.createeAnxietyInstances();
//       eAnxiety.makeeAnxietyQuestionFrames();
//       System.out.println("||||||||| From CaresQuestControl----> eAnxietyQuestionFrames made||||||||||||");
//       System.out.println("radioButtonQuestionFrames[0]= "+ eAnxiety.questionFramesArray[0]);
//       //  isUseeAnxiety = false;
//       //isGo is set within the makeeAnxietyFrames or otherwise the student
//       // frames are fired
//     }
     //eAnger
//     if (isGo == true && pUseeAnger == firePriority)
//     {
//       pUseeAnger = -1;
//       isGo = false;
//       resetFirePriority();
//       System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING eAnger |||||||||||||||||||||||||\n");
//       eAnger.createeAngerInstances();
//       eAnger.makeeAngerQuestionFrames();
//       System.out.println("||||||||| From CaresQuestControl----> eAngerQuestionFrames made||||||||||||");
//       System.out.println("radioButtonQuestionFrames[0]= "+ eAnger.questionFramesArray[0]);
//       //  isUseeAnger = false;
//       //isGo is set within the makeeAngerFrames or otherwise the student
//       // frames are fired
//     }
     //RealDepression
     if (isGo == true && pUseRealDepression == firePriority)
     {
       pUseRealDepression = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING RealDepression |||||||||||||||||||||||||\n");
       RealDepression.createRealDepressionInstances();
       RealDepression.makeRealDepressionQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> RealDepressionQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ RealDepression.questionFramesArray[0]);
       //  isUseRealDepression = false;
       //isGo is set within the makeRealDepressionFrames or otherwise the student
       // frames are fired
     }
     //RealAnxiety
     if (isGo == true && pUseRealAnxiety == firePriority)
     {
       pUseRealAnxiety = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING RealAnxiety |||||||||||||||||||||||||\n");
       RealAnxiety.createRealAnxietyInstances();
       RealAnxiety.makeRealAnxietyQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> RealAnxietyQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ RealAnxiety.questionFramesArray[0]);
       //  isUseRealAnxiety = false;
       //isGo is set within the makeRealAnxietyFrames or otherwise the student
       // frames are fired
     }
     //RealAnger
     if (isGo == true && pUseRealAnger == firePriority)
     {
       pUseRealAnger = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING RealAnger |||||||||||||||||||||||||\n");
       RealAnger.createRealAngerInstances();
       RealAnger.makeRealAngerQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> RealAngerQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ RealAnger.questionFramesArray[0]);
       //  isUseRealAnger = false;
       //isGo is set within the makeRealAngerFrames or otherwise the student
       // frames are fired
     }
     //RealEmotions
     if (isGo == true && pUseRealEmotions == firePriority)
     {
       pUseRealEmotions = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING RealEmotions |||||||||||||||||||||||||\n");
       RealEmotions.createRealEmotionsInstances();
       RealEmotions.makeRealEmotionsQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> RealEmotionsQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ RealEmotions.questionFramesArray[0]);
       //  isUseRealEmotions = false;
       //isGo is set within the makeRealEmotionsFrames or otherwise the student
       // frames are fired
     }
     //added 3-14-02
     //RealPeopleSex
//     if (isGo == true && pUseRealPeopleSex == firePriority)
//     {
//       pUseRealPeopleSex = -1;
//       isGo = false;
//       resetFirePriority();
//       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING RealPeopleSex |||||||||||||||||||||||||\n");
//       RealPeopleSex.createRealPeopleSexInstances();
//       RealPeopleSex.makeRealPeopleSexQuestionFrames();
//     }
     //RealResources--added 3-14-02
//     if (isGo == true && pUseRealResources == firePriority)
//     {
//       pUseRealResources = -1;
//       isGo = false;
//       resetFirePriority();
//       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING RealResources |||||||||||||||||||||||||\n");
//       RealResources.createRealResourcesInstances();
//       RealResources.makeRealResourcesQuestionFrames();
//     }
     //FrameCareerGo
     if (isGo == true && pUseFrameCareerGo == firePriority)
     {
       pUseFrameCareerGo = -1;
       isGo = false;
//       resetFirePriority();
       FrameCareerGo frameCareerGoInstance = new FrameCareerGo();
       frameCareerGoInstance.setVisible(true);
       //above sets  CaresQuestControl.assignFirePriority(895,"pUseinCareer");
     }
     //inCareer
     System.out.println("At pUseinCareer firePriority= "+firePriority+ "isGo= "+ isGo);
     if (isGo == true && pUseinCareer == firePriority)
     {
       pUseinCareer = -1;
       isGo = false;
//       resetFirePriority();
       assignFirePriority(898,"pUseCalcCareerResults");
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inCareer |||||||||||||||||||||||||\n");
       inCareer.createinCareerInstances();
       inCareer.makeinCareerQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inCareerQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inCareer.questionFramesArray[0]);
       //set the rest of the career priorities depending upon above answers

     }
     if (isGo == true && pUseCalcCareerResults == firePriority)
     {
       pUseCalcCareerResults = -1;
       isGo = true;
//       resetFirePriority();
       setCareerPUseValues(firePriority);
     }

     //Scales set by inCareer results follow
     //inBus
     if (isGo == true && pUseinBus == firePriority)
     {
       pUseinBus = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inBus |||||||||||||||||||||||||\n");
       inBus.createinBusInstances();
       inBus.makeinBusQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inBusQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inBus.questionFramesArray[0]);
     }
     //inEngr
     if (isGo == true && pUseinEngr == firePriority)
     {
       pUseinEngr = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inEngr |||||||||||||||||||||||||\n");
       inEngr.createinEngrInstances();
       inEngr.makeinEngrQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inEngrQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inEngr.questionFramesArray[0]);
     }
     //inFineArt
     if (isGo == true && pUseinFineArt == firePriority)
     {
       pUseinFineArt = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inFineArt |||||||||||||||||||||||||\n");
       inFineArt.createinFineArtInstances();
       inFineArt.makeinFineArtQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inFineArtQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inFineArt.questionFramesArray[0]);
     }
     //inHelp
     if (isGo == true && pUseinHelp == firePriority)
     {
       pUseinHelp = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inHelp |||||||||||||||||||||||||\n");
       inHelp.createinHelpInstances();
       inHelp.makeinHelpQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inHelpQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inHelp.questionFramesArray[0]);
     }
     //inLang
     if (isGo == true && pUseinLang == firePriority)
     {
       pUseinLang = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inLang |||||||||||||||||||||||||\n");
       inLang.createinLangInstances();
       inLang.makeinLangQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inLangQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inLang.questionFramesArray[0]);
     }
     //inMed
     if (isGo == true && pUseinMed == firePriority)
     {
       pUseinMed = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inMed |||||||||||||||||||||||||\n");
       inMed.createinMedInstances();
       inMed.makeinMedQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inMedQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inMed.questionFramesArray[0]);
     }
     //inMiltCrim
     if (isGo == true && pUseinMiltCrim == firePriority)
     {
       pUseinMiltCrim = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inMiltCrim |||||||||||||||||||||||||\n");
       inMiltCrim.createinMiltCrimInstances();
       inMiltCrim.makeinMiltCrimQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inMiltCrimQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inMiltCrim.questionFramesArray[0]);
     }
     //inNatSci
     if (isGo == true && pUseinNatSci == firePriority)
     {
       pUseinNatSci = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inNatSci |||||||||||||||||||||||||\n");
       inNatSci.createinNatSciInstances();
       inNatSci.makeinNatSciQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inNatSciQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inNatSci.questionFramesArray[0]);
     }
     //inSocSci
     if (isGo == true && pUseinSocSci == firePriority)
     {
       pUseinSocSci = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inSocSci |||||||||||||||||||||||||\n");
       inSocSci.createinSocSciInstances();
       inSocSci.makeinSocSciQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inSocSciQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inSocSci.questionFramesArray[0]);
     }
     //inWoEthnicSt
     if (isGo == true && pUseinWoEthnicSt == firePriority)
     {
       pUseinWoEthnicSt = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inWoEthnicSt |||||||||||||||||||||||||\n");
       inWoEthnicSt.createinWoEthnicStInstances();
       inWoEthnicSt.makeinWoEthnicStQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inWoEthnicStQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inWoEthnicSt.questionFramesArray[0]);
     }
     //inWrite
     if (isGo == true && pUseinWrite == firePriority)
     {
       pUseinWrite = -1;
       isGo = false;
       resetFirePriority();
       //System.out.println("\n|||||||||||||||||||| START CREATING AND FIRING inWrite |||||||||||||||||||||||||\n");
       inWrite.createinWriteInstances();
       inWrite.makeinWriteQuestionFrames();
       //System.out.println("||||||||| From CaresQuestControl----> inWriteQuestionFrames made||||||||||||");
       //System.out.println("radioButtonQuestionFrames[0]= "+ inWrite.questionFramesArray[0]);
     }

     //COMPLETE THE FOLLOWING LATER------------------

     //iProblemSovling
     // 2-4?? not completed

     //iReasoning
     // 2?? not done


     //WHOLE SUBSECTION
     //iCareer

     //iAchievement
     //partly covered under themes, etc
     //do later

     //iWorkhabits
     //2?? partly done

     //bsMeetingPeople
     //for web visitors

     //bsPersuasion

     //bsManagement



   //Life skills questionnaire
     //work habits redone
     //coping redone

   //contingent questionnaires
   //SRQ
   //probation questionnaire?
   //World view questionnaire?
   //self view, self-worth, confidence, etc.
   //Detail Learning questionnaire?
   //Time management questionnaire?
   //Symptom checklist/psy problems & history??
   //Detailed emotional coping questionnaire??
   //Relationship beliefs quest?
   //Career questionnaire???


   //==============================================================
   //8-FIRE THE SECOND ROUND OF CHOOSING FURTHER TESTING DEPENDING
   //   UPON PREVOUS RESULTS
   if (isGo == true && pFrameChooseQuests == firePriority)
   {
     //Start here write a method to choose which quests to take
     // to fire the following with:
     // the radio buttons checked with recommendations and messages
     // that tell which have already been completed, then check the
     // results and reassing new firePriorities to those selected
     // questionnaires.
     // ALSO USE THIS FRAME FOR THOSE WHO WANT TO SELECT SPECIFIC
     //  QUESTs FROM BEGINNING
//     FrameChooseQuests frameChooseQuests = new FrameChooseQuests();
//     frameChooseQuests.setLocation(0,0);
//     frameChooseQuests.setSize(590,810);
//     frameChooseQuests.setVisible(true);

   }


   //==============================================================
   //9-CREATE the SCALES and related arrays. NOTE: use these to retrieve
    //   any questionInstance values needed.  NOTE: Questions may be on more than one
    //    scale.  But these are all PCategories.
    //    Also use these scale instances as sub-category/multiple-inheritance
    //    work-a-rounds; so questions can be both in their classes and in their
    //    scales.
    if (isGo == true && pCalcScaleScores == firePriority)
    {
      //System.out.println("  >>>>>>>>  CALCULATING THE SCALE SCORES  <<<<<<<<<<<<<");
//      CalcScaleScores calcScaleScoresInstance = new CalcScaleScores();

      /**
       * 1-Create all the scales and related Instances and Arrays
       */
      System.out.println("---- Creating the CalcScaleScores Instances and Arrays for ALL SCALES -----");
      CalcScaleScores.createScalesInstancesAndArrays();

      //2--CALCULATE THE SCALE SCORES
      System.out.println("--------------Calculating Scale Scores -------------");
      //wasCalcScaleScores.classInstance.calculateAllScaleScores();
      CalcScaleScores.calculateAllScaleScores();

      //3-CALCULATE AND "SEND" THE dataStorageInstance DATA
      //FOR person, student, etc.
      //quoted off for now--later eliminate?
//      DataStorage.storeAllFieldValues(Person.person);
//      DataStorage.storeAllFieldValues(Student.student);
      //add any additional instances created or subtract student??
      //print all data storage arrays (would send back to server here??)
//      if (printDetails == true)
//      {DataStorage.printDataStorageArrays();}

     }

   //end creating arrays if
   //}
     //==============================================================
     //10-MAKE AND FIRE THE USER FEEDBACK FORM
     if (isGo == true && pUserFeedback == firePriority)
      {
        isGo = false;
        pUserFeedback = -1;
        FrameUserFeedback frameUserFeedbackInstance = new FrameUserFeedback();
        frameUserFeedbackInstance.setVisible(true);
      }

     //==============================================================
     //11-PRINT THE RESULTS
     //
     if (isGo == true && pPrintTextResults == firePriority)
     {
        //4--AFTER CREATING AND CALC SCALES, NOW MAKE RESULTS TEXT FRAME
        //not needed, done auto within the FrameResultsText class:
        //           FrameResultsText.makeFrameResultsText(CalcScaleScores.allScaleInstancesArray);
        System.out.println("CalcScaleScores.allScaleInstancesArray= "+CalcScaleScores.allScaleInstancesArray);
        System.out.println("CalcScaleScores.allScaleInstancesArray[0]= "+CalcScaleScores.allScaleInstancesArray[0]);

        //when finished print the results
        if(CalcScaleScores.allScaleInstancesArray[0] != null)
        {
          System.out.println("CalcScaleScores.allScaleInstancesArray[0].scaleName= "+CalcScaleScores.allScaleInstancesArray[0].scaleName );}
        //set caresControl invisible
        CaresControl.frameStartSHAQInstance.setVisible(false);

        System.out.println("Person.person.userID = "+Person.person.userID);
        /**
         * @todo above line prints but sendDataToServer() is NOT firing
         */
        if (CaresControl.isSendDataToServer == true)
        {
          System.out.println("Starting sendDataToServer");
          //FrameResultsText.sendDataToServer();

          //added 8-01
          //this takes a lot of memory--later just print the strings without
          //  converting to stored arrays if memory is a problem
//          DataStorage.dataStorageInstance.makeAllDataStringArray();

          //if print results without FrameSendData popping up include it here:
          //for printing results directly with no frames in between
//          FrameResultsText frameResultsTextInstance = new FrameResultsText();
//          //make FrameResultsHelp
//          FrameResultsHelp frameResultsHelpInstance = new FrameResultsHelp();

            //CREATE THE RESULTS FRAMES
            frameResultsTextInstance = new FrameResultsText();
            frameResultsHelpInstance = new FrameResultsHelp();
//        Try
//        {
            //SEND DATA TO SERVER and logic related to reconnecting, etc.
            //CaresControl CaresControlDataInstance = new CaresControl();
            //only collect data from people over 18

            if(Person.person.age > 17)
            {
              System.out.println(" FIND 3456S ****>> FROM CaresQuestControl SEND DATA via CaresDataSender.sendDataToServer");
            //Reset SetConfigValues
            Config.SetConfigValues();
            //Set resultsFile name, path, url etc.
            Config.createResultsFileNames();

            CaresControl.resultsHtmlText = Config.ResultsTextHTMLpreface + CaresControl.resultsText + Config.ResultsTextHTMLend;

            CaresDataSender.sendDataToServer(Config.successPhpURLstring, Person.person.name,
                        Person.person.eMailAddress,Person.person.userID,CaresControl.dataText, CaresControl.resultsHtmlText);
                                         

            //have them use the CaresControl.java jButton1 to fetch the results to right window (tho could do it here?)

//       old data sender here       isDataSentToServer = CaresControlDataInstance.sendDataToJINIServer();//WAS .sendDataToRMIServer();
            }
            //send the full results text to create html file and showdoc will
            // download into Right browser window
            //CaresControlDataInstance.sendResultsToJINIServer();//WAS .sendResultsToRMIServer();
//This logic is not needed if taken care of within sendDataToRMIServer
//          }
//          catch(Exception e)
//          {
//            isDataSentToServer = false;
//          }
//
//          if (isDataSentToServer == false)
//          {
//            //pop up frame FrameServerData
//
//          }
//          else
//          {
//            //must make frameResultsHelpInstance BEFORE send data to server
//            //  because the dataText is created by makeFrameTextResults
//
//            //set visible only if sent data
//            frameResultsTextInstance.setVisible(true);
//            frameResultsHelpInstance.setVisible(true);
//            isFrameResultsTextPrinted = true;
//          }
        //end if
        }
        //for testing send data to server--by typing in 999999 or 999999999
//        if (Person.person.userID == "999999" || Person.person.userID == "999999999")
//        {
//          System.out.println("Starting sendDataToRMIServer");
//          FrameResultsText.sendDataToRMIServer();
//        }
        else
        {
          //for printing results directly with no frames in between
          frameResultsTextInstance = new FrameResultsText();
          frameResultsTextInstance.setVisible(true);
          //make FrameResultsHelp
          frameResultsHelpInstance = new FrameResultsHelp();
          frameResultsHelpInstance.setVisible(true);
          isFrameResultsTextPrinted = true;
        }
        //9-6-02 send full text results to Servlet to return to html section of CaresControl
        //use if do automatically instead of by jButton5
//        System.out.println("sendShaqResultsTextToServelet called now");
//        CaresControl.isSendShaqResultsTextToServelet = true;

        //for testing send data to server POPS UP A FRAME--
//        FrameTestServerData frameTestServerDataInstance = new FrameTestServerData();
//        frameTestServerDataInstance.setVisible(true);

        //following moved to FrameTestServerData
//        //for printing results directly with no frames in between
//        FrameResultsText frameResultsTextInstance = new FrameResultsText();
//        //frameResultsTextInstance.jTextPane1.setText(FrameResultsText.makeResultsText());
//        //for now set visible only after text sent to server
//        frameResultsTextInstance.setVisible(true);
//
//        //make FrameResultsHelp
//        FrameResultsHelp frameResultsHelpInstance = new FrameResultsHelp();
//        frameResultsHelpInstance.setVisible(true);
     }
     //if it doesn't find a matching priority on one cycle, then recycle
     //  after setting firePriority to next higher fire number
     if (isGo == true && firePriority < maxFirePriorityValue)
     {
        resetFirePriority();
        System.out.println("NO FIRINGS THIS CYCLE, firePriority reset to= "+firePriority);
        manageFiringQue(evt);
     }
      System.out.println("FINAL isGo= "+ isGo);


  //end manageFiringQue method
  }

//  /**
//   * To form a virtual stack use the pUse numbers for priorities??
//   */
//
//  public static int increaseAllQuePriorities()
//  {
//    increaseQuePriority(pUseStudentBasicData);
//    increaseQuePriority(pUsebsLearning);
//    increaseQuePriority(pUseiLifeThemes);
//    increaseQuePriority(pUseiIEControl);
//  }
//
//  public static int increaseQuePriority(int variable)
//  {
//    if (variable == 0 || variable == 1 || variable == 9)
//    { //do nothing
//    }
//    else
//    {
//      variable<<<<;
//      System.out.println("New value for variable= "+ variable);
//    }
//  }


/**
 * QUE SYSTEM--works as follows:
 * 1-isVariables for each subroutine assigned a value (1 to 99) for priorities (low = highest)
 *     -1 is assigned if isVariable is already fired or not to be considered.
 *
 * 2-A static int priorityArray contains 1001? "slots" filled with -1 = skip/fired;
 *     1000 = empty; 1 = assigned; or 0 = irrelevant for now.
 * 3-A static variable firePriority (the index of the priorityArray)
 *     is set to the number of the next
 *     isVariable to be fired.  That number is determined by a method
 *     setCurrentFireValue that finds the next available number (= +1) in the
 *     priorityArray.
 * 4-The overall method (manageFiringQue) that uses this algorithm triggers the setCurrentFireValue
 *     on each cycle that it is used.
 * 5-A method that uses "invoke" makes and executes the if statement method that
 *     is executed when it is its time.
 *
 *
 * The methods needed follow:
 */
   /**
    * Method to set the fire Priority of each method to be fired;
    * MUST SET THE pVarible SEPARATELY!!
    */
   public static int assignFirePriority(int value)//, String variableName)
   {
      if (firePriorityStack[value] == fireStackEmptyValue)//if 100 means it is unassigned
      {
      //pVariable = value;
      firePriorityStack[value] = fireValue; // means that it is assigned;
      System.out.println("assignFirePriority assigning pVariable= "+ value);
      }
      else //auto assign to next higher priority available
      {
        if(value > 0)
        {
          value++;
          System.out.println("Revised new value not yet assigned= "+ value);
          assignFirePriority(value);
        }
      }
     return value;
   }

   public static int assignFirePriority(int value, String fieldName)
   {
      if (firePriorityStack[value] == fireStackEmptyValue)//if 100 means it is unassigned
      {
        //pVariable = value;
        firePriorityStack[value] = fireValue; // means that it is assigned;
        Reflection.setStaticFieldValue("CaresProject2.CaresQuestControl",fieldName,value);
        if(isPrintDetails == true)
        {System.out.println("assignFirePriority for assigning pVariable= "+
          fieldName+ " value= "+ value);
        }
      }
      else //auto assign to next higher priority available
      {
        if(value > 0)
        {
          value++;
          System.out.println("Revised new value not yet assigned= "+ value);
          assignFirePriority(value);
        }
      }

     return value;
   }

   //for use in method to assign a group at once only
   public static int assignFirePriority(int beginValue,int incrementValue)
   {
      //static variable used for within the calling method
      if (currentPrValue == 0)
      { currentPrValue = beginValue;
      }
      else
      {
        currentPrValue = currentPrValue + incrementValue;
      }
      if (firePriorityStack[currentPrValue] == fireStackEmptyValue)//if 100 means it is unassigned
      {
      //pVariable = value;
      firePriorityStack[currentPrValue] = fireValue; // means that it is assigned;
      System.out.println("assignFirePriority assigning pVariable= "+ currentPrValue);
      }
      else //auto assign to next higher priority available
      {
        if(currentPrValue > 0)
        {
          currentPrValue++;
          System.out.println("Revised new currentPrValue not yet assigned= "+ currentPrValue);
          assignFirePriority(currentPrValue);
        }
      }

     return currentPrValue;
   }

   /**
    * Used for re-assigning the pVariable fire priority values values,
    *  This looks up the old one in the firePriorityStack and re-initializes it.
    *  then assigns a new fire priority
    *
    */
    public static int reAssignFirePriority(int newValue, int oldValue)
    {
      firePriorityStack[oldValue] = fireStackEmptyValue;
      assignFirePriority(newValue);
      System.out.println("reAssignFirePriority from= "+oldValue+ " to= "+newValue);
      return newValue;
    }




   /**
    * Method for resetting firePriority on each cycle
    */
   public static int resetFirePriority()
   {
     do
     {
      firePriority++;
      if(isPrintDetails)
      {System.out.println("Resetting firePriority to= "+firePriority);}
      //System.out.println("firePriorityStack[firePriority]= "+firePriorityStack[firePriority]);
     }
     while (firePriorityStack[firePriority] != 1 &&
                                     firePriority < maxFirePriorityValue);

//     System.out.println("Resetting firePriority to= "+firePriority);
     return firePriority;
   }

   public static void initializeFirePriorityStack()
   {
      System.out.println("Calling method initializeFirePriorityStack initial value = "+ fireStackEmptyValue);
      MyMethods.initializeExistingArray(firePriorityStack, fireStackEmptyValue);
//      System.out.println("firePriorityStack[0] = "+firePriorityStack[0]);
//      System.out.println("firePriorityStack[1] = "+firePriorityStack[1]);
//      System.out.println("firePriorityStack[2] = "+firePriorityStack[2]);
//      System.out.println("firePriorityStack[3] = "+firePriorityStack[3]);
   }

   /**
    * MUST UPDATE VALUES IF CHANGE ARRAY IN inCareer
    */
   public static void setCareerPUseValues(int currentFirePriority)
   {
     int i = 0;
     PCategory inCareerCurrentInstance;
     int numQuestInstances = inCareer.questionInstancesArray.length;
     System.out.println("IN setCareerPUseValues i= "+ i );

     for (i = 0; i < numQuestInstances; i++)
     {
         inCareerCurrentInstance = inCareer.questionInstancesArray[i];
         //System.out.println("inCareerCurrentInstance.name= "+ inCareerCurrentInstance.name);

         if(inCareerCurrentInstance.name == "carIBUSiness" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinBus");
         }
         if(inCareerCurrentInstance.name == "carIENGINeer" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinEngr");
         }
         if(inCareerCurrentInstance.name == "carIFNART" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinFineArt");
         }
         if(inCareerCurrentInstance.name == "carIHELP" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinHelp");
         }
         if(inCareerCurrentInstance.name == "carILANGuage" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinLang");
         }
         if(inCareerCurrentInstance.name == "carIMED" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinMed");
         }
         if(inCareerCurrentInstance.name == "carIMILTaryLawEnforce" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinMiltCrim");
         }
         if(inCareerCurrentInstance.name == "car1INATSCI" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinNatSci");
         }
         if(inCareerCurrentInstance.name == "carISOCSCI" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinSocSci");
         }
         if(inCareerCurrentInstance.name == "carIETHNIC" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinWoEthnicSt");
         }
         if(inCareerCurrentInstance.name == "carIWRITE" &&
             inCareerCurrentInstance.intAnswerValue > 4)
         {
            currentFirePriority++;
            assignFirePriority(currentFirePriority,"pUseinWrite");
         }

     }

   }


   public static void assignPriorityValuesToArray
                       (int beginValue, int incrementValue, int[] isFireArray)
   {
      System.out.println("Assigning priorities to array, beginValue= "+beginValue+
         "  incrementValue= "+ incrementValue);
       currentPrValue = beginValue;
       //Students Only
       if(isFireArray[0] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseStudentBasicData1 = currentPrValue; }
       if(isFireArray[1] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseStudentBasicData2 = currentPrValue; }
       //Learning
       if(isFireArray[2] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsLearning = currentPrValue; }
       if(isFireArray[3] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsLearningAreas = currentPrValue; }
       if(isFireArray[4] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsLearningDisable = currentPrValue; }
       //iAcademicMotivation is [45]
       //Self
       if(isFireArray[5] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiLifeThemesAch = currentPrValue; }
       if(isFireArray[6] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiLifeThemesSoc = currentPrValue; }
       if(isFireArray[7] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiLifeThemesNeg = currentPrValue; }
       if(isFireArray[8] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiLifeThemes = currentPrValue; }

//       if(isFireArray[6] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseiLifeThemes2 = currentPrValue; }
       if(isFireArray[9] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiIEcontrol = currentPrValue; }
//       if(isFireArray[10] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseiIEcontrol2 = currentPrValue; }
       if(isFireArray[11] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsSelfManagement = currentPrValue; }
//       if(isFireArray[12] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUsebsSelfManagement2 = currentPrValue; }
       if(isFireArray[13] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsEmotionManagement = currentPrValue; }
//       if(isFireArray[14] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUsebsEmotionManagement2 = currentPrValue; }
       if(isFireArray[15] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiWorldview = currentPrValue; }
       if(isFireArray[16] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiWorldviewFears = currentPrValue; }
       if(isFireArray[17] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiTopBV = currentPrValue; }
       if(isFireArray[18] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiTopBV2 = currentPrValue; }
       if(isFireArray[19] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiSelf = currentPrValue; }
//       if(isFireArray[20] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseiSelf2 = currentPrValue; }
       //OUTCOMES-happy
       if(isFireArray[21] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseeHappy = currentPrValue; }
//       if(isFireArray[22] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseeHappy2 = currentPrValue; }
       if(isFireArray[23] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseRealHealth = currentPrValue; }
       if(isFireArray[24] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseRealHealth2 = currentPrValue; }
       if(isFireArray[25] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseRealPeople = currentPrValue; }
//       if(isFireArray[26] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseRealPeopleSex = currentPrValue; }
//       if(isFireArray[27] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseRealResources = currentPrValue; }
       //PEOPLE
       if(isFireArray[28] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsAssertiveCR = currentPrValue; }
//       if(isFireArray[29] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUsebsAssertiveCR2 = currentPrValue; }
       if(isFireArray[30] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsIntimacy = currentPrValue; }
//       if(isFireArray[31] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUsebsIntimacy2 = currentPrValue; }
       if(isFireArray[32] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsEquality = currentPrValue; }
       if(isFireArray[33] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsIndependentRel = currentPrValue; }
       if(isFireArray[34] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsRomantic = currentPrValue; }
       if(isFireArray[35] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUsebsLiberatedRole = currentPrValue; }
       //OTHER EMOTIONS
//       if(isFireArray[36] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseeDepression = currentPrValue; }
//       if(isFireArray[37] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseeAnxiety = currentPrValue; }
//       if(isFireArray[38] == 1){assignFirePriority(currentPrValue,incrementValue);
//       pUseeAnger = currentPrValue; }
       if(isFireArray[40] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseRealDepression = currentPrValue; }
       if(isFireArray[41] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseRealAnger = currentPrValue; }
       if(isFireArray[42] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseRealAnxiety = currentPrValue;}
       if(isFireArray[43] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseRealEmotions = currentPrValue;}
       if(isFireArray[44] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseFrameCareerGo = currentPrValue; }
       //iAcademicMotivation -- added here 3-15-02
       if(isFireArray[45] == 1){assignFirePriority(currentPrValue,incrementValue);
       pUseiAcademicMotivation = currentPrValue; }

    System.out.println("------Priority Values Assigned to array members-----");
   }

      //PRIORITY ARRAYS FOR DECIDING WHICH INSTANCES WILL BE INCLUDED
   //   in any particular firing set
  //fireArrays Use these EXCLUSIVELY??? Sets the profile of the ones that fire
     //                         STARTS W/ZERO=>0-1:Student;2-4:Learn;5-16:Self;17-23:Outcomes;24-29:SRQ;
     //                                           L LaLdTaTsTnTiIE  SMx EMx WvWfBvBvSlf Hax Hth PeSxReCRx Itx E IpR L x x  x  x  RD RAgRAxRE C Am
                                           // {0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7, 8, 9, 0, 1, 2, 3, 4, 5};
   public static int[] pTESTisFireArray=     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 1};
   //U100 combinations
   public static int[] pU100isFireArray1 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray2 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray3 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray4 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray5 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray6 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray7 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray8 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,1,0,1,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray9 =   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray10=   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray11=   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pU100isFireArray12=   {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1,0,1,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
     //                                           L LaLdTaTsTnTiIE  SMx EMx WvWfBvBvSlf Hax Hth PeSxReCRx Itx E IpR L x x  x  x  RD RAgRAxRE C Am
                                           // {0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7, 8, 9, 0, 1, 2, 3, 4};
   //complete versions
   public static int[] pCOMPLETEStFireArray= {1,1,1,1,1,1,1,1,1,1,0,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 1};
   public static int[] pCOMPLETwCarFireArray={1,1,1,1,1,1,1,1,1,1,0,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 1, 1};
   public static int[] pCOMPLETENStFireArray={0,0,0,0,0,1,1,1,1,1,0,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   //
   public static int[] pCREDITFireArray=     {1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,1,0,1,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 1, 0, 1};
   public static int[] pSTUDENTFireArray=    {1,1,1,0,0,1,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 1};
   public static int[] pSTandLEARN1FireArray={1,1,1,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 1};
   public static int[] pCareerOnlyFireArray= {1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 1, 0};
     //                                           L LaLdTaTsTnTiIE  SMx EMx WvWfBvBvSlf Hax Hth PeSxReCRx Itx E IpR L x x  x  x  RD RAgRAxRE C Am
   //by major groups                       // {0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7, 8, 9, 0, 1, 2, 3, 4};
   public static int[] pLEARN1FireArray =    {1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 1};
   public static int[] pLEARN2FireArray =    {0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 1};
   public static int[] pLEARN23FireArray =   {0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 1};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
   public static int[] pBELIEFS1FireArray =  {0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pBELIEFS2FireArray =  {0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pVALUESFireArray =    {0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   //skills
   public static int[] pbs1FireArray =       {0,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pbs2FireArray =       {0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   //all self-related (non-interpersonal)
   public static int[] pSELF1AllFireArray =  {0,0,0,0,0,1,1,1,1,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pSELF2AllFireArray =  {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pSMFireArray =        {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pGlProcFireArray =    {0,0,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pEmMFireArray =       {0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
     //                                           L LaLdTaTsTnTiIE  SMx EMx WvWfBvBvSlf Hax Hth PeSxReCRx Itx E IpR L x x  x  x  RD RAgRAxRE C Am
                                          // {0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7, 8, 9, 0, 1, 2, 3, 4};
   //interpersonal
   public static int[] pPEOPLE1FireArray =   {0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pPEOPLEOnlyFireArray ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pGlAloneFireArray =   {0,0,0,0,0,1,1,1,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   //conflicts--assert only
   public static int[] pAssertAllFireArray = {0,0,0,0,0,1,0,1,1,1,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   //outcomes only
   public static int[] pOUTCOMES1FireArray = {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
   public static int[] pOUTCOMES2FireArray = {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
   public static int[] pOUTCOMESAllFireArray={0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   //public static int[] pCOMPLETENSFireArray ={0,0,0,0,0,1,0,1,1,1,0,1,0,1,1,1,1,0,1,0,0,1,1,1,1,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   //emotions focus
   public static int[] pGlAnxietyFireArray=  {0,0,0,0,0,1,0,1,1,1,0,1,0,1,1,0,0,1,0,0,0,0,0,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pGlDepressFireArray=  {0,0,0,0,0,1,0,1,1,1,0,1,0,1,1,0,0,1,1,0,0,0,0,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
   public static int[] pGlAngerFireArray=    {0,0,0,0,0,1,0,1,1,0,0,1,0,1,1,0,0,1,1,0,0,0,0,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0, 0, 0, 1, 1, 1, 0, 0, 0};
     //                                           L LaLdTaTsTnTiIE  SMx EMx WvWfBvBvSlf Hax Hth PeSxReCRx Itx E IpR L x x  x  x  RD RAgRAxRE C Am
                                          // {0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4, 5, 6, 7, 8, 9, 0, 1, 2, 3};
   //public static int[] pGCareerIntOnly =     {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 1};

//   public static int[] {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1, 1, 1, 1, 1, 1, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[] {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0, 0, 0, 0, 0, 0};
//   public static int[]
//   public static int[]
//   public static int[]


  /**
   *   use random number generator to choose from array of U100 fire arrays
   *   Note: must add any new U100 fire arrays to this array
   */
  public static int[][] U100FireArraysArray =
    {pU100isFireArray1,pU100isFireArray2,pU100isFireArray3,pU100isFireArray4,
        pU100isFireArray5,pU100isFireArray6,pU100isFireArray7,pU100isFireArray8,
        pU100isFireArray9,pU100isFireArray10,pU100isFireArray11,pU100isFireArray12};

  public static RandomIntGenerator randomIntGeneratorInstance =
    new RandomIntGenerator(0, U100FireArraysArray.length-1);
  public static int[] pU100isFireArray =
     randomIntGeneratorInstance.randomDrawIntArray(U100FireArraysArray);

  //make class instance
  public static CaresQuestControl caresQuestControlInstance =
     new CaresQuestControl();
 //making these causes premature developing of results with no values
//  public static FrameResultsText frameResultsTextInstance = new FrameResultsText();
//  public static FrameResultsHelp frameResultsHelpInstance = new FrameResultsHelp();
  public static boolean isFrameResultsTextPrinted = false;

  public void actionPerformed(ActionEvent evt)
   {
    System.out.println ("+++++++++++ The actionPerformed under caresQuestControlInstance fired  ++++++++++++");

    manageFiringQue(evt);
//    if (firePersonBioFrames = true)
//    {
//
//      //reset variable
//      firePersonBioFrames = false;
//
//      System.out.println("START PersonBio");
//      PersonBio.createPersonBioInstances();
//      PersonBio.makePersonBioFrames();
//      System.out.println("From CaresQuestControl----> PersonBioFrames made");
//      System.out.println("radioButtonQuestionFrames[0]= "+ PersonBio.questionFramesArray[0]);
//
//    }
//
//    //make this more sophisticated (does person want this type of help?)
//    if (Person.person.isStudent == true)
//    {
//        System.out.println("Button 4 pushed");
//        StudentBasicData.createStudentBasicDataInstances();
//        StudentBasicData.makeStudentQuestionFrames();
//        System.out.println("From Cares Control----> StudentBasicDataFrames made");
//        System.out.println("radioButtonQuestionFrames[0]= "+ StudentBasicData.questionFramesArray[0]);
//
//    }


    System.out.println ("+++ End of caresQuestControlInstance ActionPerformed Method +++");
   }

   /**
    *  CLASS VARIABLES
    */

    /**
     * OVERALL
     */
   public static int maxTotalQuestions = 0;
   //used by method in setting priorities only.See firePriority
   public static boolean printDetails =  false;
   public static int currentPrValue = 0;
   /**
    * for the int control variables 0 = false, 1=use/fire, 9=used/fired/don't fire again
    */
   public static boolean isGo = true;
   public static int pPrimaryLogic = 0;
   public static int pSecondaryLogic = 0;
   public static int pTertiaryLogic = 0;
   public static int pFrameChooseQuests = 0;
   public static int pCalcScaleScores = 0;
   public static int pUserFeedback = 0;
   public static int pPrintTextResults = 0;
 //not needed??  public static int isCreateInstancesAndArrays = true;

   public static boolean isInitializeDataArrays = true;
   //is created and then fired before other questions
//   public static boolean isFireframePurpose = true;
   public static boolean isFireframePermission = true;
   public static boolean isFrameUserGoals = false;
   public static boolean isPersonDataFrame = false;
   public static boolean isFrameUserType = false;
   public static boolean isFirePersonBio = false;
   public static boolean isFrameCourseCredit = false;
   public static boolean isFrameU100Credit = false;
   public static boolean isFrameNonU100Credit = false;
   public static boolean isFrameResearchSubject = false;

//   public static boolean

   //set to true when finished creating all the needed instances
   public static boolean isFireQuestionInstances = false;

   //rest of questions
//   public static int isUse
   public static int pUseStudentBasicData1 = 0;
   public static int pUseStudentBasicData2 = 0;
   public static int pUsebsLearning = 0;
   public static int pUsebsLearningAreas = 0;
   public static int pUsebsLearningDisable = 0;
   public static int pUseiAcademicMotivation = 0;
//   public static int pUse
//   public static int pUse
//   public static int pUse
   public static int pUseiLifeThemesAch = 0;
   public static int pUseiLifeThemesSoc = 0;
   public static int pUseiLifeThemesNeg = 0;
   public static int pUseiLifeThemes = 0;
   //public static int pUseiLifeThemes2 = 0;
   public static int pUseiIEcontrol = 0;
//   public static int pUseiIEcontrol2 = 0;
   public static int pUsebsSelfManagement = 0;
   public static int pUsebsEmotionManagement = 0;
   public static int pUseiWorldview = 0;
   public static int pUseiWorldviewFears = 0;
   public static int pUseiTopBV = 0;
   public static int pUseiTopBV2 = 0;
   public static int pUseiSelf = 0;
//   public static int pUseiSelf2 = 0;
   public static int pUseeHappy = 0;
   public static int pUseRealHealth = 0;
   public static int pUseRealHealth2 = 0;
   public static int pUseRealPeople = 0;
//   public static int pUseRealPeopleSex = 0;
//   public static int pUseRealResources = 0;
   public static int pUsebsAssertiveCR = 0;
   public static int pUsebsIntimacy = 0;
   public static int pUsebsEquality = 0;
   public static int pUsebsIndependentRel = 0;
   public static int pUsebsRomantic = 0;
   public static int pUsebsLiberatedRole = 0;
   public static int pUseeDepression = 0;
   public static int pUseeAnxiety = 0;
   public static int pUseeAnger = 0;
   public static int pUseRealDepression = 0;
   public static int pUseRealAnxiety = 0;
   public static int pUseRealAnger = 0;
   public static int pUseRealEmotions = 0;
   //for interest test
   public static int pUseinCareer = 0;
   public static int pUseFrameCareerGo = 0;
   public static int pUseCalcCareerResults = 0;
   public static int pUseinBus = 0;
   public static int pUseinEngr = 0;
   public static int pUseinFineArt = 0;
   public static int pUseinHelp = 0;
   public static int pUseinLang = 0;
   public static int pUseinMed = 0;
   public static int pUseinMiltCrim = 0;
   public static int pUseinNatSci = 0;
   public static int pUseinSocSci = 0;
   public static int pUseinWoEthnicSt = 0;
   public static int pUseinWrite = 0;

//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
//   public static int pUse
   public static boolean isPrintDetails = false;

//   BASIC TYPES OF USERS from FrameUserType to Person
   public static boolean isStudent = false;
   public static boolean isCourseCredit = false;
   public static boolean isU100 = false;
   public static boolean isInstructorWantsCredit = false;
   public static boolean isWantsSpecificHelp = false;
   public static boolean isSpecificQuestionnaire = false;
   public static boolean isPreviousUser = false;
//   public static int
//   public static int
//   public static int
   public static int pStudent = 0;
   public static int pCourseCredit = 0;
   public static int pU100 = 0;
   public static int pInstructorWantsCredit = 0;
   public static int pResearchSubject = 0;
   public static int pWantsSpecificHelp = 0;
   public static int pSpecificQuestionnaire = 0;

//   public static int
//   public static int
//   public static int
//   public static int
//   public static int
//   public static int
//   public static int
//   public static int

   //BASIC USER GOALS from FrameUserGoals to Person
   //MAY NOT NEED TO SET THESE GOALS, JUST USE PERSON VARIABLES??
//   public static int isGoal
//   public static int isGoal
//   public static int isGoal
//   public static int isGoal
//   public static int isGoal
//   public static int isGoal
//   public static int isGoal
//   public static int isGoal
//   public static int isGoal

//   variables for the working memory
   //the current index of the stack below-Start at 1 or initialized if-then's fire
   public static int firePriority = 1;
   public static int maxFirePriorityValue = 1000;
   public static int fireStackEmptyValue = 9; //the empty value in a slot to indicate that it is empty
   public static int fireValue = 1;
   public static int[] firePriorityStack = new int[maxFirePriorityValue+1];

   //RMI variables
   public static boolean isDataSentToServer = false;
   public static CaresControl CaresControlDataInstance = new CaresControl();
   public static FrameResultsText frameResultsTextInstance;// = new FrameResultsText();
          //make FrameResultsHelp
   public static FrameResultsHelp frameResultsHelpInstance;// = new FrameResultsHelp();

}

|#