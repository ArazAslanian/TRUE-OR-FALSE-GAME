String msg;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  //defining the modes for our LEDs
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  // to get the messages from processing:
  while (Serial.available()) {
    msg = Serial.readString();
    msg.trim(); // so that the string does not go through with extra strings, it will cut any white spaces
    Serial.println(msg);

    // check to see whether the message says on or off and execute different codes accordingly
    // "on" is if the answer was correct so the green LED lights up
    // "off" is if the answer was wrong so the red LED lights up
    //return message to confirm received:
    if (msg == "on") {
      digitalWrite(12, HIGH);
      delay(1000);
      digitalWrite(12, LOW);

    } else if (msg == "off") {
      digitalWrite(13, HIGH);
      delay(1000);
      digitalWrite(13, LOW);
    }


  }
}


//String msg;
//boolean isOn = false;
//
//void setup() {
//  // put your setup code here, to run once:
//Serial.begin(9600);
//pinMode(13,OUTPUT);
//}
//
//void loop() {
//  // put your main code here, to run repeatedly:
//  while(Serial.available()){
//    msg = Serial.readString();
//    msg.trim(); // so that the string does not go through with extra strings, it will cut any white spaces
//
//    //return message to confirm received:
//    if(msg == "on"){
//      if(isOn){
//      digitalWrite(13,LOW);
//      isOn = false;
//    } else {
//      digitalWrite(13,HIGH);
//      isOn = true;
//    }
//    }
//  }
//}
