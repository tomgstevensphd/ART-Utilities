package CaresProject2;

import java.awt.event.ActionEvent;

import javax.swing.border.BevelBorder;
import javax.swing.border.Border;
import javax.swing.border.TitledBorder;
//import java.awt.*;
import javax.swing.*;
import java.awt.Dimension;
import javax.swing.JButton;
import java.awt.Color;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.awt.GridBagLayout;


/**
 * Title:        Your Product Name
 * Description:  Your description
 * Copyright:    Copyright (c) 1999
 * Company:      CSULB
 * @author Tom Stevens PhD
 * @version
 */

public class FrameUserType extends JFrame
{
  /**
     *
     */
    private static final long serialVersionUID = 5127144165773885033L;
JPanel jPanel1 = new JPanel();
  Border border1;
  JPanel jPanel2 = new JPanel();
  Border border2;
  JPanel jPanel3 = new JPanel();
  JLabel jLabel1 = new JLabel();
  JTextPane jTextPane1 = new JTextPane();
  TitledBorder titledBorder1;
  JRadioButton jRadioButton1 = new JRadioButton();
  JRadioButton jRadioButton2 = new JRadioButton();
  JRadioButton jRadioButton3 = new JRadioButton();
  JRadioButton jRadioButton4 = new JRadioButton();
  JRadioButton jRadioButton5 = new JRadioButton();
  JRadioButton jRadioButton7 = new JRadioButton();
  JRadioButton jRadioButton6 = new JRadioButton();
  JLabel jLabel2 = new JLabel();
  JRadioButton jRadioButton10 = new JRadioButton();
  JRadioButton jRadioButton11 = new JRadioButton();
  JRadioButton jRadioButton13 = new JRadioButton();
  JButton jButton2 = new JButton();
  JRadioButton jRadioButton14 = new JRadioButton();
  JRadioButton jRadioButton15 = new JRadioButton();
  JRadioButton jRadioButton8 = new JRadioButton();
  JRadioButton jRadioButton16 = new JRadioButton();
  JRadioButton jRadioButton17 = new JRadioButton();
  JPanel jPanel4 = new JPanel();
  TitledBorder titledBorder2;
  JRadioButton jRadioButton9 = new JRadioButton();
  JRadioButton jRadioButton12 = new JRadioButton();
  JTextArea jTextArea1 = new JTextArea();
  GridBagLayout gridBagLayout1 = new GridBagLayout();
  GridBagLayout gridBagLayout2 = new GridBagLayout();
  GridBagLayout gridBagLayout3 = new GridBagLayout();
  JPanel jPanel5 = new JPanel();
  GridBagLayout gridBagLayout4 = new GridBagLayout();
  private JButton jButton1 = null;

