//Arduino pour deux stations
#define led1 4
#define led2 5
#define Pression1 A0
#define Pression2 A1

int p1=0; //value between 0 and 1024
int p2=0; //value between 0 and 1024

boolean lastValuePression1 = false;
boolean lastValuePression2 = false;

void setup() 
{ 
  
  Serial.begin(9600);
  
  pinMode(led1,OUTPUT);
  pinMode(led2,OUTPUT);
  pinMode(Pression1, INPUT);
  pinMode(Pression2, INPUT);
} 
 
 
void loop() 
{ 
  p1 = analogRead(Pression1);
  p2 = analogRead(Pression2);
  
  if(p1 > 450){
    digitalWrite(led1,HIGH);
    if (!lastValuePression1) {
      int bytesSent = Serial.write("P1");
    }
    lastValuePression1 = true;
  } else {
    lastValuePression1 = false;
  }
   
   if(p2 > 450) {
     digitalWrite(led2,HIGH);
     if (!lastValuePression2) {
       int bytesSent = Serial.write("P2");
     }
     lastValuePression2 = true;
   } else {
     lastValuePression2 = false;
   }
  
  digitalWrite(led1,LOW);
  digitalWrite(led2,LOW);
}
