/* ////////////////////////////////////////////////////////////

2017 Playground - ToNES / Media Design Show File

Media Designer: Giada Sun

Director: Jialin He
Scenic Designer: Jiahui Shi
Lighting Designer: Ying Huo
Sound Designer: Yiran Zhang

Copyright (c) 2017 Giada Sun.  All rights reserved.

//////////////////////////////////////////////////////////// */

PFont Helvetica, ArabicUIText_25, PingFang_50;

int inputTextSize  = 24;
int inputTextLead  = 32;
int outputTextSize = 28;
int outputTextLead = 36;
int fps = 25;

PImage[] windowLeft = new PImage[17];
PImage   windowRight, windowQuestion;

float design_w=1920.0, design_h=1200.0;

int cScene = 0;
int cLineIndex  = 0;
int cLineIndexLength;
int cWordIndex;

int[] sceneOrder = {2,3,4,5,7,8,10,11,12,13,15,16};
String[] sceneNames = {"SPANISH P1","SPANISH Q P1","SPANISH P2","SPANISH Q P2","RUSSIAN","RUSSIAN Q",
                        "ARABIC P1", "ARABIC Q P1", "ARABIC P2", "ARABIC Q P2","CHINESE","CHINESE Q"};

String[] SP_P1_O={}, SP_P1_T={}, SP_P1_Q={};
String[] SP_P2_O={}, SP_P2_T={}, SP_P2_Q={};
String[]    RU_O={},    RU_T={},    RU_Q={};
String[] AB_P1_O={}, AB_P1_T={}, AB_P1_Q={};
String[] AB_P2_O={}, AB_P2_T={}, AB_P2_Q={};
String[]    CH_O={},    CH_T={},    CH_Q={};

int SP_P1_L=0, SP_P1_Q_L=0;
int SP_P2_L=0, SP_P2_Q_L=0;
int    RU_L=0,    RU_Q_L=0;
int AB_P1_L=0, AB_P1_Q_L=0;
int AB_P2_L=0, AB_P2_Q_L=0;
int    CH_L=0,    CH_Q_L=0;

////////////////////////////////////////////////////////////
// Helper Fuctions
////////////////////////////////////////////////////////////

void importFiles() {
  
  ArabicUIText_25 = createFont("ArabicUIText.ttc", 25);
  PingFang_50     = createFont("PingFang.ttc", 50);
  
  windowLeft[0]  = loadImage("translator-left-01.png");
  windowLeft[1]  = loadImage("translator-left-01.png");
  windowLeft[2]  = loadImage("translator-left-01.png");
  windowLeft[3]  = loadImage("translator-left-01.png");
  windowLeft[4]  = loadImage("translator-left-01.png");
  windowLeft[5]  = loadImage("translator-left-01.png");
  windowLeft[6]  = loadImage("translator-left-02.png");
  windowLeft[7]  = loadImage("translator-left-02.png");
  windowLeft[8]  = loadImage("translator-left-02.png");
  windowLeft[9]  = loadImage("translator-left-03.png");
  windowLeft[10] = loadImage("translator-left-03.png");
  windowLeft[11] = loadImage("translator-left-03.png");
  windowLeft[12] = loadImage("translator-left-03.png");
  windowLeft[13] = loadImage("translator-left-03.png");
  windowLeft[14] = loadImage("translator-left-04.png");
  windowLeft[15] = loadImage("translator-left-04.png");
  windowLeft[16] = loadImage("translator-left-04.png");
  windowRight    = loadImage("translator-right.png");
  windowQuestion = loadImage("qWindow.png");
}

