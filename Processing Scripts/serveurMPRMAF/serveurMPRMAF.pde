//Luc-Olivier Dumais-Blais
//Museomix Les defenestres (10)
//Serveur Musee Place Royale
//        Musee Amerique Francaise
//09-10-2013
import java.io.*;
import processing.serial.*;

Serial myPort;

String pathToVideoScript = "";
void setup()
{
  println("Serveur MPR/MAF");
  println(Serial.list());//Find the right device for the next line
  myPort = new Serial(this, "/dev/cu.usbmodemfd121", 9600);
}

void draw()
{
  loop();
}

void loop()
{
  while (myPort.available () > 0) {
    char inBuffer = myPort.readChar();
    char inBuffer2 = myPort.readChar();
    char data[] = {
      inBuffer, inBuffer2
    };
    String value = new String(data);
    //    if (inBuffer != null) {
    println(value);
    if (value.equals("P1")) {
      //launch script
      int val = runAppleScript("StationMPR.scpt");//Change script name according to station
    } else if (value.equals("P2")) {
      println("P2");
      //launch script
      int val = runAppleScript("StationMAF.scpt");//Change script name according to station
    } else {
      println("WRONG");
    }
    //verify if video still playing to refuse any change in sensor values
    while (myPort.available () > 0)
      myPort.read();
  }
}

int runAppleScript (String scriptName)
{
  try {
      Process p = Runtime.getRuntime().exec("osascript /Users/lucolivier/src/museomix/AppleScripts/" + scriptName);
      int i = p.waitFor();
      println(i);
      if (i == 0) {
        String returnedValues;
        BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
        while ( (returnedValues = stdInput.readLine ()) != null) {
          println(returnedValues);
        }
      }
    } 
    catch (Exception e) {
      println("Error running command!");  
      println(e);
    }
    return 1;
}

