;; ***********************   CaresControlDataSender.lisp **********************
;;
;; CaresControlDataSender.java COPY 
;;  NOT SURE THIS FILE ACTUALLY STILL BEING USED IN CURRENT PHP MECHANISM
;;
#|
package CaresProject2;

/**
 *
 * @author TomGStevens
 */
//From PhpDataSender == these import MORE
// import java.io.*;
// import java.net.*;
// import java.util.*;
// import java.net.URLConnection.*;
// import java.security.Permission;

import java.applet.AppletContext;
import java.io.*;
//import java.io.BufferedReader;
//import java.io.ByteArrayOutputStream;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.io.PrintWriter;
//import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.security.Permission;
import java.util.*;

//note: In CaresQuestControl.java, when finished, fires below function:
//       CaresDataSender.sendDataToServer(Config.successPhpURLstring, Person.person.name,
//                   Person.person.eMailAddress,Person.person.userID,CaresControl.dataText, CaresControl.resultsHtmlText);
//
//
public class CaresDataSender
{
 public static boolean sendDataToServer(String urlString, String username, String email, String userID,
                                    String dataText, String resultsText) //was Map<String, String> nameValuePairs)
 {
		// //AppletContext appletContextInstance = new AppletContext();
		// //appletContextInstance.getApplets();

       //CREATE resultsFilePath NAME -- done in Config ??
       //For testing only
//       Person.person.lastName = "Jones";
//       Person.person.userID = "011101";
//       Person.person.eMailAddress = "email@aol.com";
//       username = Person.person.lastName;
//       Config.resultsFilePath = Config.resultsDir.concat(Person.person.lastName).concat(Person.person.userID).concat(".htm");
         
       /*
        * Set Config variables manually depending on server location  etc
        * Set Config.isLocalhost may be only setting necessary
        * Also set isPrintDetails there
        *
        */
       //DO THIS BEFORE CALLING THIS METHOD
          //Second time this function is called-- also early in SHAQ
          Config.SetConfigValues();
       //TEST POINT 0
       System.out.println("CaresDataSender Test point 0");

       //MOVED TO STATIC CONTEXT final Map<String, String> postMap = new HashMap<String, String>();
       //PUT THE POST NAMES AND VALUES IN THE HASHMAP
       postMap.put("username", username);
       postMap.put("email", Person.person.eMailAddress);
       postMap.put("userID", Person.person.userID);
       postMap.put("date", Config.dateString);
       postMap.put("dataText", dataText);
       postMap.put("resultsFilePath", Config.resultsFilePath);
       postMap.put("resultsText",resultsText);
//       Xxxx TRY FOR SENDING TO A DIFFERENT PHP FILE THAN ONE APPLET IS IN
//       Set the action attribute set to test.php; doing so prompts the form
//               to send the request to the script when the form is submitted.
//               This enables you to both accept user input and process it within the same script.
       postMap.put("action", urlString); //For other file try: Config.SHAQhtmlResultsURL);
       //last to match <input type="submit" value="Register!"
       if (Config.isPrintDetails)
       {
           Collection<String> mapValues = postMap.values();
           if (Config.isPrintDetails)
           {
             System.out.println("mapValues collection= "+ mapValues);
            }
        }

        try
        {
	if (Config.isPrintDetails == true)
           {
        	
//				 Config.currentPage = Config.appletContext.getCodeBase();
//				 System.out.println("currentPage = CodeBase= "+Config.currentPage);
//				 Config.protocol = Config.currentPage.getProtocol();
//				 System.out.println("protocol= "+ Config.protocol);
//				 Config.host = Config.currentPage.getHost();
//				 System.out.println("host= "+ Config.host);
//				 Config.userInfo = Config.currentPage.getUserInfo();
//				 System.out.println("userInfo= "+ Config.userInfo);
//				 Config.port = Config.currentPage.getPort();
//				 System.out.println("port= "+ Config.port);
//				// 2-06
	    // deBugText = deBugText + "#3 CaresControl Test point 1" + "\n"; // +
				// "currentPage.getHost()= "+currentPage.getHost() + "\n"+
				// "currentPage.getUserInfo()= " + currentPage.getUserInfo() +
				// "\n";
            }
            System.out.println("CaresDataSender Test point 1");

            //send the data 
            System.out.println("From CaresDataSender SENDING dataText ");
            postDataSender(urlString, postMap);

            if (Config.isPrintDetails)
            {
                System.out.println("CaresDataSender Test point 2");
//                        deBugText = deBugText + "\n#4 " + "caresJINIServerDataMethods1= " + caresJINIServerDataMethods1 + " hashcode= "
//                                + caresJINIServerDataMethods1.hashCode() + "\n" + "CaresControl Test point 2\n";
                System.out.println("From CaresDataSender dataText= " + dataText);
            }
//             dataStorageResult = caresJINIServerDataMethods1.storeSHAQData(dataFilePath, dataText);
//                    // 2-06
//                  deBugText = deBugText + "#5 From CaresControl SENDING dataText \n"
//                            + "dataStorageResult = caresJINIServerDataMethods1.storeSHAQData(dataText)= "
//                            + dataStorageResult + "\n" + "dataText= " + dataText + "\n";
//
//                  if (Config.isPrintDetails == true)
//                  {
//                        System.out.println("From CaresControl debug text= " + deBugText);
//                  }
                    // Set the Results Frames Visible if data was sent REPORT RESULT
                if (dataStorageResult == true)
                {
                     // set visible only if sent data
                     CaresQuestControl.frameResultsTextInstance.setVisible(true);
                     CaresQuestControl.frameResultsHelpInstance.setVisible(true);
                     isFrameResultsTextPrinted = true;
                     // jLabel1.setText("Data Stored");
                     return dataStorageResult;
                 }
                 else
                 {
                    // jLabel1.setText("Data Not Stored");
                    return dataStorageResult;
                 }

        //end try
        }
        catch (Exception e)
        {
			// NOTE THE USE OF e.getMessage to find and print the error message
			// and printStack!!
            //added printstack 4-09
            e.printStackTrace();
            System.out.println("CaresDataSender exception: " + e.getMessage());
            // System.out.printStackTrace();
            FrameServerData FrameServerDataInstance = new FrameServerData();
            FrameServerDataInstance.setVisible(true);
            // 2-06 added deBugText
            if (Config.isPrintDetails == true)
            {
//		deBugText = deBugText + "\n#6 At sendDataTojiniServerURL catch (Exception e)\n";
//		deBugText = frameDeBugTextInstance.jTextArea1.getText()	+ deBugText;
//		frameDeBugTextInstance.jTextArea1.setText(deBugText);
//		frameDeBugTextInstance.setVisible(true);
            }
		}
	    // 2-06 added deBugText
            if (Config.isPrintDetails == true)
            {
//		deBugText = deBugText + "\n#7 At catch end sendDataToJINIServer\n";
//		deBugText = frameDeBugTextInstance.jTextArea1.getText() + deBugText;
//		frameDeBugTextInstance.jTextArea1.setText(deBugText);
//		frameDeBugTextInstance.setVisible(true);
            }

            return dataStorageResult;

    // end sendDataToServer method if it gets this far
    }