String[] returnStringArray(int n, int section) {
   ///////////////////////////////////////////////////////////////////
   if      ((n == 2) && (section == 1))  return SP_P1_O;
   else if ((n == 2) && (section == 2))  return SP_P1_T;
   else if  (n == 3)                     return SP_P1_Q;
   else if ((n == 4) && (section == 1))  return SP_P2_O;
   else if ((n == 4) && (section == 2))  return SP_P2_T;
   else if  (n == 5)                     return SP_P2_Q;
   ///////////////////////////////////////////////////////////////////
   else if ((n == 7) && (section == 1))  return RU_O;
   else if ((n == 7) && (section == 2))  return RU_T;
   else if  (n == 8)                     return RU_Q;
   ///////////////////////////////////////////////////////////////////
   else if ((n == 10) && (section == 1)) return AB_P1_O;
   else if ((n == 10) && (section == 2)) return AB_P1_T;
   else if  (n == 11)                    return AB_P1_Q;
   else if ((n == 12) && (section == 1)) return AB_P2_O;
   else if ((n == 12) && (section == 2)) return AB_P2_T;
   else if  (n == 13)                    return AB_P2_Q;
   ///////////////////////////////////////////////////////////////////
   else if ((n == 15) && (section == 1)) return CH_O;
   else if ((n == 15) && (section == 2)) return CH_T;
   else if  (n == 16)                    return CH_Q;
   ///////////////////////////////////////////////////////////////////
   String[] s = {};
   return s;
}

int returnStringArrayLength(int n) {
   ///////////////////////////////////////////////////////////////////
   if      (n == 2)  return SP_P1_L;
   else if (n == 3)  return SP_P1_Q_L;
   else if (n == 4)  return SP_P2_L;   
   else if (n == 5)  return SP_P2_Q_L;
   else if (n == 7)  return RU_L;
   else if (n == 8)  return RU_Q_L;
   else if (n == 10) return AB_P1_L;
   else if (n == 11) return AB_P1_Q_L;
   else if (n == 12) return AB_P2_L;
   else if (n == 13) return AB_P2_Q_L;
   else if (n == 15) return CH_L;
   else if (n == 16) return CH_Q_L;
   else              return -1;
}

void textFilesParse() {
  String[] lines;
  lines = loadStrings("02_Spanish_P1.txt");
  for (int i = 0 ; i < lines.length; i++) {
    if      (i%3 == 1) SP_P1_O = append(SP_P1_O, lines[i]);
    else if (i%3 == 2) SP_P1_T = append(SP_P1_T, lines[i]);
  }
  SP_P1_L = SP_P1_T.length;  
  SP_P1_Q   = loadStrings("03_Spanish_Q_P1.txt");
  SP_P1_Q_L = SP_P1_Q.length/6*4;
  lines = loadStrings("04_Spanish_P2.txt");
  for (int i = 0 ; i < lines.length; i++) {
    if      (i%3 == 1) SP_P2_O = append(SP_P2_O, lines[i]);
    else if (i%3 == 2) SP_P2_T = append(SP_P2_T, lines[i]);
  }
  SP_P2_L = SP_P2_T.length;
  SP_P2_Q   = loadStrings("05_Spanish_Q_P2.txt");
  SP_P2_Q_L = SP_P2_Q.length/6*4;
  lines = loadStrings("07_Russian.txt");
  for (int i = 0 ; i < lines.length; i++) {
    if      (i%3 == 1) RU_O = append(RU_O, lines[i]);
    else if (i%3 == 2) RU_T = append(RU_T, lines[i]);
  }
  RU_L = RU_T.length;
  RU_Q   = loadStrings("08_Russian_Q.txt");
  RU_Q_L = RU_Q.length/6*4;
  lines = loadStrings("10_Arabic_P1.txt");
  for (int i = 0 ; i < lines.length; i++) {
    if      (i%3 == 1) AB_P1_O = append(AB_P1_O, lines[i]);
    else if (i%3 == 2) AB_P1_T = append(AB_P1_T, lines[i]);
  }
  AB_P1_L = AB_P1_T.length;  
  AB_P1_Q   = loadStrings("11_Arabic_Q_P1.txt");
  AB_P1_Q_L = AB_P1_Q.length/6*4;
  lines = loadStrings("12_Arabic_P2.txt");
  for (int i = 0 ; i < lines.length; i++) {
    if      (i%3 == 1) AB_P2_O = append(AB_P2_O, lines[i]);
    else if (i%3 == 2) AB_P2_T = append(AB_P2_T, lines[i]);
  }
  AB_P2_L = AB_P2_T.length;
  AB_P2_Q   = loadStrings("13_Arabic_Q_P2.txt");
  AB_P2_Q_L = AB_P2_Q.length/6*4;
  lines = loadStrings("15_Chinese.txt");
  for (int i = 0 ; i < lines.length; i++) {
    if      (i%3 == 1) CH_O = append(CH_O, lines[i]);
    else if (i%3 == 2) CH_T = append(CH_T, lines[i]);
  }
  CH_L = CH_T.length;
  CH_Q   = loadStrings("16_Chinese_Q.txt");
  CH_Q_L = CH_Q.length/6*4;
}

