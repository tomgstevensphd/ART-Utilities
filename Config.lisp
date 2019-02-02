;;***************************** Config.lisp *********************************
;;
;; COPY OF Config.java
;;
;;
#|

package CaresProject2;

/**
 *
 * @author TomGStevens
 * mostly this is used by CaresControl.java and CaresDataSender.java
 * 
 */
import java.applet.AppletContext;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;
import java.util.GregorianCalendar;



public class Config
{


    public static String SetConfigValues()
    {
            //Calculate the dateString
            calcDate();


            //FOLLOWING ARE DEPENDENT UPON SERVER LOCATION
            if (isLocalhost)
            {
                       serverHostURLstring = localhostURL;
                       successURLstring = localsuccessURL;
//                       serverJARfilePath = localCaresJarPathname;
//                       caresClasspath = caresLocalClasspath;
                       caresCodebase = caresLocalCodebase;
                       caresPolicy = caresLocalPolicy;
                       successPhpURLstring =  localsuccessURL.concat(PhpFilename);

            }
            else
            {
                       serverHostURLstring = CSULBserverURL;
                       successURLstring = CSULBsuccessURL;
//                       serverJARfilePath = csulbCaresJarPathname;
//                       caresClasspath = caresCSULBClasspath;
                       caresCodebase = caresCSULBCodebase;
                       caresPolicy = caresCSULBPolicy;
                       serverDataURL = caresCSULBdataURL;
                       successPhpURLstring = CSULBsuccessURL + PhpFilename;


            }
            //SET VARIALBES DEPENDENT UPON SERVER STRINGS ETC
            dataFileURL = serverDataURL + dataFilename;
           /*
            *  WOULDN'T WORK BECAUSE COULDN'T CREATE A NEW FILE--had to use pre-existing ones- FIND NEW WAY?
            */ 
//            resultsFilePath = Person.person.lastName + Person.person.userID + ".htm";
//            resultsFileURL = serverResultsURL + resultsFilePath;

             if (isPrintDetails == true)
             {
                  System.out.println("serverHostURLstring= " + serverHostURLstring);
                  System.out.println("successURLstring= " + successURLstring);
                  System.out.println("successPhpURLstring= " + successPhpURLstring);
//                 System.out.println("serverJARfilePath= " + serverJARfilePath);
//                 System.out.println("caresClasspath= " + caresClasspath);
                  System.out.println("caresCodebase= " + caresCodebase);
                  System.out.println("caresPolicy= " + caresPolicy);
                  System.out.println("serverDataURL= " + serverDataURL);
//                  System.out.println("resultsFileURL= " + resultsFileURL);
                  System.out.println("dataFileURL= " + dataFileURL);

             }
 
         System.out.println("Variable Settings for isLocalhost= "+ isLocalhost);
         return ("Variables Set");
      }

     public static String createResultsFileNames()
    {
     String firstDigit = (Person.person.userID).substring(0,1);
       String[] digitArray = {"0","1","2","3","4","5","6","7","8","9"};
       if (MyMethods.mySearchArray(firstDigit, digitArray) != -1)
       {
         Config.resultsFileName = firstDigit + Config.resultsFileString; //.concat(".htm");
         Config.resultsFilePath = Config.resultsDir + Config.resultsFileName;
        }
       else
       {
          Config.resultsFileName = "0" + Config.resultsFileString;
          Config.resultsFilePath = Config.resultsDir + Config.resultsFileName;
       }
       
       Config.resultsFileURL = Config.successURLstring +  Config.resultsFilePath;


       if (Config.isPrintDetails)
       {
            System.out.println("Config.resultsFilePath= " + Config.resultsFilePath);
            System.out.println("Config.resultsFileURL= " + Config.successURLstring);
       }
       return Config.resultsFileURL;
    //end method
    }