    /*
     * from in PostDataSender.java in PhpProject1
     */ 
    public static String postDataSender(String urlString, Map<String, String> nameValuePairs) //Map<String, String> nameValuePairs)
          throws IOException
    {
       URL url = new URL(urlString);
       URLConnection connection = url.openConnection();
       connection.setDoOutput(true);

       PrintWriter printwriter = new PrintWriter(connection.getOutputStream());
       if (Config.isPrintDetails)
       {
       System.out.println("printwriter.toString= " + printwriter.toString());
      //prints false if no errors
       System.out.println("printwriter.checkError= " + printwriter.checkError());
       System.out.print("nameValuePairs.entrySet= " + nameValuePairs.entrySet());
        }
       //print from hashmap
       //XXX IMPORTANT: Solved problem of shaqdata not being sent to server by not separating the
       //  printwriter data sending from opening the connection (when the header gets auto sent??)
       //  that meant NO INTERVENING calls to the connections BELOW.  They worked ok below; and the
       //  System.out.println s above worked ok as well.
       boolean first = true;
       for (Map.Entry<String, String> pair : nameValuePairs.entrySet())
       {
           if (first){first = false;}
           else {printwriter.print('&');}
           String name = pair.getKey();
           String value = pair.getValue();
           //print to printwriter
           printwriter.print(name);
           printwriter.print('=');
           printwriter.print(URLEncoder.encode(value, "UTF-8"));
           //print to system
           if (Config.isPrintDetails)
           {
           System.out.print("KEY + UTF-8 CODED VALUE= " + name);
           System.out.print('=');
           System.out.print(URLEncoder.encode(value, "UTF-8"));
           }
       }
       printwriter.println("BYE");
       System.out.println("Sent BYE?");
       printwriter.close();

       //added
       if(Config.isPrintDetails)
       {
       System.out.println("----------");
       System.out.println("nameValuePairs--MapString= " + nameValuePairs.toString());
       System.out.println("nameValuePairs.keySet= " + nameValuePairs.keySet() );
       System.out.println("nameValuePairs.size= " + nameValuePairs.size());
           System.out.println("getURL= " + connection.getURL());
           System.out.println("getPermission= " + connection.getPermission());
           System.out.println("getContentType: " + connection.getContentType());
           System.out.println("getContentLength: " + connection.getContentLength());
           System.out.println("getContentEncoding: " + connection.getContentEncoding());
           System.out.println("getDate: " + connection.getDate());
           System.out.println("getExpiration: " + connection.getExpiration());
           System.out.println("getLastModifed: " + connection.getLastModified());
           System.out.println("getAllowUserInteraction= " + connection.getAllowUserInteraction());
           System.out.println("getContent= " + connection.getContent());
           System.out.println("getConnectTimeout= " + connection.getConnectTimeout());
           System.out.println("getReadTimeout= " + connection.getReadTimeout());
           System.out.println("getDoOutput= " + connection.getDoOutput());
           System.out.println("getDoInput= " + connection.getDoInput());
           System.out.println("----------");
        }
//
       Scanner in;
       StringBuilder response = new StringBuilder();

       try
       {
          in = new Scanner(connection.getInputStream());
          if (Config.isPrintDetails)
          {
          System.out.println("in.toString= " + in.toString());
           }

       }
       catch (IOException e)
       {
          if (!(connection instanceof HttpURLConnection))
          {throw e;}
          InputStream err = ((HttpURLConnection) connection).getErrorStream();
          if (err == null)
          {throw e;}
          in = new Scanner(err);
       }


       while (in.hasNextLine())
       {
          String nextLine= in.nextLine();
          if (Config.isPrintDetails)
          {System.out.println(nextLine);}
          response.append(nextLine); //was response.append(in.nextLine());
          response.append("\n");
          //feedback
       }

       in.close();
       return response.toString();
       
    // END postDataSender method
    }

   
     //VVV
         //VARIABLES RELATED TO POST STATEMENT
        static final Map<String, String> postMap = new HashMap<String, String>();