  public FrameUserType()
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
    GridBagConstraints gridBagConstraints22 = new GridBagConstraints();
    gridBagConstraints22.insets = new Insets(10, 0, 10, 0);  // Generated
    gridBagConstraints22.gridy = 1;  // Generated
    gridBagConstraints22.ipady = 16;  // Generated
    gridBagConstraints22.ipadx = 160;  // Generated
    gridBagConstraints22.gridx = 0;  // Generated
    GridBagConstraints gridBagConstraints12 = new GridBagConstraints();
    gridBagConstraints12.fill = GridBagConstraints.BOTH;  // Generated
    gridBagConstraints12.gridx = 0;  // Generated
    gridBagConstraints12.gridy = 0;  // Generated
    gridBagConstraints12.weightx = 1.0;  // Generated
    gridBagConstraints12.weighty = 1.0;  // Generated
    gridBagConstraints12.ipady = 60;  // Generated
    gridBagConstraints12.insets = new Insets(10, 20, 10, 20);  // Generated
    GridBagConstraints gridBagConstraints9 = new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0, GridBagConstraints.NORTH, GridBagConstraints.NONE, new Insets(15, 10, 15, 10), 0, 0);
    gridBagConstraints9.insets = new Insets(20, 20, 20, 20);  // Generated
    GridBagConstraints gridBagConstraints8 = new GridBagConstraints(2, 9, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 40, 15, 10), 0, 0);
    gridBagConstraints8.insets = new Insets(10, 10, 10, 10);  // Generated
    gridBagConstraints8.anchor = GridBagConstraints.CENTER;  // Generated
    GridBagConstraints gridBagConstraints7 = new GridBagConstraints(1, 3, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 0, 0, 6), 0, 0);
    gridBagConstraints7.gridy = 4;  // Generated
    gridBagConstraints7.insets = new Insets(0, 10, 0, 0);  // Generated
    gridBagConstraints7.gridx = 0;  // Generated
    gridBagConstraints7.anchor = GridBagConstraints.WEST;  // Generated
    GridBagConstraints gridBagConstraints6 = new GridBagConstraints(0, 4, 2, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 59, 31, 60), 0, 0);
    gridBagConstraints6.gridy = 5;  // Generated
    GridBagConstraints gridBagConstraints5 = new GridBagConstraints(0, 10, 1, 1, 0.0, 0.0, GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 40, 10, 14), 0, 0);
    gridBagConstraints5.insets = new Insets(0, 40, 20, 0);  // Generated
    GridBagConstraints gridBagConstraints4 = new GridBagConstraints(0, 9, 2, 1, 0.0, 0.0, GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 40, 5, 0), 0, 0);
    gridBagConstraints4.insets = new Insets(0, 40, 0, 0);  // Generated
    GridBagConstraints gridBagConstraints31 = new GridBagConstraints(0, 8, 1, 1, 0.0, 0.0, GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 7, 0, 0), 112, 0);
    gridBagConstraints31.insets = new Insets(0, 20, 0, 0);  // Generated
    GridBagConstraints gridBagConstraints21 = new GridBagConstraints(0, 4, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 25, 0, 47), 0, 0);
    gridBagConstraints21.gridy = 6;  // Generated
    GridBagConstraints gridBagConstraints11 = new GridBagConstraints(0, 6, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 7, 0, 0), 23, 0);
    gridBagConstraints11.anchor = GridBagConstraints.WEST;  // Generated
    gridBagConstraints11.gridy = 1;  // Generated
    gridBagConstraints11.insets = new Insets(0, 20, 0, 0);  // Generated
    GridBagConstraints gridBagConstraints3 = new GridBagConstraints(0, 5, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 7, 0, 151), 0, 0);
    gridBagConstraints3.anchor = GridBagConstraints.WEST;  // Generated
    gridBagConstraints3.gridy = 4;  // Generated
    gridBagConstraints3.insets = new Insets(0, 20, 0, 0);  // Generated
    GridBagConstraints gridBagConstraints2 = new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 7, 0, 185), 0, 0);
    gridBagConstraints2.anchor = GridBagConstraints.WEST;  // Generated
    gridBagConstraints2.gridy = 5;  // Generated
    gridBagConstraints2.insets = new Insets(0, 20, 0, 0);  // Generated
    GridBagConstraints gridBagConstraints1 = new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 7, 0, 111), 0, 0);
    gridBagConstraints1.insets = new Insets(0, 20, 0, 0);  // Generated
    gridBagConstraints1.gridy = 3;  // Generated
    gridBagConstraints1.anchor = GridBagConstraints.WEST;  // Generated
    GridBagConstraints gridBagConstraints = new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0, GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 7, 0, 35), 0, 0);
    gridBagConstraints.insets = new Insets(0, 20, 0, 0);  // Generated
    gridBagConstraints.gridy = 2;  // Generated
    ButtonGroup buttonGroup1 = new ButtonGroup();

    border1 = BorderFactory.createBevelBorder(BevelBorder.RAISED,Color.lightGray,Color.lightGray,new Color(85, 85, 124),new Color(122, 122, 178));
    border2 = BorderFactory.createLineBorder(Color.black,1);
    titledBorder1 = new TitledBorder(BorderFactory.createEtchedBorder(Color.white,new Color(154, 154, 178)),"Type of User");
    titledBorder2 = new TitledBorder(BorderFactory.createEtchedBorder(Color.white,new Color(154, 154, 178)),"For  Students ONLY");
    jPanel1.setBackground(new Color(175, 175, 255));
    jPanel1.setBorder(BorderFactory.createRaisedBevelBorder());
    jPanel1.setMinimumSize(new Dimension(699, 100));
    //deleted 2-06 because method depreciated and could see no value in it
    //jPanel1.setNextFocusableComponent(this);
    jPanel1.setPreferredSize(new Dimension(745, 40));
    jPanel1.setToolTipText("");
    jPanel1.setLayout(gridBagLayout3);
    jPanel1.add(jLabel1, gridBagConstraints9);  // Generated
    this.getContentPane().setLayout(gridBagLayout1);
    this.setSize(800, 940);
	this.setPreferredSize(new Dimension(800, 900));  // Generated
	this.setMinimumSize(new Dimension(800, 870));  // Generated
	this.setMaximumSize(new Dimension(1000, 2000));  // Generated
    this.setLocation(0, 0);
    jPanel2.setLayout(new GridBagLayout());  // Generated
    jPanel2.setBackground(new Color(255, 255, 220));
    jPanel2.setBorder(BorderFactory.createLineBorder(Color.black));
    jPanel2.setMinimumSize(new Dimension(700, 90));
    jPanel2.setPreferredSize(new Dimension(740, 120));
    jPanel2.setToolTipText("");
    jPanel3.setBackground(new Color(220, 220, 255));
    jPanel3.setBorder(titledBorder1);
    jPanel3.setMinimumSize(new Dimension(746, 250));
    jPanel3.setPreferredSize(new Dimension(790, 400));
    jPanel3.setToolTipText("");
    jPanel3.setLayout(gridBagLayout2);
    jLabel1.setFont(new java.awt.Font("SansSerif", 1, 24));
    jLabel1.setPreferredSize(new Dimension(700, 60));  // Generated
    jLabel1.setForeground(Color.red);
    jLabel1.setMinimumSize(new Dimension(675, 40));
    jLabel1.setText("SHAQ CARES: Goals and Selection of Your Questionnaires");
    jTextPane1.setPreferredSize(new Dimension(700, 60));
    jTextPane1.setToolTipText("");
    jTextPane1.setEditable(false);
    jTextPane1.setOpaque(false);
    jTextPane1.setFont(new java.awt.Font("SansSerif", 1, 14));
    jTextPane1.setMinimumSize(new Dimension(6, 80));
    jTextPane1.setText("  PLEASE CHECK ALL THAT APPLY--so SHAQ can decide which questionnaires " +
    "to give you.");

    jTextPane1.setBackground(new Color(255, 200, 200));
    jRadioButton1.setOpaque(false);
    jRadioButton1.setPreferredSize(new Dimension(325, 25));
    jRadioButton1.setText("I want to know more about myself.");
    jRadioButton1.setToolTipText("");
    jRadioButton1.setBackground(Color.white);
    jRadioButton1.setMaximumSize(new Dimension(325, 25));
    jRadioButton1.addActionListener(new FrameUserType_jRadioButton1_actionAdapter(this));
    jRadioButton2.setOpaque(false);
    jRadioButton2.setText("CSULB student completing UNIV 100 assignment.");
    jRadioButton2.setBackground(Color.white);
    jRadioButton2.addActionListener(new FrameUserType_jRadioButton2_actionAdapter(this));
    jRadioButton3.setOpaque(false);
    jRadioButton3.setText("Other college student completing assignment.");
    jRadioButton3.setToolTipText("");
    jRadioButton3.setBackground(Color.white);
    jRadioButton3.addActionListener(new FrameUserType_jRadioButton3_actionAdapter(this));
    jRadioButton3.addActionListener(new FrameUserType_jRadioButton3_actionAdapter(this));
    jRadioButton4.setOpaque(false);
    jRadioButton4.setPreferredSize(new Dimension(300, 25));
    jRadioButton4.setMinimumSize(new Dimension(300, 25));
    jRadioButton4.setText("Other CSULB student completing assignment.");
    jRadioButton4.setBackground(Color.white);
    jRadioButton4.setMnemonic('0');
    jRadioButton4.setMaximumSize(new Dimension(300, 25));
    jRadioButton4.addActionListener(new FrameUserType_jRadioButton4_actionAdapter(this));
    jRadioButton5.setOpaque(false);
    //problem below
    jRadioButton5.setText("I want complete assessment AND HQ SCORE.");
    jRadioButton5.setToolTipText("");
    jRadioButton5.setSelectedIcon(null);
    jRadioButton5.setBackground(Color.white);
    jRadioButton5.setFont(new java.awt.Font("Dialog", 1, 13));
    jRadioButton5.addActionListener(new FrameUserType_jRadioButton5_actionAdapter(this));
    jRadioButton6.setOpaque(false);
    jRadioButton6.setMinimumSize(new Dimension(200, 25));
    jRadioButton6.setText("Instructor wanting to establish credit for students.");
    jRadioButton6.setBackground(Color.white);
    jRadioButton6.addActionListener(new FrameUserType_jRadioButton6_actionAdapter(this));
    jRadioButton7.setOpaque(false);
    jRadioButton7.setText("Finishing quickly most important.");
    jRadioButton7.setToolTipText("");
    jRadioButton7.setBackground(Color.white);
    jRadioButton7.addActionListener(new FrameUserType_jRadioButton7_actionAdapter(this));
    jRadioButton7.addActionListener(new FrameUserType_jRadioButton7_actionAdapter(this));
    jLabel2.setFont(new java.awt.Font("SansSerif", 1, 16));
    jLabel2.setText("Check ALL that apply to you:");
    jRadioButton10.setOpaque(false);
    jRadioButton10.setText("Other college student.");
    jRadioButton10.setToolTipText("");
    jRadioButton10.setBackground(Color.white);
    //jRadioButton10.setFont(new java.awt.Font("SansSerif", 0, 12));
    jRadioButton10.addActionListener(new FrameUserType_jRadioButton10_actionAdapter(this));
    jRadioButton10.addActionListener(new FrameUserType_jRadioButton10_actionAdapter(this));
    jRadioButton11.setOpaque(false);
    jRadioButton11.setFont(new java.awt.Font("Dialog", 1, 12));  // Generated
    jRadioButton11.setText("None of these categories fit me.");
    jRadioButton11.setToolTipText("");
    jRadioButton11.setBackground(Color.white);
    //jRadioButton11.setFont(new java.awt.Font("SansSerif", 0, 12));
    jRadioButton11.addActionListener(new FrameUserType_jRadioButton11_actionAdapter(this));
    jRadioButton13.setOpaque(false);
    jRadioButton13.setText("Experienced self-help user.");
    jRadioButton13.setToolTipText("");
    jRadioButton13.setBackground(Color.white);
    //jRadioButton13.setFont(new java.awt.Font("SansSerif", 0, 12));
    jButton2.setBackground(new Color(255, 200, 200));
    jButton2.setFont(new java.awt.Font("SansSerif", 1, 12));
    jButton2.setToolTipText("");
    jButton2.setText("EXIT CARES");
    jRadioButton14.setOpaque(false);
    jRadioButton14.setText("Other type of student.");
    jRadioButton14.setToolTipText("");
    jRadioButton14.setBackground(Color.white);
    //jRadioButton14.setFont(new java.awt.Font("SansSerif", 0, 12));
    jRadioButton14.addActionListener(new FrameUserType_jRadioButton14_actionAdapter(this));
    jRadioButton15.setOpaque(false);
    jRadioButton15.setText("College faculty member or administrator.");
    jRadioButton15.setToolTipText("");
    jRadioButton15.setBackground(Color.white);
    //jRadioButton15.setFont(new java.awt.Font("SansSerif", 0, 12));
    jRadioButton15.addActionListener(new FrameUserType_jRadioButton15_actionAdapter(this));
    this.getContentPane().setBackground(Color.red);
    this.setTitle("Type of User");
    jRadioButton8.setOpaque(false);
    jRadioButton8.setText("I want help with a certain problem.");
    jRadioButton8.setBackground(Color.white);
    //jRadioButton8.setFont(new java.awt.Font("SansSerif", 0, 12));
    jRadioButton8.addActionListener(new FrameUserType_jRadioButton8_actionAdapter(this));
    jRadioButton16.setOpaque(false);
    jRadioButton16.setText("I want to choose specific questionnaire(s).");
    jRadioButton16.setBackground(Color.white);
    //jRadioButton16.setFont(new java.awt.Font("SansSerif", 0, 12));
    jRadioButton16.addActionListener(new FrameUserType_jRadioButton16_actionAdapter(this));
    jRadioButton17.setOpaque(false);
    jRadioButton17.setText("Previous SHAQ user.");
    jRadioButton17.setToolTipText("");
    jRadioButton17.setBackground(Color.white);
    //jRadioButton17.setFont(new java.awt.Font("SansSerif", 0, 12));
    jRadioButton17.addActionListener(new FrameUserType_jRadioButton17_actionAdapter(this));
    jPanel4.setBackground(new Color(220, 220, 255));
    jPanel4.setBorder(titledBorder2);
    jPanel4.setLayout(gridBagLayout4);
    jRadioButton9.setOpaque(false);
    jRadioButton9.setText("I want ACADEMIC HELP ONLY");
    jRadioButton9.setBackground(Color.white);
    jRadioButton9.setFont(new java.awt.Font("Dialog", 1, 13));
    jRadioButton9.addActionListener(new FrameUserType_jRadioButton9_actionAdapter(this));
    jRadioButton12.setBackground(Color.white);
    jRadioButton12.setOpaque(false);
    jRadioButton12.setToolTipText("");
    jRadioButton12.setText("Subject  in a SHAQ research project");
    jRadioButton12.addActionListener(new FrameUserType_jRadioButton12_actionAdapter(this));
    jTextArea1.setBackground(Color.yellow);
    jTextArea1.setFont(new java.awt.Font("SansSerif", 1, 13));
    jTextArea1.setMinimumSize(new Dimension(790, 80));
    jTextArea1.setMargin(new Insets(20, 20, 20, 20));
    //jTextArea1 added 2-06 for HQ
    jTextArea1.setText(
        " ==> FIND YOUR HAPPINESS QUOTIENT (HQ). \n" +
        " You HQ Score is based upon research showing a correlation of 0.87 between \n" +
        " the SHAQ scales used in finding HQ and people's Overall Happiness.\n" +
        " It is important to note that 75% of people's overall happiness is accounted for by these HQ \n"+
        " scales (Stevens, 2009). Your HQ values, beliefs, and life skills may be powerful \n "+
        " influences on your past, current, and future happiness. \n "+
        " These HQ factors are CONTROLLABLE factors: you can choose to be happy by improving on them. \n\n"+
        " ==> Use your HQ SHAQ results and recommendations to maximize your future happiness.\n\n\n");

    jPanel5.setBackground(Color.yellow);
    jPanel5.setMinimumSize(new Dimension(800, 160));
    this.getContentPane().add(jPanel1,      new GridBagConstraints(0, 0, 2, 1, 1.0, 1.0
            ,GridBagConstraints.NORTH, GridBagConstraints.BOTH, new Insets(20, 25, 0, 25), -3, 0));
    jPanel3.add(jRadioButton1, gridBagConstraints);  // Generated
    this.getContentPane().add(jPanel3,       new GridBagConstraints(0, 3, 2, 1, 1.0, 1.0
            ,GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 25, 0, 28), -48, 136));
    jPanel3.add(jLabel2,      new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
            ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(25, 10, 10, 100), 0, 0));
    jPanel3.add(jRadioButton5, gridBagConstraints11);  // Generated
    jPanel3.add(jRadioButton7, gridBagConstraints31);  // Generated
    jPanel3.add(jRadioButton8, gridBagConstraints1);  // Generated
    jPanel3.add(jRadioButton13, gridBagConstraints3);  // Generated
    jPanel3.add(jRadioButton17, gridBagConstraints2);  // Generated
    jPanel3.add(jRadioButton16, gridBagConstraints21);  // Generated
    jPanel3.add(jPanel4,    new GridBagConstraints(1, 0, 2, 8, 1.0, 1.0
            ,GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 54), 0, 8));
    jPanel4.add(jRadioButton2,    new GridBagConstraints(0, 0, 2, 1, 0.0, 0.0
            ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 10, 0, 6), 0, 0));
    jPanel4.add(jRadioButton4,   new GridBagConstraints(0, 1, 2, 1, 0.0, 0.0
            ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 10, 0, 14), 0, 0));
    jPanel4.add(jRadioButton3,   new GridBagConstraints(0, 2, 2, 1, 0.0, 0.0
            ,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(0, 10, 0, 19), 0, 0));
    jPanel4.add(jRadioButton10,   new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0
            ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 10, 0, 0), 0, 0));
    jPanel4.add(jRadioButton14, gridBagConstraints7);  // Generated
    jPanel4.add(jRadioButton9, gridBagConstraints6);  // Generated
    jPanel3.add(jRadioButton6,         new GridBagConstraints(2, 8, 1, 1, 0.0, 0.0
            ,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(10, 15, 10, 0), 26, 0));
    jPanel3.add(jRadioButton15, gridBagConstraints4);  // Generated
    jPanel3.add(jRadioButton11, gridBagConstraints8);  // Generated
    jPanel3.add(jRadioButton12, gridBagConstraints5);  // Generated
    jPanel2.add(jTextPane1,          new GridBagConstraints(0, 0, 1, 1, 1.0, 1.0
            ,GridBagConstraints.NORTH, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 1, 3));  // Generated
    jPanel2.add(getJButton1(),             new GridBagConstraints(0, 1, GridBagConstraints.REMAINDER, GridBagConstraints.REMAINDER, 0.0, 1.0
            ,GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 80, 10, 80), 0, 40));  // Generated
    this.getContentPane().add(jButton2,          new GridBagConstraints(1, 4, 1, 1, 0.0, 0.0
            ,GridBagConstraints.NORTHEAST, GridBagConstraints.NONE, new Insets(10, 0, 0, 200), 0, 0));
    this.getContentPane().add(jPanel2,           new GridBagConstraints(0, 2, 2, 1, 1.0, 1.0
            ,GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 25, 10, 25), 2, 40));
    this.getContentPane().add(jPanel5,   new GridBagConstraints(0, 1, 2, 1, 0.0, 0.0
            ,GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(10, 25, 10, 25), 0, 50));
    jPanel5.add(jTextArea1, null);
