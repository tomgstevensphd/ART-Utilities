;; *************************** DataStorage.lisp *************************************8
;;
;; COPY of DataStorage.java
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
 */
//import java.util.Arrays;
import java.io.PrintStream;

/**
 * This class is for storing data to be returned to the server.
 * For now it retain a simple format that can still be easily deciphered
 * and used for data analysis.
 * RULES:
 * 1-varIdArray[0] contains the format: "name;scaleName;
 * 2-therfore the storage indexs go from 1 to totalDataItems
 * 3-ALL variables should store an int value (boolean +1 = true; 0 = false);
 * 4-OPTIONALLY: may store to String, boolean, or int; but keep index the
 *   same as for the varIdArray;
 * 5-RELATIVE VALUE = relativeScore =(intValue / number of responses per item):
 *       store in separate array with same index;
 * 6-Unless find clever scheme for a FIXED ORDER that won't vary from student to student;
 * then it is OK to store in order of firing by any person; Later to be retreived
 * by the variable name and matching index of the int value etc.
 *
 */
public class DataStorage
{

  public DataStorage()
  {
  }

  /**
   * Following works on ALL objects for sending ALL field values into a
   * particular dataStorageInstance in string form.
   *
   * To retrieve, simply look up the value of the class static variables
   *  personStringFieldArray and personStringFieldValueArray
   *
   */
  public static String[] storeAllFieldValues(Object targetInstance)
  {
     String[] fieldStringArray;
     //Object[] fieldValueArray;
     String[] stringFieldValueArray;

     stringFieldValueArray =
           Reflection.getAllFieldValuesToStringArray(targetInstance);
     fieldStringArray = Reflection.fieldStringArray;
     if(printDetails == true)
     {System.out.println("From DataStorage.storeAllFieldValues fieldStringArray= "+fieldStringArray);
     }
 //    fieldValueArray = Reflection.fieldValueArray;
//     stringFieldValueArray = Reflection.stringFieldValueArray;
     //copy values to class data
     personStringFieldArray = MyMethods.myStringArrayCopy(personStringFieldArray,
        currentPersonArrayIndex, fieldStringArray, 0, fieldStringArray.length);
     //if want following must write method to copy object arrays
     //personFieldValueArray = MyMethods.copyArray(personFieldValueArray, currentPersonArrayIndex);)
     personStringFieldValueArray = MyMethods.myStringArrayCopy(personStringFieldValueArray,
       currentPersonArrayIndex, stringFieldValueArray, 0, stringFieldValueArray.length);
     System.out.println("MyMethods.myArrayToString(personStringFieldArray)= "+         MyMethods.myArrayToString(personStringFieldArray));
     System.out.println("MyMethods.myArrayToString(personStringFieldValueArray)= "+         MyMethods.myArrayToString(personStringFieldValueArray));
     //increment index
     currentPersonArrayIndex++;

     return stringFieldValueArray;
  //end method
  }