        //VARIABLE RELATE TO SERVER AND FILE LOCATIONS
        public static String serverJARfilePath = "DependsOnServer";
        public static String serverHostURLstring = "DependsOnServer";
        private String shaqData = "NoShaqData";
        private String shaqResults = "NoShaqResults";

	// RETRIEVAL of results
	public static String resultsUrlString = "";
        public static String varName;
	public static String codedData = "";
        public static String serverDataPathName = "";
	public static boolean isDataSent = false;
//	in CaresControl public static String dataText = "";
	public static boolean dataStorageResult = true; //11-2010  changed to true because wouldn't fire results

	// following is created file with lastname plus ID
  //to Config	public static String resultsFilename = "lastNameUserID.txt";
	public static boolean isShaqResultsToBeStored = true;
	public static boolean isShaqResultsStored = false;
	public static boolean isFrameResultsTextPrinted = false;
//to Config
        //public static boolean isCloseSystemOut = false;
	public static boolean isSendDataToServer = true;
	public static URL currentPage;
	public static String protocol;// error = currentPage.getProtocol();
	public static String host;// error = currentPage.getHost();
	public static String userInfo;// error = currentPage.getUserInfo();
	public static int port;// error = currentPage.getPort();
	public static boolean isExitCARES = false;
	public static DataStorage dataStorageInstance = new DataStorage();
	public static String introductionText = "SHAQ CARES CONTROL WINDOW";
	// added after 9-11-02
	public static boolean isSendShaqResultsTextToServer = true;

        //OTHER
       // public static String deBugText = "deBugText";


//end of class
}






// **********************************************************************

 //SEE BELOW FOR OLD METHODS INCLUDING SERVER CONNECTION AND HELP LINKS ETC



    //from original carescontrol.java
   	// added 9-02 to send complete results text to server to create an html full
	// results file which is then
	// downloaded back to the right window in the frame.
	// copied from sendDataToRMIServer--see notes etc for that if questions