//old jButton1
//    this.getContentPane().add(jButton1,  new GridBagConstraints(0, 4, 1, 1, 0.0, 0.0
//            ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(10, 120, 30, 10), 47, 0));

    buttonGroup1.add(jRadioButton1);
    buttonGroup1.add(jRadioButton2);
    buttonGroup1.add(jRadioButton3);
    buttonGroup1.add(jRadioButton4);
//    buttonGroup1.add(jRadioButton5);
    buttonGroup1.add(jRadioButton6);
    buttonGroup1.add(jRadioButton7);

  }
//replaced with private method (auto generated)
//  void jButton1_actionPerformed(ActionEvent e)
//  {
//  //check and store data
//
//  //this is the ok button to go to next frame
//    this.setVisible(false);
////    PersonDataFrame personDataFrame = new PersonDataFrame();
////    personDataFrame.setSize(760,600);
////    personDataFrame.setLocation(20, 0);
////    //personDataFrame
////    personDataFrame.setVisible(true);
//    CaresQuestControl.isGo = true;
//    CaresQuestControl.manageFiringQue(e);
//
//  }

  void jButton2_actionPerformed(ActionEvent e)
  {
  //this is the exit button
//  FrameExitWarning frameExitWarning1 = new FrameExitWarning();
//  frameExitWarning1.setLocation(50,150);
//  frameExitWarning1.setSize(420,350);
//  frameExitWarning1.setVisible(true);
    this.setVisible(false);
  }

  void jRadioButton1_actionPerformed(ActionEvent e)
  {
    //internet visitor
    Person.person.isWantsSelfHelp = MyMethods.actionCommandResetCounter(Person.person.isWantsSelfHelp);
  }

  void jRadioButton5_actionPerformed(ActionEvent e)
  {
    //maximum information
    Person.person.isWantsThorough = MyMethods.actionCommandResetCounter(Person.person.isWantsThorough);
    //2-06 for HQ
    HappinessQuotient.isCalculateHQ = true;
  }

  void jRadioButton7_actionPerformed(ActionEvent e)
  {
    //speed over thoroghness
    Person.person.isWantsSpeed = MyMethods.actionCommandResetCounter(Person.person.isWantsSpeed);
  }

  void jRadioButton6_actionPerformed(ActionEvent e)
  {
    //instructor wants course credit
    Person.person.isInstructorWantsCredit = MyMethods.actionCommandResetCounter(Person.person.isInstructorWantsCredit);
  }

  void jRadioButton9_actionPerformed(ActionEvent e)
  {
   //working adult or homemaker
   Person.person.isAcademicHelpOnly = MyMethods.actionCommandResetCounter(Person.person.isAcademicHelpOnly);
   System.out.println("from FrameUserType Person.person.isAcademicHelpOnly= "+Person.person.isAcademicHelpOnly);
  }

  void jRadioButton2_actionPerformed(ActionEvent e)
  {
    //univ 100 assignment
    Person.person.isU100 = MyMethods.actionCommandResetCounter(Person.person.isU100);
    //don't use MyMethods.act--- because it will reverse these and they could get reversed again later
    Person.person.isCourseCredit = true;
    Person.person.isCollegeStudent = true;
    Person.person.isStudent = true;
  }

  void jRadioButton4_actionPerformed(ActionEvent e)
  {
    //csulb student wants credit
    Person.person.isCreditCSULB = MyMethods.actionCommandResetCounter(Person.person.isCreditCSULB);
    Person.person.isCourseCredit = true;// MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
    Person.person.isCollegeStudent = true; //MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
    Person.person.isStudent = true;//MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
  }

  void jRadioButton3_actionPerformed(ActionEvent e)
  {
    //other college student wants credit
    Person.person.isCreditOther = MyMethods.actionCommandResetCounter(Person.person.isCreditOther);
    //next 3 changed 3/02 from = true
    Person.person.isCourseCredit = MyMethods.actionCommandResetCounter(Person.person.isCourseCredit);//MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
    Person.person.isCollegeStudent = MyMethods.actionCommandResetCounter(Person.person.isCollegeStudent);//MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
    Person.person.isStudent = MyMethods.actionCommandResetCounter(Person.person.isStudent);//MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
  }

  void jRadioButton10_actionPerformed(ActionEvent e)
  {
    //other college student no credit
    Person.person.isCollegeStudentOther = MyMethods.actionCommandResetCounter(Person.person.isCollegeStudentOther);
    //changed 3/02 from = true
    Person.person.isCollegeStudent = MyMethods.actionCommandResetCounter(Person.person.isCollegeStudent);//MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
    Person.person.isStudent = MyMethods.actionCommandResetCounter(Person.person.isStudent);//MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
  }

  void jRadioButton12_actionPerformed(ActionEvent e)
  {
    //research subject
    Person.person.isResearchSubject = MyMethods.actionCommandResetCounter(Person.person.isResearchSubject);
    CaresQuestControl.isFrameResearchSubject = MyMethods.actionCommandResetCounter(CaresQuestControl.isFrameResearchSubject);
  }

  void jRadioButton11_actionPerformed(ActionEvent e)
  {
    //none of above
    //do nothing Person.person. = true;
   Person.person.isGoalNotForSelf = MyMethods.actionCommandResetCounter(Person.person.isGoalNotForSelf);

  }

  void jRadioButton8_actionPerformed(ActionEvent e)
  {
    //wants specific help
    Person.person.isWantsSpecificHelp = MyMethods.actionCommandResetCounter(Person.person.isWantsSpecificHelp);
    //Person.person.isStudent = MyMethods.actionCommandResetCounter(Person.person.isGoalDepression);
  }

  void jRadioButton15_actionPerformed(ActionEvent e)
  {
    //college faculty member or administrator
    Person.person.isFacultyOrAdmin = MyMethods.actionCommandResetCounter(Person.person.isFacultyOrAdmin);
  }

  void jRadioButton14_actionPerformed(ActionEvent e)
  {
    //other type of student -- don't use MyMethods--too many ways it can get reversed
    Person.person.isStudent = true;
  }

  void jRadioButton16_actionPerformed(ActionEvent e)
  {
   //wants specific questionnaire
   Person.person.isSpecificQuestionnaire = MyMethods.actionCommandResetCounter(Person.person.isSpecificQuestionnaire);
  }

  void jRadioButton17_actionPerformed(ActionEvent e)
  {
    Person.person.isPreviousUser = MyMethods.actionCommandResetCounter(Person.person.isPreviousUser);
    CaresQuestControl.isPreviousUser = MyMethods.actionCommandResetCounter(Person.person.isPreviousUser);
  }