    public static String calcDate()
    {
        GregorianCalendar now = new GregorianCalendar();

        year = String.valueOf(now.get(Calendar.YEAR));    //.DATE;
        int monthInt = now.get(Calendar.MONTH) + 1;
        month = String.valueOf(monthInt);  //String.valueOf(now.get(Calendar.MONTH));
        day = String.valueOf(now.get(Calendar.DAY_OF_MONTH)); //String.valueOf(now.get(Calendar.DAY_OF_MONTH));
        hour = String.valueOf(now.get(Calendar.HOUR_OF_DAY));
        minute = String.valueOf(now.get(Calendar.MINUTE));        ; //.valueOf(now.get(Calendar.HOUR_OF_DAY));

        dateString = year.concat("/").concat(month).concat("/").concat(day).concat("  Time: ").concat(hour).concat(":").concat(minute);
        return dateString;
    }

       //VARIABLES
    //Run SHAQ starting caresControlManager() in CaresControl.java?
    public static boolean isRunSHAQ = true;
    public static boolean isPrintDetails = false;
    public static AppletContext appletContext = null;
 
    public static boolean isLocalhost = false;
    // following used to RETRIEVE results file with showDoc note: //netscape
    // created URL=file:///C:/MY%20WEBS/Success/shaqCares.htm
    //public static String httpCSULBServerURL = "http://www.csulb.edu/~tstevens/success/";
        //xxx for eagles server:  public static String httpCSULBServer = "http://eagles.its.csulb.edu/~tstevens/success/";
	// was "http://bills.its.csulb.edu/~tstevens/success/";	// www server "http://www.csulb.edu/~tstevens/success/";
	// was "http://bills.its.csulb.edu/~tstevens/success/";	// was "http://front.csulb.edu/success/";
    //public static String httpLocalServerURL = "http://localhost/success";  //using Apache Tomcat 6.0
    //public static String csulbCaresJarPathname = "/home/dh/tstevens/htdocs/success/";
    //public static String localCaresJarPathname = "c:\\ProgramFiles2\\apache-stomcat-6.0.28\\webapps\\Success\\"; //was "C:/JcsulbTest/csulbServer/Tomcat%206.0/webapps/success/";
    // public static String localHostSuccessPath = localCaresJarPathname; //5-2009 was c:\\MY WEBS\\Success\\rtfs\\";
    //public static String csulbHostSuccessPath = csulbCaresJarPathname;  //was "/home/dh/tstevens/htdocs/success/"; //5-2009 was "/home/dh/tstevens/htdocs/success/hidden/rtfs/";
    public static String caresControlCodebase = "CaresProject2.CaresControl.class"; //is this right?
    //must set these data directories before general urls
    public static String dataDir = "hidden/";
    public static String serverDataDir = "";
    public static String resultsDir = "rtfs/";
    //public static String serverResultsDir = "";
    public static String resultsFileName = "ToBeDetermined";
    public static String dataFilename = "dataFile.txt";
    public static String PhpFilename = "CaresControl.php";
    public static String dataFileURL = "DependsOnServer";
    public static String resultsFileURL = "DependsOnServer";
//    public static String caresClasspath = "DependsOnServer";
//    public static String caresCodebase = "DependsOnServer";
    public static String CSULBserverURL = "http://www.csulb.edu/";
    public static String CSULBsuccessURL = "http://www.csulb.edu/~tstevens/success/";
    //public static String caresCSULBClasspath = csulbCaresJarPathname;
    public static String caresCSULBCodebase = "CaresProject2.CaresControl2";
    public static String caresCSULBPolicy = "policy";
    public static String caresCSULBdataURL = CSULBsuccessURL.concat(dataDir).concat(dataFilename);
//    public static String caresCSULBresultsURLdir = CSULBsuccessURL + resultsDir;
     /*
     * LOCALHOST SERVER VALUES
     */
    public static String localhostURL = "http://localhost:8080/";
    public static String localsuccessURL = "http://localhost:8080/~tstevens/success/";
   // public static String caresLocalClasspath = localCaresJarPathname;
    public static String caresLocalCodebase = "CaresProject2.CaresControl2";
    public static String caresLocalPolicy = "policy";
    public static String caresLocalDataURL = localsuccessURL.concat(dataDir).concat(dataFilename);
//public static String caresLocalResultsURLdir = localsuccessURL + resultsDir;
    /*
     * VARIABLES THAT DEPEND UPON SERVER LOCATION AND ARE RESET ABOVE
     */
    public static String serverHostURLstring = "DependsOnServer";
    public static String successURLstring = "DependsOnServer";
    public static String serverJARfilePath = "DependsOnServer";
    public static String caresClasspath = "DependsOnServer";
    public static String caresCodebase = "DependsOnServer";
    public static String caresPolicy = "DependsOnServer";
    public static String serverDataURL = "DependsOnServer";
    public static String serverResultsURL = "DependsOnServer";
    public static String successPhpURLstring = "DependsOnServer";
    public static String SHAQhtmlResultsURL = "DependsOnServer";
    /*
     * VARIABLES RELATING TO Results Storage names
     * Dynamically determined in SetConfigValues above
     */
    public static String resultsFileString = "jstk.htm";  //STRING BEFORE FIRST DIGIT APPENDED TO BEGINNING
    public static String resultsFilePath = "ToBeDetermined";//  // = lastName + userID + ".htm";
    public static String SHAQhtmlResultsPage = "SHAQhtmlResults.php";
    /*
     * FOLLOWING VARIABLES-CONSTANTS LARGELY RELATE TO SHAQ DATA AND RESULTS
     */
    public static String currentHostDir = "";
	// home/dh/tstevens/htdocs/success/hidden/rtfs //was before hidden directory
	// /home/dh/tstevens/htdocs/success/rtfs/";
	// for BOTH? bills and www? "/home/dh/tstevens/htdocs/success/rtfs/";
	// for front.csulb was d:/PubWebs/Success/rtfs/";
	//xxx for normal server -- also used with eagles.its.csulb.edu server test and it worked; the dataFile.txt on the www.csulb.edu server was modified
        //public static String dataFilePath = "/home/dh/tstevens/htdocs/success/hidden/dataFile.txt"; // was-didn't