//	public boolean sendResultsToJINIServer()
//        {
//		System.out
//				.println(" BEGIN sendResultsToJINIServer; isShaqResultsToBeStored= "
//						+ isShaqResultsToBeStored);
//		// 2-06 added deBugText
//		deBugText = deBugText
//				+ "\n#8 BEGIN sendResultsToJINIServer; isShaqResultsToBeStored= "
//				+ isShaqResultsToBeStored + "\n";
//
//		if (isShaqResultsToBeStored)
//                {
//			// //AppletContext appletContextInstance = new AppletContext();
//			// //appletContextInstance.getApplets();
//			if (isLocalhost)
//                        {
//				serverResultsDir = localHostSuccessPath;
//			}
//                        else
//                        {
//                                serverResultsDir = csulbHostSuccessPath;
//			} // 2-06 was frontHostDir
//		try
//                {
//                    if (Config.isPrintDetails == true)
//                    {
//					// System.out.println("CaresControl Test point B-0");
//					// currentPage = getCodeBase();
//					// System.out.println("currentPage = CodeBase=
//					// "+currentPage);
//					// protocol = currentPage.getProtocol();
//					// System.out.println("protocol= "+protocol);
//					// host = currentPage.getHost();
//					// System.out.println("host= "+host);
//					// userInfo = currentPage.getUserInfo();
//					// System.out.println("userInfo= "+userInfo);
//					// port = currentPage.getPort();
//					// System.out.println("port= "+port);
//
//					// System.out.println("CaresControl Test point B-1");
//
//				// first, set the Results to be sent to a variable in the
//				// carrier object
//				// that impliments Serializable--DataSender
//				// DataSender dataSender = new DataSender(data);
//
//				// if(this.getCodeBase().getHost()==null)
//				// { //do nothing
//				// }
//				// else
//				// {
//				// host = this.getCodeBase().getHost();
//				// System.out.println("host= "+ host);
//				// }
//
//				// String url = "rmi://"+ host;
//				// System.out.println("url= "+ url);
//				// Hello obj =
//				// (Hello)Naming.lookup("//"+getCodeBase().getHost()+
//				// "/HelloServer");
//				// CHANGE MANUALLY--TOO MANY PROBLEMS WITH OTHER METHODS
//				// CaresJINIInterface obj =
//				// (CaresJINIInterface)Naming.lookup("//localhost:1099/CaresJINIServer");
//				// do I include the /success??
//				// CaresJINIInterface obj =
//				// (CaresJINIInterface)Naming.lookup("//front.csulb.edu:1099/CaresJINIServer");
//				// from corejava below--should I include the /success?
//
//				// determine rmi server
//                        }
//                    }
//                catch(IOException e);
//                    {
//            }
//     //end of method?
//    }