  /**
   * storeDataValues is the main method to store questionInstance and scale
   * data values for easy transmitting
   * back to the server, etc
   *
   * It auto updates the dataStorageIndex as well.
   */
  public static void storeDataValues(PCategory pCategoryInstance)
  {
    int iDS = dataStorageIndex;
    String[] varID = new String[11];
    String name = pCategoryInstance.name;
    String isScale = MyMethods.myBooleanToString(pCategoryInstance.isScale);
    String scaleName = pCategoryInstance.scaleName;
    String isStudent = MyMethods.myBooleanToString(pCategoryInstance.isStudent);
    String choiceType = pCategoryInstance.choiceType;
    String qNum = Integer.toString(pCategoryInstance.questNum);
    String qText = pCategoryInstance.questionText;
    String isReversed = MyMethods.myBooleanToString(pCategoryInstance.isReversedItem);
    String isCourseCredit = MyMethods.myBooleanToString(pCategoryInstance.isCourseCredit);
    String isU100 = MyMethods.myBooleanToString(pCategoryInstance.isU100);
    String userID = pCategoryInstance.userID;

    //make varID revise and store as string array
    varID[0] =  name;
    varID[1] =  isScale;
    varID[2] =  scaleName;
    varID[3] =  qNum;
    varID[4] =  qText;
    varID[5] =  choiceType;
    varID[6] =  isReversed;
    varID[7] =  userID;
    varID[8] =  isStudent;
    varID[9] =  isU100;
    varID[10] = isCourseCredit;
//old method of storing varID as a string
//    varID = "n="+ name +"; isSc="+ isScale +";sNm="+ scaleName +
//           "; qN="+ qNum +"; qTx="+ qText +"; cT="+ choiceType +
//           "; isRv="+ isReversed +"; userID="+ userID +"; isStu="+isStudent +
//           "; isU100="+ isU100 +"; isCr="+ isCourseCredit +";";
    double scaleMean = pCategoryInstance.meanScaleScore;
    double scaleSD = pCategoryInstance.standardDeviationScaleScore;
    double scaleRelMean = pCategoryInstance.relativeMeanScaleScore;


//    for (i = 0;i < totalDataItems; i++)
//    {
      //System.out.println("dataStorageInstance.varIdArray["+ iDS+ "][0]= "+         MyMethods.myArrayToString(dataStorageInstance.varIdArray[iDS]));

         //fix later
//      if ( true) //dataStorageInstance.varIdArray[iDS][0].equals(" "))
//      {
//        if (choiceType.equals("multiple"))
//        {
          //the text of the possible responses
//          String multiAnsTextArrayString = MyMethods.myArrayToString(pCategoryInstance.multiAnswerTextArray);
//          //the integer values of the checked items
//          String intAnsValueArrayString = pCategoryInstance.intMultiAnswerValueArray.toString();

//          dataStorageInstance.multiValueAnswerTextArray[iDS] = multiAnsTextArrayString;
//          dataStorageInstance.multiValueAnswerArray[iDS] = intAnsValueArrayString;

//        }
//        else
//        {//store values in place i

//         storeVarID (dataStorageInstance.varIdArray, varID, iDS);
//         dataStorageInstance.valueIntArray[iDS] =  pCategoryInstance.intAnswerValue;
//         dataStorageInstance.valueStringArray[iDS] =  pCategoryInstance.stringAnswerValue;
//         dataStorageInstance.valueBooleanArray[iDS] =  pCategoryInstance.booleanAnswerValue;
//         dataStorageInstance.valueDoubleArray[iDS] =  pCategoryInstance.doubleAnswerValue;
//         dataStorageInstance.relativeScoreArray[iDS] =  pCategoryInstance.relativeScore;
//         dataStorageInstance.scaleMeanArray[iDS] = scaleMean;
//         dataStorageInstance.scaleSDScoreArray[iDS] = scaleSD;
//         dataStorageInstance.scaleRelativeMeanArray[iDS] = scaleRelMean;
         //dataStorageInstance.
        //end else
//        }
      //end big if
//      }
//    //end for
//    }
    dataStorageIndex++;
  //end method
  }

  public static String[][] storeVarID (String[][] varIdArray,
    String[] varID, int varIdArrayIndex)
  {
    int i = 0;
    for (i = 0; i < 11; i++)
    {
      varIdArray[varIdArrayIndex][i] = varID[i];
    }
    return varIdArray;
  }


  public static void initializeDataStoreArrays()
  {
    //old; set idArray[0]
    //System.out.println("varIdVariableNamesArray[0]= "+varIdVariableNamesArray[0] );
    varIdArray[0][0] = varIdVariableNamesArray[0];
    varIdArray[0][1] = varIdVariableNamesArray[1];
    varIdArray[0][3] = varIdVariableNamesArray[2];
    varIdArray[0][4] = varIdVariableNamesArray[3];
    varIdArray[0][5] = varIdVariableNamesArray[4];
    varIdArray[0][6] = varIdVariableNamesArray[5];
    varIdArray[0][7] = varIdVariableNamesArray[6];
    varIdArray[0][8] = varIdVariableNamesArray[7];
    varIdArray[0][9] = varIdVariableNamesArray[8];
    varIdArray[0][10] = varIdVariableNamesArray[10];

    //System.out.println(MyMethods.myArrayToString(varIdArray[0]));

    //old "Variable IDs format= instance.fieldvar;name;optional info";

    //initialize
    MyMethods.initializeExisting2DArray(varIdArray, initVarIdValue);
    MyMethods.initializeExistingArray(valueStringArray, initStringValue);
    MyMethods.initializeExistingArray(valueIntArray, initIntValue);
    MyMethods.initializeExistingArray(valueBooleanArray, initBooleanValue);
    MyMethods.initializeExistingArray(valueDoubleArray, initDoubleValue);
    //added for relativeScore,etc
    MyMethods.initializeExistingArray(relativeScoreArray, initDoubleValue);
    MyMethods.initializeExistingArray(scaleMeanArray, initDoubleValue);
    MyMethods.initializeExistingArray(scaleSDScoreArray, initDoubleValue);
    MyMethods.initializeExistingArray(scaleRelativeMeanArray, initDoubleValue);
    //for multiple values
    MyMethods.initializeExistingArray(multiValueAnswerTextArray, initStringValue);
    MyMethods.initializeExistingArray(multiValueAnswerArray, initStringValue);
    //for user type and goals
    MyMethods.initializeExistingArray(userTypeTextArray,initStringValue);
    MyMethods.initializeExistingArray(userTypeAnswerArray,initIntValue);
    MyMethods.initializeExistingArray(userGoalsTextArray,initStringValue);
    MyMethods.initializeExistingArray(userGoalsAnswerArray,initIntValue);
  }

