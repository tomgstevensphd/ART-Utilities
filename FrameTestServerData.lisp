;;**************************** FrameTestServerData.lisp ************************
;;
;; COPY of FrameTestServerData.java
;;
#|
package CaresProject2;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JTextPane;


/**
 * Title:        CARES Project
 * Description:  Computer Assessment and Recommendations Expert System
 * Copyright:    Copyright (c) 2000
 * Company:      California State University, Long Beach
 * @author Tom G. Stevens PhD
 * @version 1.0
 */

public class FrameTestServerData extends JFrame
{
  /**
     * 
     */
    private static final long serialVersionUID = -7921460690282722735L;
JTextPane jTextPane1 = new JTextPane();
  JButton jButton1 = new JButton();
  JButton jButton2 = new JButton();

  public FrameTestServerData()
  {
    try
    {
      jbInit();
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
  }
  private void jbInit() throws Exception
  {
    jTextPane1.setBorder(BorderFactory.createEtchedBorder());
    jTextPane1.setEditable(false);
    jTextPane1.setFont(new java.awt.Font("SansSerif", 1, 14));
    jTextPane1.setText(
      "This box is FOR TESTING PURPOSES ONLY.\n\n\n"+
      "Click the button below that says \"Click Here\".");
    this.getContentPane().setBackground(Color.red);
    this.setForeground(Color.red);
    this.getContentPane().setLayout(gridBagLayout1);
    this.setSize(400,300);
    jButton1.setBackground(new Color(200, 255, 200));
    jButton1.setText("Click Here");
    jButton1.addActionListener(new FrameTestServerData_jButton1_actionAdapter(this));
    jButton2.setBackground(Color.red);
    jButton2.setText("Do NOT Click Here");
    jButton2.addActionListener(new FrameTestServerData_jButton2_actionAdapter(this));
    frameResultsTextInstance.getContentPane().setLayout(gridBagLayout2);
    frameResultsHelpInstance.setTitle("Results Help");
    frameResultsHelpInstance.getContentPane().setLayout(gridBagLayout3);
    this.getContentPane().add(jTextPane1,  new GridBagConstraints(0, 0, 2, 1, 1.0, 1.0
            ,GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(21, 25, 0, 27), 27, 43));
    this.getContentPane().add(jButton1,  new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
            ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(20, 40, 34, 0), 0, 0));
    this.getContentPane().add(jButton2,  new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
            ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(18, 90, 34, 27), 0, 0));
  }

  void jButton1_actionPerformed(ActionEvent e)
  {
    this.setVisible(false);
//    FrameResultsText.frameServerDataInstance.jTextPane1.setText(FrameResultsText.resultsText);
    //for printing results directly with no frames in between
    FrameResultsText frameResultsTextInstance = new FrameResultsText();
    //frameResultsTextInstance.jTextPane1.setText(FrameResultsText.makeResultsText());
    //for now set visible only after text sent to server
    frameResultsTextInstance.setVisible(true);

    //make FrameResultsHelp
    FrameResultsHelp frameResultsHelpInstance = new FrameResultsHelp();
    frameResultsHelpInstance.setVisible(true);
    CaresQuestControl.isFrameResultsTextPrinted = true;

  }

  void jButton2_actionPerformed(ActionEvent e)
  {
    FrameResultsText.isSendDataToServer = true;
    this.setVisible(false);

    //for printing results directly with no frames in between
//    FrameResultsText frameResultsTextInstance = new FrameResultsText();
    //frameResultsTextInstance.jTextPane1.setText(FrameResultsText.makeResultsText());
    //for now set visible only after text sent to server
    //frameResultsTextInstance.setVisible(true);
    //wasFrameResultsText.sendDataToServer();
    System.out.println("FIND 112233z--> SENT DATA AND RESULTS TO SERVER HERE IN FrameTestServerData");
//      CaresControl FrameTestDataInstance = new CaresControl();
//      FrameTestDataInstance.sendDataToJINIServer();//was.sendDataToRMIServer();
//    //FrameResultsText.frameServerDataInstance.setVisible(true);
//      FrameTestDataInstance.sendResultsToJINIServer();//was .sendResultsToRMIServer();
//    //make FrameResultsHelp
//    FrameResultsHelp frameResultsHelpInstance = new FrameResultsHelp();
//    frameResultsHelpInstance.setVisible(true);
  }

  public static FrameResultsText frameResultsTextInstance = new FrameResultsText();
  public static FrameResultsHelp frameResultsHelpInstance = new FrameResultsHelp();
  GridBagLayout gridBagLayout1 = new GridBagLayout();
  GridBagLayout gridBagLayout2 = new GridBagLayout();
  GridBagLayout gridBagLayout3 = new GridBagLayout();
  
      /**
     * Added so Frames will run alone in NetBeans
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new FrameTestServerData().setVisible(true);
            }
        });
    }
  
  
}

class FrameTestServerData_jButton1_actionAdapter implements java.awt.event.ActionListener
{
  FrameTestServerData adaptee;

  FrameTestServerData_jButton1_actionAdapter(FrameTestServerData adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jButton1_actionPerformed(e);
  }
}

class FrameTestServerData_jButton2_actionAdapter implements java.awt.event.ActionListener
{
  FrameTestServerData adaptee;

  FrameTestServerData_jButton2_actionAdapter(FrameTestServerData adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jButton2_actionPerformed(e);
  }
}

|#