/**
 * This method initializes jButton1
 *
 * @return javax.swing.JButton
 */
private JButton getJButton1()
{
	if (jButton1 == null)
	{
		jButton1 = new JButton();
		jButton1.setBackground(new Color(200, 255, 200));  // Generated
		jButton1.setMinimumSize(new Dimension(171, 35));  // Generated
		jButton1.setToolTipText("");  // Generated
		jButton1.setText("OK--GO TO NEXT FRAME");  // Generated
		jButton1.setPreferredSize(new Dimension(160, 25));  // Generated
		jButton1.setFont(new Font("SansSerif", 1, 13));  // Generated
		jButton1.addActionListener(new java.awt.event.ActionListener()
		{
			public void actionPerformed(java.awt.event.ActionEvent e)
			{
				  //check and store data
				  //this is the ok button to go to next frame
				    FrameUserType.this.setVisible(false);
				    //old-generated error this.setVisible(false);
//				    PersonDataFrame personDataFrame = new PersonDataFrame();
//				    personDataFrame.setSize(760,600);
//				    personDataFrame.setLocation(20, 0);
//				    //personDataFrame
//				    personDataFrame.setVisible(true);
				    CaresQuestControl.isGo = true;
				    CaresQuestControl.manageFiringQue(e);
				    //System.out.println("actionPerformed()"); // TODO Auto-generated Event stub actionPerformed()
			}
		});
	}
	return jButton1;
    }

    /**
     * Added so Frames will run alone in NetBeans
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new FrameUserType().setVisible(true);
            }
        });
    }


//end class
}

class FrameUserType_jRadioButton1_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton1_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton1_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton5_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton5_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton5_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton7_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton7_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton7_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton6_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton6_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton6_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton2_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton2_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton2_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton4_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton4_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton4_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton3_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton3_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton3_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton10_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton10_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton10_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton11_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton11_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton11_actionPerformed(e);
  }
}

//class FrameUserType_jButton1_actionAdapter implements java.awt.event.ActionListener
//{
//  FrameUserType adaptee;
//
//  FrameUserType_jButton1_actionAdapter(FrameUserType adaptee)
//  {
//    this.adaptee = adaptee;
//  }
//  public void actionPerformed(ActionEvent e)
//  {
//    adaptee.jButton1_actionPerformed(e);
//  }
//}

class FrameUserType_jRadioButton15_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton15_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton15_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton14_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton14_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton14_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton8_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton8_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton8_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton16_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton16_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton16_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton17_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton17_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton17_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton9_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton9_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton9_actionPerformed(e);
  }
}

class FrameUserType_jRadioButton12_actionAdapter implements java.awt.event.ActionListener
{
  FrameUserType adaptee;

  FrameUserType_jRadioButton12_actionAdapter(FrameUserType adaptee)
  {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e)
  {
    adaptee.jRadioButton12_actionPerformed(e);
  }
}