void drawWindows() {
  float x0 =  110*(width/design_w);
  float y0 =   10*(width/design_w);
  float x1 = 1010*(width/design_w);
  float y1 =   10*(width/design_w);
  float w  =  800*(width/design_w);
  float h  =  500*(width/design_w);
  
  image(windowLeft[sceneOrder[cScene]], x0, y0, w, h);
  image(windowRight, x1, y1, w, h);
}

void drawQuestionWindow() {
  float x =  110*(width/design_w);
  float y =   10*(width/design_w);
  float w = 1700*(width/design_w);
  float h =  500*(width/design_w);
  
  image(windowQuestion, x, y, w, h);
}

void drawTextLeft(String input) {
  float x = 135*(width/design_w);
  float y = 210*(width/design_w);
  float w = 750*(width/design_w);
  float h = 210*(width/design_w);

  if ((sceneOrder[cScene] == 10) || (sceneOrder[cScene] == 12)) textAlign(RIGHT, TOP);
  else textAlign(LEFT, TOP);

  if ((sceneOrder[cScene] == 10) || (sceneOrder[cScene] == 12)) {
    textFont(ArabicUIText_25);
    textLeading(35);
  }
  else if (sceneOrder[cScene] == 15) {
    textFont(PingFang_50);
    textLeading(60);
  }
  else {
    textSize(inputTextSize);
    textLeading(inputTextLead); 
  }
  fill(0);
  text(input, x, y, w, h);
}

void drawTextRight(String input) {
  float x = 1035*(width/design_w);
  float y =  105*(width/design_w);
  float w =  750*(width/design_w);
  float h =  305*(width/design_w);
  
  textSize(outputTextSize);
  textAlign(LEFT, TOP);
  textLeading(outputTextLead); 
  fill(255);
  text(input, x, y, w, h);
}

void drawInfoText() {
  textSize(15);
  textAlign(LEFT, BOTTOM);
  fill(255);
  String str = sceneNames[cScene] + "  |  CUE: " + sceneOrder[cScene] + "." + cLineIndex + "/" + (returnStringArrayLength(sceneOrder[cScene])-1);
  float x = 20*(width/design_w);
  float y = height-5;
  text(str, x, y);
}

String randomSwitch(String input) {
  int startIndex = -1;
  char[] chars={};
  for (int i=input.length()-1; i>=0; i--) {
    if (input.charAt(i) == ' ') break;
    startIndex = i;
    chars = splice(chars, input.charAt(i), (int)random(chars.length+1));
  }
  String output = new String(chars);
  if (startIndex == -1) return input;
  return input.substring(0, startIndex) + output;
}

String getTranslatedText(String line, float percent) {
  if (percent >= 1.0) return line;
  int n = (int)(line.length()*percent);
  return randomSwitch(line.substring(0, n));
}

void cLineIndexReset() {
  cWordIndex  = 0;
}


////////////////////////////////////////////////////////////
// Main Fuctions
////////////////////////////////////////////////////////////

void setup() {
  size(1280, 400);
  frameRate(fps);
  
  importFiles();
  cLineIndexReset();
  textFilesParse();
}