  //CREATE one ARRAY of Data Storage STRINGS from Data Arrays
  public boolean makeAllDataStringArray()
  {
   System.out.println("CREATING one ARRAY of Data Storage STRINGS from Data Arrays----------------");
   try
   {
    //for person-related arrays
    allDataArrayNames[0] = "personStringFieldArray";
    allDataArrayStrings[0] = MyMethods.myArrayToString(DataStorage.personStringFieldArray);
    allDataArrayNames[1] = "personStringFieldValueArray";
    allDataArrayStrings[1] = MyMethods.myArrayToString(DataStorage.personStringFieldValueArray);

    //START HERE fix later--causes system to CRASH!
    //System.out.println("varIdArray= "allDataArrayStrings[ ] =  MyMethods.myArrayToString(dataStorageInstance.varIdArray));
    allDataArrayNames[2] =  "valueIntArray";
    allDataArrayStrings[2] =  MyMethods.myArrayToString(dataStorageInstance.valueIntArray);
    allDataArrayNames[3] =  "valueStringArray";
    allDataArrayStrings[3] =  MyMethods.myArrayToString(dataStorageInstance.valueStringArray);
    allDataArrayNames[4] =  "valueBooleanArray";
    allDataArrayStrings[4] =  MyMethods.myArrayToString(dataStorageInstance.valueBooleanArray);
    allDataArrayNames[5] =  "valueDoubleArray";
    allDataArrayStrings[5] =  MyMethods.myArrayToString(dataStorageInstance.valueDoubleArray);
    //newer arrays
    allDataArrayNames[6] =  "relativeScoreArray";
    allDataArrayStrings[6] =  MyMethods.myArrayToString(dataStorageInstance.relativeScoreArray);
    allDataArrayNames[7] =  "scaleMeanArray";
    allDataArrayStrings[7] =  MyMethods.myArrayToString(dataStorageInstance.scaleMeanArray);
    allDataArrayNames[8] =  "scaleSDScoreArray";
    allDataArrayStrings[8] =  MyMethods.myArrayToString(dataStorageInstance.scaleSDScoreArray);
    allDataArrayNames[9] =  "scaleRelativeMeanArray";
    allDataArrayStrings[9] =  MyMethods.myArrayToString(dataStorageInstance.scaleRelativeMeanArray);
   //for multiple values--to get texts and strings of ints, etc in second one
    allDataArrayNames[10] =  "multiValueAnswerTextArray";
    allDataArrayStrings[10] =  MyMethods.myArrayToString(dataStorageInstance.multiValueAnswerTextArray);
    allDataArrayNames[11] =  "multiValueAnswerArray";
    allDataArrayStrings[11] =  MyMethods.myArrayToString(dataStorageInstance.multiValueAnswerArray);
    //user type and goals--only print with all arrays
    //first must calculate and store them in the data arrays
    allDataArrayNames[12] = "UserTypes";
    allDataArrayStrings[12] = FrameResultsText.makeUserTypeString();
    allDataArrayNames[13] = "UserGoals";
    allDataArrayStrings[13] = FrameResultsText.makeUserGoalsString();
    allDataArrayNames[14] =  "userTypeTextArray";
    allDataArrayStrings[14] = MyMethods.myArrayToString(userTypeTextArray);
    allDataArrayNames[15] =  "userTypeAnswerArray";
    allDataArrayStrings[15] =  MyMethods.myArrayToString(userTypeAnswerArray);
    allDataArrayNames[16] =  "userGoalsTextArray";
    allDataArrayStrings[16] = MyMethods.myArrayToString(userGoalsTextArray);
    allDataArrayNames[17] =  "userGoalsAnswerArray";
    allDataArrayStrings[17] =  MyMethods.myArrayToString(userGoalsAnswerArray);

    System.out.println("END Creating allDataStringArrays----------------");

    if(printDetails == true)
    {
//      int i = 0;
//      for (i = 0;i < numDataArrays; i++)
//      {
//        System.out.println("allDataArrayNames[i]= "+  allDataArrayNames[i]);
//        System.out.println("allDataArrayStrings[i] = "+ allDataArrayStrings[i]);
//      }

        System.out.println("allDataArrayNames[0]= "+  allDataArrayNames[0]);
        System.out.println("allDataArrayStrings[0] = "+ allDataArrayStrings[0]);
        System.out.println("allDataArrayNames[17]= "+  allDataArrayNames[17]);
        System.out.println("allDataArrayStrings[17] = "+ allDataArrayStrings[17]);
     }
   }
   catch (Exception e)
   {
     System.out.println("makeAllDataStringArray Exception= "+ e);
     return false;
   }
   return true;
  }

