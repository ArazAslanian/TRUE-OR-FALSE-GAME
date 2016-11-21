//to allow communication between Arduino and Processing
import processing.serial.*;
Serial myPort;
boolean isSent = false;     // to sent the message only once

// declaring the images
PImage imgFalse;
PImage imgTrue;
PImage imgQuiz;

//to allow score counts in the mouse clicked funtion
boolean correct = false;
boolean wrong = false;

// for the last two pages of the game that show the answers to the questions
boolean showAnswers;
boolean showAnswers2;

//counter for determining which questions are displayed and for counting how many correct answers out of ten in the game
int counter = 0;
int correctAnswers = 0;


void setup() {
  size(800, 600);

  ////specifying the port and other settings to allow communication
  String portName = "COM3";
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');

  // loading the images:
  imgFalse = loadImage("False.PNG");
  imgFalse.resize(100, 100);

  imgTrue = loadImage("True.PNG");
  imgTrue.resize(100, 100);

  imgQuiz = loadImage("Quiz.png");
  imgQuiz.resize(100, 100);
}

void draw() {
  background(255);
  // control questions displayed:
  if (counter==0) {
    imgQuiz.resize(200, 200);
    imageMode(CENTER);
    image(imgQuiz, width/2, height/2);
    textSize(40);
    fill(0, 102, 153);
    text("TRUE OR FALSE QUIZ", width/4, height/5);
    fill(0, 102, 153, 51);
    text("CLICK ANYWHERE TO START", width/5.5, height/1.2);
  } else if (counter==1) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("As far as has ever been reported,", 150, 200);
    text("no-one has ever seen an ostrich bury its head", 50, 250);
  } else if (counter==2) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("Approximately one quarter of", 175, 200);
    text("human bones are in the feet.", 175, 250);
  } else if (counter==3) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("Popeye’s nephews were called ", 175, 200);
    text("Peepeye, Poopeye, Pipeye and Pupeye.", 120, 250);
  } else if (counter==4) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("In ancient Rome, a special room called", 120, 200);
    text("a vomitorium was available for diners to purge", 70, 250);
    text("food in during meals", 250, 300);
  } else if (counter==5) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("The average person will shed 10 ", 150, 200);
    text("pounds of skin during their lifetime.", 130, 250);
  } else if (counter==6) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("Sneezes regularly exceed 100 m.p.h.", 130, 200);
  } else if (counter==7) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("A slug’s blood is green.", 230, 200);
  } else if (counter==8) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("The Great Wall Of China is visible from the moon.", 50, 200);
  } else if (counter==9) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("Virtually all Las Vegas gambling casinos", 100, 200); 
    text("ensure that they have no clocks.", 150, 250);
  } else if (counter==10) {
    imageMode(CENTER);
    image(imgTrue, 200, 450);
    image(imgFalse, 600, 450);
    textSize(30);
    fill(0, 102, 153);
    text("The total surface area of two human lungs have", 50, 200); 
    text("a surface area of approximately 70 square metres.", 45, 250);
  } else if (counter >= 11) {

    // the score page
    if (correctAnswers >= 5) {
      imgQuiz.resize(200, 200);
      imageMode(CENTER);
      image(imgQuiz, width/2, height/2);
      textSize(30);
      fill(0, 102, 153);
      text("YOU GOT " + correctAnswers + "/10!!!", 200, 100);
      text("GOOD JOB!!!!", 400, 500);
      textSize(20);
      fill(250, 0, 0);
      text("Click on the shape for the answers", 230, 420);

      // the answers page:
      if (showAnswers) {
        background(255);
        fill(0, 102, 153);
        text("1. As far as has ever been reported, no-one has ever seen an ostrich bury ", 10, 130);
        text("its head in the sand.", 10, 150);
        text("True", 10, 180);
        text("2. Approximately one quarter of human bones are in the feet.", 10, 220);
        text("True – 52 bones in the feet and 206 in the whole body.", 10, 250);
        text("3. Popeye’s nephews were called Peepeye, Poopeye, Pipeye and Pupeye.", 10, 300);
        text("True.", 10, 330);
        text("4. In ancient Rome, a special room called a vomitorium ", 10, 380);
        text("was available for diners to purge food in during meals.", 10, 400);
        text("False – It was the name for the entranceway to a stadium, nothing more.", 10, 430);
        text("5. The average person will shed 10 pounds of skin during their lifetime.", 10, 480);
        text("False – they will shed approximately 40.", 10, 510);
        fill(0, 102, 153);
        rect(550, 543, 110, 20);
        fill(255, 0, 0);
        text("NEXT PAGE", 550, 560);
      }
      // answer page #2
      if (showAnswers2) {
        background(255);
        fill(0, 102, 153);
        text("6. Sneezes regularly exceed 100 m.p.h.", 10, 130);
        text("True", 10, 160);
        text("7. A slug’s blood is green.", 10, 200);
        text("True", 10, 230);
        text("8. The Great Wall Of China is visible from the moon.", 10, 280);
        text("False – at a low orbit the Great Wall is visible, but no man-made structure ", 10, 300);
        text("is visible from outer space or the moon.", 10, 320);
        text("9. Virtually all Las Vegas gambling casinos ensure that they have no clocks.", 10, 380);
        text("True", 10, 410);
        text("10. The total surface area of two human lungs have a surface area of approximately 70 square metres.", 10, 460);
        text("True", 10, 490);
      }
    }
    //this is for the player who got 4 or less correct answers:
    else {

      imgQuiz.resize(200, 200);
      imageMode(CENTER);
      image(imgQuiz, width/2, height/2);
      textSize(30);
      fill(0, 102, 153);
      text("YOU GOT " + correctAnswers + "/10 :(", 200, 100);
      text("YOU NEED TO PAY MORE ATTENTION ", 50, 500);
      text("TO THE WORLD /:", 470, 550);
      textSize(20);
      fill(250, 0, 0);
      text("Click on the shape for the answers", 230, 420);
      textSize(20);
      fill(250, 0, 0);
      text("Click on the shape for the answers", 230, 420);
      // show answers for the person who lost
      if (showAnswers) {
        background(255);
        fill(0, 102, 153);
        text("1. As far as has ever been reported, no-one has ever seen an ostrich bury ", 10, 130);
        text("its head in the sand.", 10, 150);
        text("True", 10, 180);
        text("2. Approximately one quarter of human bones are in the feet.", 10, 220);
        text("True – 52 bones in the feet and 206 in the whole body.", 10, 250);
        text("3. Popeye’s nephews were called Peepeye, Poopeye, Pipeye and Pupeye.", 10, 300);
        text("True.", 10, 330);
        text("4. In ancient Rome, a special room called a vomitorium ", 10, 380);
        text("was available for diners to purge food in during meals.", 10, 400);
        text("False – It was the name for the entranceway to a stadium, nothing more.", 10, 430);
        text("5. The average person will shed 10 pounds of skin during their lifetime.", 10, 480);
        text("False – they will shed approximately 40.", 10, 510);
        fill(0, 102, 153);
        rect(550, 543, 110, 20);
        fill(255, 0, 0);
        text("NEXT PAGE", 550, 560);
      }
      // second page of showing answers for the person who lost
      if (showAnswers2) {
        background(255);
        fill(0, 102, 153);
        text("6. Sneezes regularly exceed 100 m.p.h.", 10, 130);
        text("True", 10, 160);
        text("7. A slug’s blood is green.", 10, 200);
        text("True", 10, 230);
        text("8. The Great Wall Of China is visible from the moon.", 10, 280);
        text("False – at a low orbit the Great Wall is visible, but no man-made structure ", 10, 300);
        text("is visible from outer space or the moon.", 10, 320);
        text("9. Virtually all Las Vegas gambling casinos ensure that they have no clocks.", 10, 380);
        text("True", 10, 410);
        text("10. The total surface area of two human lungs have a surface area of approximately 70 square metres.", 10, 460);
        text("True", 10, 490);
      }
    }
  }

  println(correctAnswers);
}