//CaresJINIServerDataMethods caresJINIServerDataMethods2 = new CaresJINIServerDataMethods();
//
//                        System.out.println("Locating service...");
//
//            //NOTE: getService() can also be invoked with
//            //a Lookup Service hostname as the first parameter
//            //e.g getService(String host,Class interfaceClass);
//
//            //@TODO COPY SECTION FROM sendDataToJINIServer AFTER IT WORKS!!!
//
////            LookupLocator[] lookupLocatorArray = null;
////            LookupLocator lookupLocator1 = new LookupLocator(jiniServerURL);
////            lookupLocatorArray = new LookupLocator[] {lookupLocator1};
////            LookupLocatorDiscovery lookupLocatorDiscovery1 = new LookupLocatorDiscovery(lookupLocatorArray);
////            //lookupLocatorDiscovery1[]
////            //is ServiceRegistrar of any value? I put it in for heck of it
////            ServiceRegistrar serviceRegistrar[] = null;
////            serviceRegistrar = lookupLocatorDiscovery1.getRegistrars();
////            //probably useless
////            String serviceRegistrarName = serviceRegistrar.toString();
//
//
//            if (Config.isPrintDetails == true)
//            {
//					System.out.println("jiniServer= " + jiniServerURL);
//					System.out.println("caresJINIServerDataMethods2= " + caresJINIServerDataMethods2 + " hashcode= "
//							+ caresJINIServerDataMethods2.hashCode());
//					System.out.println("CaresControl Test point B-2");
//                   //no longer needed
////					System.out.println("rmiregistry list= "
////							+ Naming.list(rmiServer));
//					// 2-06
//					deBugText = deBugText + "#9 jiniServer= " + jiniServerURL + "\n"
//							+ "caresJINIServerDataMethods2= " + caresJINIServerDataMethods2 + " hashcode= " + caresJINIServerDataMethods2.hashCode()
//							+ "\n" + "CaresControl Test point B-2" + "\n"
//							//not needed + "rmiregistry list= " + Naming.list(rmiServer)
//							+ "\n";
//
//			}
//				System.out.println("From CaresControl SENDING resultsText= "); // +resultsText);
//
//				resultsFilename = lastName + userID + ".htm";
//				if (isLocalhost == false)
//                {
//					resultsUrlString = httpCSULBServerURL + resultsDir
//							+ resultsFilename;
//				}
//                else
//                {
//					resultsUrlString = httpLocalServerURL + resultsDir
//							+ resultsFilename;
//				}
//				if (Config.isPrintDetails == true)
//                {
//					System.out.println("resultsFilename= " + resultsFilename
//							+ "  resultsUrlString= " + resultsUrlString);
//					// 2-06
//					deBugText = deBugText + "#10 resultsFilename= "
//							+ resultsFilename + "  resultsUrlString= "
//							+ resultsUrlString + "\n";
//					frameDeBugTextInstance.jTextArea1.setText(deBugText);
//					frameDeBugTextInstance.setVisible(true);
//
//				}
//				this.jTextPane2
//						.setText("Savable/printable results to appear in RIGHT WINDOW SOON");
//
//				// STORE THE SHAQ RESULTS FILE in html format
//				// note: this should hold up this method so that showDocument
//				// isn't executed prematurely
//				isShaqResultsStored = caresJINIServerDataMethods2.storeSHAQResults(resultsText,
//						serverResultsDir, resultsFilename);
//				System.out.println("isShaqResultsStored= "
//						+ isShaqResultsStored);
//				// 2-06
//				deBugText = deBugText + "\n#10.1 serverResultsDir= "
//						+ serverResultsDir + "\n isShaqResultsStored= "
//						+ isShaqResultsStored + "\n";
//				// added 2-06 to prevent problems if problems with server
//				// interaction when
//				// connected to server
//				// xxxx
//				if (isShaqResultsStored == false)
//                {
//					frameResultsServerProblemInstance.setVisible(true);
//				}
//
//			}
//            catch (Exception e)
//            {
//				// NOTE THE USE OF e.getMessage to find and print the error
//				// message
//				// and printStack!!
//				System.out
//						.println("UNABLE TO STORE RESULTS CaresControl exception: "
//								+ e.getMessage());
//				// System.out.printStackTrace();
//				FrameServerData FrameServerDataInstance1 = new FrameServerData();
//				FrameServerDataInstance1.setVisible(true);
//
//				// 2-06
//				if (Config.isPrintDetails == true)
//                {
//					deBugText = deBugText
//							+ "\n#11 At sendResultsTojiniServerURL catch (Exception e)";
//					deBugText = frameDeBugTextInstance.jTextArea1.getText()
//							+ deBugText;
//					frameDeBugTextInstance.jTextArea1.setText(deBugText);
//					frameDeBugTextInstance.setVisible(true);
//                }
//             //end catch
//			}
//
//			if (isShaqResultsStored)
//            {
//				// in rare case that isShaqResultsStored == true and
//				// dataStorageResult == false,
//				// still fire popup results window. It happened.
//				if (dataStorageResult == false)
//                {
//					CaresQuestControl.frameResultsTextInstance.setVisible(true);
//					CaresQuestControl.frameResultsHelpInstance.setVisible(true);
//					isFrameResultsTextPrinted = true;
//                }
//				// try
//				// {
//				// AppletContext context2 = getAppletContext();
//				appletContext = CaresQuestControl.CaresControlDataInstance.appletContext;
//				// try this too?
//				// AppletContext context2 =
//				// CaresQuestControl.CaresControlDataInstance.appletContext;
//				// System.out.println("AppletContext context2= "+ context2);
//				System.out.println("appletContext= " + appletContext);
//				// set the path to RETRIEVE the html results file on the server
//				// httpCSULBServer = "http://www.csulb.edu/~tstevens/success/";
//				// httpLocalServer = "file://c:/MY%WEBS/Success/";
//				// System.out.println("2 resultsUrlString= "+ resultsUrlString);
//				this.jTextPane2
//						.setText("SAVABLE, PRINTABLE RESULTS IN RIGHT WINDOW");
//				try
//                {
//					// Make the URL and show the results in Right frame window
//					URL url = new URL(resultsUrlString);
//					// System.out.println("url= "+ url);
//					// System.out.println("waiting");
//					// context2.wait(30000);
//                    try
//                    {
//					appletContext.wait(30000);
//                    }
//                    catch (Exception we)
//                    {
//                        System.out.println("Error in appletContext.wait");
//                    }
//
// 				System.out.println("Starting showDocument");
//					// context2.showDocument(url, "right");
//					CaresQuestControl.CaresControlDataInstance.appletContext
//							.showDocument(url, "right");
//					appletContext.showDocument(url, "right");
//					return isShaqResultsStored;
//				}
//                catch (MalformedURLException me)
//                {
//					System.out.println("MalformedURLException= " + me);
//
//				// catch (Exception e) {
//					// NOTE THE USE OF e.getMessage to find and print the error
//					// message
//					// and printStack!!
//					System.out
//							.println("UNABLE TO RETRIEVE RESULTS CaresControl exception: "
//									+ me.getMessage());
//					// System.out.printStackTrace();
//					FrameResultsTextHelp helpFrame = new FrameResultsTextHelp();
//					helpFrame.jTextPane1.setFont(new java.awt.Font("Serif", 1,
//							14));
//					helpFrame.jTextPane1
//							.setText("\n\n"
//									+ " NOTICE:\n\n"
//									+ " TO GET A SAVABLE, PRINTABLE COPY OF YOUR SHAQ RESULTS,\n"
//									+ " Click on the 'GET SAVABLE RESULTS' button\n"
//									+ " in the LEFT BROWSER WINDOW underneath these popup windows.\n"
//									+ " Your results should appear in the RIGHT BROWSER WINDOW\n"
//									+ " in 1 to 6 minutes.\n\n"
//									+ " DO NOT keep clicking the button; it may start over again each time.");
//					// FrameServerData FrameServerDataInstance2 = new
//					// FrameServerData();
//					// FrameServerDataInstance2.setVisible(true);
//					helpFrame.setVisible(true);
//				}
//				// end of if results stored
//			}
//			// end if to be stored
//		}
//		// 2-06
//		if (Config.isPrintDetails == true)
//        {
//			deBugText = deBugText + "\n#12 At end of sendResultsToJINIServer "
//					+ "isShaqResultsStored= " + isShaqResultsStored + "\n";
//			deBugText = frameDeBugTextInstance.jTextArea1.getText() + deBugText;
//			frameDeBugTextInstance.jTextArea1.setText(deBugText);
//			frameDeBugTextInstance.setVisible(true);
//		}
//
//		return isShaqResultsStored;
//		// end sendResultsToJINIServer
//	}

	/**
	 * JINI METHOD TO SEND DATA TO SERVER
	 *
	 * see corejava p270
	 */