  //to print for just one question instance:
  public static void printDataStorageArrays(int index)
  {
      //person-related arrays
      System.out.println("BEGIN Printing Data Storage Arrays----------------");
      System.out.println("MyMethods.myArrayToString(DataStorage.personStringFieldArray= "+
          MyMethods.myArrayToString(DataStorage.personStringFieldArray));
      System.out.println("MyMethods.myArrayToString(DataStorage.personStringFieldValueArray= "+
          MyMethods.myArrayToString(DataStorage.personStringFieldValueArray));

      //START HERE fix later--causes system to CRASH!
      //System.out.println("varIdArray["+index+"]= "+ dataStorageInstance.varIdArray[index]);
      //System.out.println("valueIntArray["+index+"]=  "+ dataStorageInstance.valueIntArray[index]);

      System.out.println("valueStringArray["+index+"]=  "+ DataStorage.valueStringArray[index]);
      System.out.println("valueBooleanArray["+index+"]=  "+ DataStorage.valueBooleanArray[index]);
      System.out.println("valueDoubleArray["+index+"]=  "+ DataStorage.valueDoubleArray[index]);
      //newer arrays
      System.out.println("relativeScoreArray["+index+"]=  "+ DataStorage.relativeScoreArray[index]);
      System.out.println("scaleMeanArray["+index+"]=  "+ DataStorage.scaleMeanArray[index]);
      System.out.println("scaleSDScoreArray["+index+"]=  "+ DataStorage.scaleSDScoreArray[index]);
      System.out.println("scaleRelativeMeanArray["+index+"]=  "+ DataStorage.scaleRelativeMeanArray[index]);
     //for multiple values--to get texts and strings of ints, etc in second one
      System.out.println("multiValueAnswerTextArray["+index+"]=  "+ DataStorage.multiValueAnswerTextArray[index]);
      System.out.println("multiValueAnswerArray["+index+"]=  "+ dataStorageInstance.multiValueAnswerArray[index]);
      System.out.println("END Printing Data Storage Arrays----------------");
  }

  public static void printDataStorageArrays()
  {
    printDataStorageArrays(System.out);
  }

//  public static void printDataStorageArrays(PrintWriter printWriter)
//  {
//    printDataStorageArrays(System.out);
//  }
  /**
   * @todo USE THE MyMethods.myArrayToString methods below to create simple
   * string for associating with a parameter to POST data to server??
   */