String s1,s2,s3;
int l;

void drawQuestionIndex(String input) {
    textSize(35);
    textAlign(CENTER, BOTTOM);
    fill(255);
    float x = 960*(width/design_w);
    float y = 115*(width/design_w);
    text(input, x, y);
}

void drawQuestion(String input) {
  
    textSize(32.5);
    textAlign(LEFT, BOTTOM);
    fill(0);
    
    if (sceneOrder[cScene] == 5) {
      float x = 200*(width/design_w);
      float y = 220*(width/design_w);
      text("According to the second part of their conversation, has MARIANA", x, y);
      y = 280*(width/design_w);
      text("been to Peru?", x, y);
    }
    else if (sceneOrder[cScene] == 13) {
      float x = 200*(width/design_w);
      float y = 220*(width/design_w);
      text("According to the dialog, which topic are they going to discuss", x, y);
      y = 280*(width/design_w);
      text("next meeting?", x, y);
    }
    else {
      float x = 200*(width/design_w);
      float y = 240*(width/design_w);
      text(input, x, y);
    }
}

void drawOptionA(String input, boolean isAnswer) {
    textSize(35);
    textAlign(LEFT, BOTTOM);
    if (isAnswer) fill(0,225,0);
    else          fill(0);
    float x = 200*(width/design_w);
    float y = 340*(width/design_w);
    if (sceneOrder[cScene] == 5 || sceneOrder[cScene] == 13) y = 360*(width/design_w);
    text(input, x, y);
}

void drawOptionB(String input, boolean isAnswer) {
    textSize(35);
    textAlign(LEFT, BOTTOM);
    if (isAnswer) fill(0,225,0);
    else          fill(0);
    float x = 200*(width/design_w);
    float y = 410*(width/design_w);
    if (sceneOrder[cScene] == 5 || sceneOrder[cScene] == 13) y = 430*(width/design_w);
    text(input, x, y);
}

void drawOptionC(String input, boolean isAnswer) {
    textSize(35);
    textAlign(LEFT, BOTTOM);
    if (isAnswer) fill(0,225,0);
    else          fill(0);
    float x = 200*(width/design_w);
    float y = 480*(width/design_w);
    text(input, x, y);
}


