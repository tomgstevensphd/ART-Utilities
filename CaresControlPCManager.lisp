;;**************************** CaresControlPCManager.lisp ***********************
;;
;;  COPY of CaresControlPCManager.java
;;
#|
package CaresProject2;

/**
 * Title:        CARES Project
 * Description:
 * Copyright:    Copyright (c) 2000
 * Company:      California State University, Long Beach
 * @author Tom G. Stevens PhD
 * @version 1.0
 *
 *
 * This class will use information from early frames to determine which
 *   question instances and related arrays to create.
 *
 * Then it will create the needed question instances and arrays.
 *
 * It must be flexible enough so that someone who has already completed some
 *   scales can later start up and do one or two scales.
 *
 * Or someone could return to the beginning Cares control frame etc and choose
 *   to take additional scales.
 *
 */

public class CaresControlPCManager extends PCategory
{

  public CaresControlPCManager()
  {
  }

  /**
   * Later fix the following to make scales and instances created to
   * reflect the choices of the consumer.
   *
   * For now I am creating all scales, instances, and arrays.
   *
   */
  public void createScaleInstancesAndArrays()
  {
   //1-INITIALIZE THE DataStorageStructures
//   DataStorage.initializeDataStoreArrays();

   //2-DO INITIAL ASSESSMENT TO DETERMINE QUESTIONS TO BE ASKED

   //3--CREATE the QUESTION INSTANCES FOR ALL CLASSES before do scales
   //   Can't create scales until questions done
   System.out.println(">>> FIRST CREATE THE QUESTION INSTANCES FOR ALL QUESTION CLASSES  ");
//   System.out.println("   >>> CREATE StudentBasicDataInstances <<< ");
//   StudentBasicData.createStudentBasicDataInstances();

//   System.out.println("   >>> CREATE bsLearningInstances <<< ");
//   bsLearning.createbsLearningInstances();

   System.out.println("   >>> CREATE iIEcontrolInstances <<< ");
   iIEcontrol.createiIEcontrolInstances();
   System.out.println("iIEcontrol.classInstance.questionInstancesArray= "+
         iIEcontrol.classInstance.questionInstancesArray);

   //for test purposes only
   PCategory firstInstance = iIEcontrol.classInstance.questionInstancesArray[0];
   System.out.println("firstInstance.className= "+ firstInstance.className);
   //end test
   //append the overall array of class instances
   appendQuestionClassInstancesArray(iIEcontrol.classInstance);
   System.out.println("questionClassInstancesArray= "+ questionClassInstancesArray);
   String firstClassName = questionClassInstancesArray[0].className;
   System.out.println("firstClassName of manager questionClassInstancesArray = "+
          firstClassName);

   //is this really needed??
      iIEcontrol iIEcontrolInstance = new iIEcontrol();
      iIEcontrolInstance = iIEcontrol.classInstance;
      System.out.println("iIEcontrolInstance= "+iIEcontrolInstance);
      System.out.println("iIEcontrolInstance.questionInstancesArray= "+
         iIEcontrol.questionInstancesArray);
//   System.out.println("   >>> CREATE iIEcontrolInstances <<< ");
//   iIEcontrol iIEcontrolInstance = new iIEcontrol();
//   System.out.println("iIEcontrolInstance= "+iIEcontrolInstance);
//   iIEcontrol.createiIEcontrolInstances();
//   System.out.println("iIEcontrol.classInstance.questionInstancesArray= "+
//         iIEcontrol.classInstance.questionInstancesArray);
//   System.out.println("iIEcontrol.iIEcontrolInstance.questionInstancesArray= "+
//         iIEcontrolInstance.questionInstancesArray);
//   //for test purposes only
//   PCategory firstInstance = iIEcontrol.classInstance.questionInstancesArray[0];
//   System.out.println("firstInstance.name= "+ firstInstance.name);
//   //end test
//   //append the overall array of class instances
//   appendQuestionClassInstancesArray(iIEcontrolInstance);
//
//   //do this last to make sure it has above modifications???
//   iIEcontrol.classInstance = iIEcontrolInstance;
//   System.out.println("iIEcontrol.classInstance= "+iIEcontrol.classInstance);

    //4-CREATE the SCALES and related arrays. NOTE: use these to retrieve
    //   any questionInstance values needed.  NOTE: Questions may be on more than one
    //    scale.  But these are all PCategories.
    //    Also use these scale instances as sub-category/multiple-inheritance
    //    work-a-rounds; so questions can be both in their classes and in their
    //    scales.
   System.out.println("---- Creating the CalcScaleScores Instances and Arrays for ALL SCALES -----");
   CalcScaleScores calcScaleScoresInstance = new CalcScaleScores();
   CalcScaleScores.classInstance = calcScaleScoresInstance;
   CalcScaleScores.createScalesInstancesAndArrays();





   //START HERE
   //IF THESE WORK CREATE FOR EACH OF THE CLASSES IN FrameCaresTest
   // and change the related action performed there.



  }

    public void appendQuestionClassInstancesArray(PCategory classInstance)
    {
      //NOTE: May not be able to retreive values from
      //    the questionClassInstances array because it is a PCategory array
      //    holding subclass instances that are NOT identical to PCategory
      //    (they are children). Not sure which--if any--values can retreive.
      //    caused a big problem trying to retrieve questionInstancesArray.
      //    Check it out later??
      questionClassInstancesArray[currentQuestClassIndex] = classInstance;
      System.out.println("ADDING TO questionClassInstancesArray=> classInstance.className= "+ classInstance.className);
      currentQuestClassIndex++;

    }

    public void setUserTypeAlgorithms()
    {
      isCollegeStudent = Person.person.isCollegeStudent;
      isCourseCredit = Person.person.isCourseCredit;
      isCreditCSULB = Person.person.isCreditCSULB;
      isU100 = Person.person.isU100;
      isExperiencedSelfHelp = Person.person.isExperiencedSelfHelp;
      isFacultyOrAdmin = Person.person.isFacultyOrAdmin;



    }




    //class variables
    public static CaresControlPCManager thisClassInstance;
    public static int totalNumQuestClassArrays = 1;
    public static PCategory[] questionClassInstancesArray =
                               new PCategory[totalNumQuestClassArrays];
    public int currentQuestClassIndex = 0;



  //FOLLOWING ALL MOVED TO CalcScaleScores
  //make arrays to store PCategory classes and class instances in;
//  public int TotalScaleInstances = 1;
//  public PCategory[] allScaleInstancesArray = new PCategory[TotalScaleInstances];;
//  public String[] allScaleInstanceNamesArray = new String[TotalScaleInstances];
//  public String[] allScaleNamesArray = new String[TotalScaleInstances];
//  public static PCategory[] PCategoryClassArray = new PCategory[100];
//  public static int PCategoryClassArrayLength = 0;

}
|#