//	public boolean sendDataToJINIServer0()
//    {
//		String emailMessage1 = "This is a test email message part 1";
//		String emailMessage2 = "This is a test email message part 2";
//		String[] emailMessageArray = { emailMessage1, emailMessage2 };
//		String[] tsEmailMessageArray = { "TS Part 1", "TS part 2" };
//
//		// THIS CODE MOVED TO INIT METHOD--Move it back???
//		// String hostURL = "c:\\My Webs\\Success\\";
//		// //change to getCodeBase().getHost() + "/"; //p295 corejava
//		// String url = "rmi://" + hostURL;
//		// System.out.println("url= "+ url);
//		//
//		try {
//			// jiniServerInstance = (CaresJINIInterface)Naming.lookup(url +
//			// "CaresJINIServerDataMethodsInstance");
//			// debug by adding one line at a time
////was
////			jiniServerInstance.storeStringData(dataFilePath,
////					"varIdArray first array",
////					DataStorage.dataStorageInstance.varIdArray[0]);
//            CaresJINIServerDataMethods obj = new CaresJINIServerDataMethods();
//                    obj.storeStringData(dataFilePath,
//					"varIdArray first array",
//					DataStorage.dataStorageInstance.varIdArray[0]);
//
////			jiniServerInstance.sendEmailToTS(emailMessageArray,
////					tsEmailMessageArray);
//
//		} catch (Exception e) {
//			System.out.println("Error connecting in sendDataToJINIServer= " + e);
//			// won't work in static contect showStatus("ERROR: CAN'T CONNECT TO
//			// "+ hostURL);
//		}
//		return true;
//	}
//
//	/**
//	 * SECTION FOR METHODS TO SEND DATA TO SERVER USING POST METHOD
//	 */
//	public static boolean sendDataToServer() {
//		// from CJ p 175, first open a connection
//		// Note: I substituted PrintStream for PrintWriter because it acts just
//		// like
//		// PrintWriter when println uses it and PrintWriter is a stream and the
//		// method printDataStorageArrays can then be used with BOTH System.out
//		// AND
//		// PrintStream
//		// modified by p451,& eg. 455-6. Core Servletts...
//		// try
//		// {
//		try {
//			URL currentPage = CaresControl.currentPage;
//			String protocol = CaresControl.protocol;
//			String host = CaresControl.host;
//			String userInfo = CaresControl.userInfo;
//			int port = CaresControl.port;
//			String urlSuffix = "/success/ServletCaresData.class"; // serverDataPathName;
//			if (Config.isPrintDetails == true) {
//				String page = "currentPage= " + currentPage + " protocol= "
//						+ protocol;
//				String page2 = "host= " + host + " userInfo= " + userInfo
//						+ " port= " + port + " urlSuffix= " + urlSuffix;
//				System.out.println(page);
//				System.out.println(page2);
//				// FrameTestTextOutput frameTestTextOutput1 = new
//				// FrameTestTextOutput();
//				// frameTestTextOutput1.jTextPane1.setText(page + " \n"+page2);
//				// frameTestTextOutput1.setVisible(true);
//
//			}
//			URL url = new URL(protocol, host, port, urlSuffix);
//
//			URLConnection connection = url.openConnection();
//			// tell browser not to cache the info
//			connection.setUseCaches(false);
//			// then set up connection for output (tell browser to allow send
//			// data as
//			// well as read it?
//			connection.setDoOutput(true);
//			Person.person.date = connection.getDate();
//			String connectionInfo = connection.toString();
//			// new from Core Servlets 452:
//			// create an array output to buffer the stream
//			ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
//
//			// attach an output stream PrintWriter for text data (for serialized
//			// ObjectOutputStream)
//			PrintWriter out = new PrintWriter(byteStream, true);
//
//			// put the data into the buffer
//			/*
//			 * FIRST TEST DATA String dataSHAQ = "This is test data to see if
//			 * sendDataToServer is working. \nIs it really working?";
//			 * //Necessary?? URL type data String varName = "CaresData="; String
//			 * codedData = URLEncoder.encode(dataSHAQ); END FIRST TEST DATA
//			 */
//
//			// TEST 2 -- go to coreJava server bk p 455 for help.
//			// from FP created file success\FormTest.htm
//			// how does the following info get conveyed??
//			// according to html bk, ACTION= the cgi file name; from FP,the
//			// target= was the Frame
//			String FPFormHeader = "<FORM METHOD=\"POST\" ACTION=\"--WEBBOT-SELF--\" name=\"FormNameIsJavaData\""
//					+ "target=\"_self\">";
//			String webbotData = "<!--WEBBOT bot=\"SaveResults\" U-File=\"mydata.txt\" S-Format=\"TEXT/PRE\""
//					+ "S-Label-Fields=\"TRUE\" B-Reverse-Chronology=\"FALSE\" S-Email-Format=\"TEXT/PRE\""
//					+ "S-Email-Address=\"tstevens@csulb.edu\" B-Email-Label-Fields=\"TRUE\""
//					+ "B-Email-ReplyTo-From-Field=\"TRUE\" S-Email-ReplyTo=\"tstevens@csulb.edu\""
//					+ "B-Email-Subject-From-Field=\"TRUE\" S-Email-Subject=\"1-SHAQdat\""
//					+ "S-Date-Format=\"%m/%d/%Y\" S-Time-Format=\"%I:%M %p\""
//					+ "S-Builtin-Fields=\"REMOTE_NAME REMOTE_USER HTTP_USER_AGENT Date Time\" -->";
//			String inputsString = "<INPUT type=\"hidden\" name=\"VAR1\" value=\"Value1\">"
//					+ "<INPUT type=\"hidden\" name=\"VAR2\" value=\"Value2\">";
//
//			// must I urlencode the following or just its values, or maybe they
//			// are all OK??
//			String bigPairString =
//			// drop? "<FORM METHOD=\"POST\"
//			"ACTION=\"--WEBBOT-SELF--\" name=\"FormNameIsJavaData\""
//					+ "target=\"_self\""
//					+
//					// drop? >
//					// drop? <!--WEBBOT
//					"bot=\"SaveResults\" U-File=\"mydata.txt\" S-Format=\"TEXT/PRE\""
//					+ "S-Label-Fields=\"TRUE\" B-Reverse-Chronology=\"FALSE\" S-Email-Format=\"TEXT/PRE\""
//					+ "S-Email-Address=\"tstevens@csulb.edu\" B-Email-Label-Fields=\"TRUE\""
//					+ "B-Email-ReplyTo-From-Field=\"TRUE\" S-Email-ReplyTo=\"tstevens@csulb.edu\""
//					+ "B-Email-Subject-From-Field=\"TRUE\" S-Email-Subject=\"1-SHAQdat\""
//					+ "S-Date-Format=\"%m/%d/%Y\" S-Time-Format=\"%I:%M %p\""
//					+ "S-Builtin-Fields=\"REMOTE_NAME REMOTE_USER HTTP_USER_AGENT Date Time\""
//					+
//					// drop? -->
//					// drop?<INPUT
//					"type=\"hidden\" name=\"VAR1\" value=\"Value1\"" +
//					// drop? >
//					// drop<INPUT
//					"type=\"hidden\" name=\"VAR2\" value=\"Value2\"";
//			// drop? >
//			// try without URLencoding above (since they are probably ok)?
//
//			// was out.print(varName + codedData);
//			out.print(bigPairString);
//			// must use flush to get all data out if don't use println
//			out.flush();
//
//			// set the content-length header (required for POST data)
//			connection.setRequestProperty("Content-Length", String
//					.valueOf(byteStream.size()));
//
//			// set the Content-Type header. Regular form data requires a setting
//			// as below.
//			// the value is irrelevent when sending serialized data
//			/**
//			 * @todo note: from FrontPage headings they use Content-Type =
//			 *       text/html USE it ALSO, the servlet that is autogenerated
//			 *       uses text/html
//			 */
//			// original from Core server--my version follows:
//			// connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
//			connection.setRequestProperty("Content-Type", "text/html");
//			// send the data to the server
//			byteStream.writeTo(connection.getOutputStream());
//
//			// open an input stream
//			BufferedReader in = new BufferedReader(new InputStreamReader(
//					connection.getInputStream()));
//
//			// read the result--varies with server/servlet
//			String line;
//			while ((line = in.readLine()) != null) {
//				// do something with the line
//
//			}
//
//			// if (host.length() == 0) // || connection.)
//			// {
//			// frameServerDataInstance.setVisible(true);
//			// //NOTE: sendDataToServer re-fired by button1 in
//			// frameServerDataInstance
//			//
//			// }
//			// else
//			// {
//			// get a stream and use printwriter for text
//			// PrintWriter out = new PrintWriter(connection.getOutputStream());
//			// my version PrintStream out = new
//			// PrintStream(connection.getOutputStream(), true);
//			/**
//			 * @todo ME--WHAT ABOUT SENDING IT TO THE RIGHT PLACE IN THE FILE???
//			 */
//			// original from CJ book
//			// //make data stream
//			// OutputStream byteStream = connection.getOutputStream();
//			// PrintWriter out = new PrintWriter(byteStream);
//			// following doesn't work anyway
//			if (Config.isPrintDetails == true) {
//				// print the output to a frame
//				String output = "BEGIN...\n protocol = "
//						+ protocol
//						+ "host = "
//						+ host
//						+ "userInfo = "
//						+ userInfo
//						+ "port = "
//						+ port
//						+ "\n"
//						+ "urlSuffix = "
//						+ urlSuffix
//						+ "serverDataPathName = "
//						+ serverDataPathName
//						+ "\nOutputStream byteStream = connection.getOutputStream() = "
//						+ byteStream + "\nPrintWriter out = " + out;
//				// 2-06
//				deBugText = deBugText + "\n#x1 " + output + "\n";
//				// FrameTestTextOutput frameTestTextOutput2 = new
//				// FrameTestTextOutput();
//				// frameTestTextOutput2.jTextPane1.setText(output);
//				// frameTestTextOutput2.setTitle("Test Output2");
//				// frameTestTextOutput2.setLocation(300,300);
//				// frameTestTextOutput2.setVisible(true);
//			}
//			// begin actual printing
//			out.println("BEGIN\n");
//			// DataStorage.printDataStorageArrays();
//			out.println(userInfo);
//			out.println("\nEND");
//
//			// To read a server response
//			// BufferedReader in = new BufferedReader
//			// (new InputStreamReader(connection.getInputStream()));
//			// String line;
//			// while ((line = in.readLine()) != null)
//			// {
//			// //process line code goes here
//			// }
//			// To read a server error message --can't find getErrorStream
//			// BufferedReader inServerError = new BufferedReader
//			// (new InputStreamReader(connection.getErrorStream()));
//			// String line;
//			// while ((line = inServerError.readLine()) != null)
//			// {
//			// System.out.println(line);
//			// }
//
//			out.close();
//
//			// frameServerDataInstance.setVisible(false);
//			// isDataSent = true;
//			// FrameTestServerData.frameResultsTextInstance.setVisible(true);
//			// FrameTestServerData.frameResultsHelpInstance.setVisible(true);
//			// end of if
//			// }
//		} catch (IOException eIO) {
//			System.out.println("IOException finding URL");
//			// frameServerDataInstance.setVisible(true);
//		}
//		// }
//		// catch (MalformedURLException eURL)
//		// {
//		// System.out.println("ERROR: MalformedURL");
//		// frameServerDataInstance.setVisible(true);
//		// }
//
//		return isDataSent;
//
//		// end method
//	}

|#