void draw() {
  
  background(0);
  
  if ((sceneOrder[cScene] == 2)  || (sceneOrder[cScene] == 4)  || (sceneOrder[cScene] == 7) ||
      (sceneOrder[cScene] == 10) || (sceneOrder[cScene] == 12) || (sceneOrder[cScene] == 15)) {
    // translators
    s1 = returnStringArray(sceneOrder[cScene], 1)[cLineIndex];
    s2 = returnStringArray(sceneOrder[cScene], 2)[cLineIndex];
    l  = s1.length();
    drawWindows();
    drawTextLeft(s1.substring(0, cWordIndex));
    drawTextRight(getTranslatedText(s2, ((float)(cWordIndex+1)/l)));
    if (cWordIndex < l) cWordIndex += 1;
  }
  
  else if ((sceneOrder[cScene] == 3)  || (sceneOrder[cScene] == 5)  || (sceneOrder[cScene] == 8) ||
           (sceneOrder[cScene] == 11) || (sceneOrder[cScene] == 13) || (sceneOrder[cScene] == 16)) {
    drawQuestionWindow();
    ////////////////////////////////////////////////////////////
    // Special Case
    ////////////////////////////////////////////////////////////
    if ((sceneOrder[cScene] == 11) && (cLineIndex == 3)) {
      drawQuestionIndex(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+1]);
      drawQuestion(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+2]);
      drawOptionA(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+3], false);
      drawOptionB(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+4], false);
      s1 = returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+5];
      l  = s1.length();
      drawOptionC(s1.substring(0, cWordIndex), false);
      if (cWordIndex < l) cWordIndex += 1;
    }
    else if ((sceneOrder[cScene] == 11) && (cLineIndex == 4)) {
      drawQuestionIndex(returnStringArray(sceneOrder[cScene], 0)[1]);
      drawQuestion(returnStringArray(sceneOrder[cScene], 0)[2]);
      s1 = returnStringArray(sceneOrder[cScene], 0)[3];
      s2 = returnStringArray(sceneOrder[cScene], 0)[4];
      s3 = returnStringArray(sceneOrder[cScene], 0)[5];
      l  = s1.length() + s2.length() + s3.length() -1;
      int s1_index=0, s2_index=0, s3_index=0;
      if (cWordIndex < s3.length()) {
        s1_index = s1.length();
        s2_index = s2.length();
        s3_index = s3.length() - cWordIndex - 1;
      }
      else if (cWordIndex < (s2.length() + s3.length())) {
        s1_index = s1.length();
        s2_index = s2.length() - (cWordIndex - s3.length()) - 1;
      }      
      else s1_index = s1.length() - (cWordIndex - (s2.length() + s3.length())) - 1;
      drawOptionA(s1.substring(0, s1_index), false);
      drawOptionB(s2.substring(0, s2_index), false);
      drawOptionC(s3.substring(0, s3_index), false);
      if (cWordIndex < l) cWordIndex += 1;
    }
    ////////////////////////////////////////////////////////////
    // Normal Case
    ////////////////////////////////////////////////////////////
    else if (cLineIndex%4 == 0) {
      drawQuestionIndex(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+1]);
      drawQuestion(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+2]);
    }
    else if (cLineIndex%4 == 1) {
      drawQuestionIndex(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+1]);
      drawQuestion(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+2]);
      //
      s1 = returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+3];
      l  = s1.length();
      drawOptionA(s1.substring(0, cWordIndex), false);
      if (cWordIndex < l) cWordIndex += 1;
    }
    else if (cLineIndex%4 == 2) {
      drawQuestionIndex(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+1]);
      drawQuestion(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+2]);
      drawOptionA(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+3], false);
      //
      s1 = returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+4];
      l  = s1.length();
      drawOptionB(s1.substring(0, cWordIndex), false);
      if (cWordIndex < l) cWordIndex += 1;
    }
    else if (cLineIndex%4 == 3) {
      drawQuestionIndex(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+1]);
      drawQuestion(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+2]);
      String answer = returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+5];
      if (Integer.parseInt(answer) == 1) {
        drawOptionA(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+3], true);
        drawOptionB(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+4], false);
      }
      else if (Integer.parseInt(answer) == 2) {
        drawOptionA(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+3], false);
        drawOptionB(returnStringArray(sceneOrder[cScene], 0)[(int)(cLineIndex/4)*6+4], true);
      }
    }
  }
  drawInfoText();
}

void keyPressed() {
  
  if ((keyCode == DOWN) || (keyCode == ENTER)) {
    if (cLineIndex < returnStringArrayLength(sceneOrder[cScene])-1) {
      cLineIndex += 1;
      cLineIndexReset();
    }
  }
  else if (keyCode == UP) {
    if (cLineIndex > 0) {
      cLineIndex -= 1;
      cLineIndexReset();
    }
  }
  else if (keyCode == LEFT) {
    if (cScene > 0) {
      cScene -= 1;
      cLineIndexReset();
      cLineIndex = 0;
    }
  }
  else if (keyCode == RIGHT) {
    if (cScene < sceneOrder.length-1) {
      cScene += 1;
      cLineIndexReset();
      cLineIndex = 0;
    }
  }
  // Chinese Coversation Slow Down
  if (sceneOrder[cScene] == 15) {
    if ( cLineIndex == 1  || cLineIndex == 7  || cLineIndex == 9 ||
         cLineIndex == 11 || cLineIndex == 13 || cLineIndex == 15 ) frameRate(4);
    else frameRate(8);
  }
  else if (sceneOrder[cScene] == 2) frameRate(10);
  else frameRate(fps);
}