    //MISC OTHER VARIABLES -- SOME USED IN CARESCONTROL.JAVA
    public static boolean isCloseSystemOut = false; //closes the Java Window permenantly?
    public static String introductionText = "SHAQ CARES CONTROL WINDOW";

    //DATE
    public static String year = "";//String.valueOf(Calendar.getInstance().YEAR);    //.DATE;
    public static String month = ""; // String.valueOf(Calendar.getInstance().MONTH);
    public static String day = ""; // String.valueOf(Calendar.getInstance().DAY_OF_MONTH);
    public static String hour = ""; //String.valueOf(Calendar.getInstance().HOUR_OF_DAY);
    public static String minute = "";
    public static String dateString = "";// year.concat("/").concat(month).concat("/").concat(day).concat("/").concat(hour);

    public static String ResultsTextHTMLpreface =
        "<HTML> \n" +
        "<HEAD> \n" +
        "<META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=windows-1252\"> \n" +
        "<title>YOUR Success and Happiness Attributes Questionnaire (SHAQ) Results</title> \n" +
        "<meta name=\"Microsoft Theme\" content=\"indust 010, default\"> \n" +
        "<meta name=\"Microsoft Border\" content=\"tb, default\"> \n" +
        "</HEAD> \n" +
        "<BODY> \n" +
       "<p align=\"center\"><font color=\"#FF0000\" size=\"3\" face=\"ZapfHumnst BT\">" +
        "<b> YOUR Success and Happiness Attributes Questionnaire (SHAQ) Results</b></font><br> " +
        "<p><font color=\"#FF0000\"><b>Save your SHAQ Results IMMEDIATELY. &nbsp;</b></font><br>> " +
        "<p><font color=\"#FF0000\"><b>IMPORTANT Read the following about your SHAQ " +
        "Results:</b></font></p> " +
        "<p><font color=\"#FF0000\"><b> 1-Study your results, then 2-Follow Help-Links for more information.</b></font></p> " +
        "<ul>" +
         " <li><font color=\"#000080\"><b>READ THIS BEFORE CLICKING ON ANY ITEM IN THE LEFT WINDOW OR " +
            "THIS PAGE WILL DISAPPEAR!<br>" +
            "The SHAQ Results in the Java Window will NOT delete until you close your Internet Browser</b></font></li>" +
        "<PRE>" +
        " \n" +
        " \n";

    public static String ResultsTextHTMLend =
        "</PRE>" +
        "</body> \n" +
        "</html>\n" +
        "  ";

//END CLASS
}

|#