void mouseClicked() {
  // to transition between questions:
  if (counter == 0) {
    counter++;
  }
  // the questions that the right answer for is true:
  // sending the message "on" to Arduino to get the green LED to light up 
  if (counter == 1 || counter == 2 || counter == 3 || counter == 6 || counter == 7 || counter == 9 || counter == 10) {
    if (mouseX > 150 && mouseX < 250 && mouseY > 400 && mouseY < 500) {
      correct = true;
      if (!isSent) {
        println("Sending!");
        myPort.write("on");
        isSent = true;
      }
      isSent=false;
    }
    if (mouseX > 550 && mouseX < 650 && mouseY > 400 && mouseY < 500) {
      wrong =true;
      if (!isSent) {
        println("Sending!");
        myPort.write("off");
        isSent = true;
      }
      isSent=false;
    }
  } 
  // for questions where false is the right answer
  // sending the message "off" to Arduino to get the red LED to light up 

  else if (counter == 4 || counter == 5 || counter == 8) {
    if (mouseX > 150 && mouseX < 250 && mouseY > 400 && mouseY < 500) {
      wrong = true;
      if (!isSent) {
        println("Sending!");
        myPort.write("off");
        isSent = true;
      }
      isSent = false;
    }
    if (mouseX > 550 && mouseX < 650 && mouseY > 400 && mouseY < 500) {
      correct =true;
      if (!isSent) {
        println("Sending!");
        myPort.write("on");
        isSent = true;
      }
      isSent = false;
    }
    // to count the score, if it is right, we add one to our "correctAnswers" counter:
    if (correct) {
      correctAnswers++;
      counter++;
      correct = false;
    } 
    if (wrong) {
      counter++;
      wrong = false;
    }
  } 
  // for displaying answers on mouse clicked:
  else if (counter >= 11) {
    if (mouseX > 300 && mouseX < 600 && mouseY > 200 && mouseY < 400) {
      showAnswers = true;
      showAnswers2 = false;
    }
    if (mouseX > 550 && mouseX < 660 && mouseY > 543 && mouseY < 563) {
      showAnswers2 = true;
      showAnswers = false;
    }
  }

  if (correct) {
    correctAnswers++;
    counter++;
    correct = false;
  } 
  if (wrong) {
    counter++;
    wrong = false;
  }
}

// for recieving messages:
void serialEvent(Serial myPort) {
  String message = myPort.readString();
  println("Receiving:");
  println(message);
}




//Images taken from:
//http://4.bp.blogspot.com/-vJcRYg1Whg4/Uc9etfaA20I/AAAAAAAAALY/YNGXAgGl6cs/s600/True_or_False_Fotolia_15918310_XS.jpg
//http://mindfulnesstrainingacademy.net/wp-content/uploads/2016/09/images.png

//Questions taken from:
//http://readymadepubquiz.com/quiz-18-round-5-true-or-false/