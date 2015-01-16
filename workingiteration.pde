//create image in folder i save it in, in data folder.

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Movie react;
Capture video;
OpenCV opencv;

void setup() {
  size(1280, 720);
  //scale video down, so it runs smoother
  video = new Capture(this, 640/2, 480/2);
  //loading open cv, and face tracking
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  video.start();

  //loading my video
  react = new Movie(this, "beth wave2.mov");
  //looping video
  react.loop();
}

void draw() {

  //scaling video back up to fit the canvas
  scale(2);
  opencv.loadImage(video);

  //displaying the camera video, will be removed
  image(video, 0, 0 );

  //adjusting the reaction video
  pushMatrix();
  //scaling video down to fit canvas
  scale(0.5);
  //tint to make transparent
  //tint(255, 185);
  //display my reaction video
  image(react, 0, 0);
  popMatrix();

  //styling for the face tracking rectangle
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  //draw rectangle around the face
  //for (int i = 0; i < faces.length; i++) {
   // println(faces[i].x + "," + faces[i].y);
   // rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
 // }

  //if one or more faces are seen, reaction video will play, else it is paused.
  if (faces.length >= 1) {
    react.play();
  } else {
    //when theres no face, reaction video jumps to beginning 
    react.jump(0);
    react.pause();
  }
}

void captureEvent(Capture c) {
  c.read();
}

void movieEvent(Movie m) {
  m.read();
}