  public static void printDataStorageArrays(PrintStream printStream)
  {
    printStream.println("NEW BEGIN Printing Data Storage Arrays----------------");
    //for person-related arrays
    printStream.println("MyMethods.myArrayToString(DataStorage.personStringFieldArray= "+
        MyMethods.myArrayToString(DataStorage.personStringFieldArray));
    printStream.println("MyMethods.myArrayToString(DataStorage.personStringFieldValueArray= "+
        MyMethods.myArrayToString(DataStorage.personStringFieldValueArray));

    //START HERE fix later--causes system to CRASH!
    //printStream.println("varIdArray= "+ MyMethods.myArrayToString(dataStorageInstance.varIdArray));
    printStream.println("valueIntArray= "+ MyMethods.myArrayToString(dataStorageInstance.valueIntArray));

    printStream.println("valueStringArray= "+ MyMethods.myArrayToString(dataStorageInstance.valueStringArray));
    printStream.println("valueBooleanArray= "+ MyMethods.myArrayToString(dataStorageInstance.valueBooleanArray));
    printStream.println("valueDoubleArray= "+ MyMethods.myArrayToString(dataStorageInstance.valueDoubleArray));
    //newer arrays
    printStream.println("relativeScoreArray= "+ MyMethods.myArrayToString(dataStorageInstance.relativeScoreArray));
    printStream.println("scaleMeanArray= "+ MyMethods.myArrayToString(dataStorageInstance.scaleMeanArray));
    printStream.println("scaleSDScoreArray= "+ MyMethods.myArrayToString(dataStorageInstance.scaleSDScoreArray));
    printStream.println("scaleRelativeMeanArray= "+ MyMethods.myArrayToString(dataStorageInstance.scaleRelativeMeanArray));
   //for multiple values--to get texts and strings of ints, etc in second one
    printStream.println("multiValueAnswerTextArray= "+ MyMethods.myArrayToString(dataStorageInstance.multiValueAnswerTextArray));
    printStream.println("multiValueAnswerArray= "+ MyMethods.myArrayToString(dataStorageInstance.multiValueAnswerArray));
    //user type and goals--only print with all arrays
    //first must calculate and store them in the data arrays
    FrameResultsText.makeUserTypeString();
    FrameResultsText.makeUserGoalsString();
    printStream.println("userTypeTextArray= "+MyMethods.myArrayToString(userTypeTextArray));
    printStream.println("userTypeAnswerArray= "+ MyMethods.myArrayToString(userTypeAnswerArray));
    printStream.println("userGoalsTextArray= "+MyMethods.myArrayToString(userGoalsTextArray));
    printStream.println("userGoalsAnswerArray= "+ MyMethods.myArrayToString(userGoalsAnswerArray));

    printStream.println("END Printing Data Storage Arrays----------------");

  }
  //create instance
  public static DataStorage dataStorageInstance = new DataStorage();
  //total num variables stored by entire program
  public static int totalDataItems = 600;
  //max responses on ANY question in entire program
  public static int maxResponses = 40;
  //keep track of dataStorageIndex
  public static int dataStorageIndex = 1; //starts at 1; 0 is for storing var names in first array
  //the names of the variables for each index of the array corresponding to varIdArray
  //also this is stored in varIdArray[0]
  public static String[] varIdVariableNamesArray = {"name","isScale",
    "scaleName","questNum","questionText","choiceType","isReversedItem","userID",
    "isStudent","isU100","isCourseCredit"};
  //store id as an array
  public static String[][] varIdArray = new String[totalDataItems][30];
  //store in values in array that allows multiple values (the second dimension)
  public static int[] valueIntArray = new int[totalDataItems];
  //for now only store one value (the last for multiple value strings, etc.)
  public static String[] valueStringArray = new String[totalDataItems];
  public static boolean[] valueBooleanArray = new boolean[totalDataItems];
  public static double[] valueDoubleArray = new double[totalDataItems];
  //for now do have multiValue arrays
  public static String multiValueAnswerArray[] = new String[totalDataItems];
  public static String multiValueAnswerTextArray[] = new String[totalDataItems];
  //added for relativeScore s
  public static double[] relativeScoreArray = new double[totalDataItems];
  public static double[] scaleMeanArray = new double[totalDataItems];
  public static double[] scaleSDScoreArray = new double[totalDataItems];
  public static double[] scaleRelativeMeanArray = new double[totalDataItems];
  //special array completed during printing of results by FrameResultsText class
  //The questions are listed briefly in the first array.
  //answers checked by user (as true) are stored in the second array as 1 false= 0.
  public static String[] userTypeTextArray = new String[25]; //done in FrameResultsText = new String[25];//longer than needed
  public static int[] userTypeAnswerArray = new int[25];//done inFrameResultsText = new int[25];//longer than needed
  public static String[] userGoalsTextArray= new String[25]; //done in FrameResultsText = new String[25];//longer than needed
  public static int[] userGoalsAnswerArray = new int[25];//done inFrameResultsText = new int[25];//longer than needed
  //initial values
  public static String[] initVarIdValue = {" "," "," "," "," "," "," "," "," "," "," "," "};
  public static String initStringValue = " ";
  public static int initIntValue = -99;
  public static boolean initBooleanValue = false;
  public static double initDoubleValue = -999.00;

  /**
   *  for storing the results of storeAllFieldValues
   *  for all types of misc questions--not question or scale data,
   *  stored in sequence, person, student, etc.
   */
  public static int currentPersonArrayIndex = 0;
  public static int totalStorageNum = 400;
  public static String[] personStringFieldArray = new String[totalStorageNum];
  //not needed public static Object[] personFieldValueArray = new Object[totalStorageNum];
  public static String[] personStringFieldValueArray = new String[totalStorageNum];

  //for meta storage of various data arrays converted to strings
  public static int numDataArrays =  18;
  public static  String[] allDataArrayNames = new String[numDataArrays];
  public static  String[] allDataArrayStrings = new String[numDataArrays];

  public static boolean printDetails = false;

}

|#