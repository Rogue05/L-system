import peasy.*;
import java.util.*;
PeasyCam cam;

float t=0;
float x = 0, y = 0, z=-1;
float angle;
float len;// = 1.0;
float radiusDiff = 0.15;
float r = 50.;

color leafColor = color(0, 128, 0);
color white = color(150, 75, 0);


Stack radiusArray;

void displayLeaf(){
  float leafSize = 5;
 fill(leafColor);
 //strokeWeight(1);
 stroke(leafColor);

  rotate(PI/4);
 //noStroke();
  quad(leafSize, leafSize, 
     leafSize, -leafSize, 
     -leafSize, -leafSize, 
     -leafSize, leafSize);
 stroke(white);
 fill(white);
 //strokeWeight(1);
 }

void setup(){
  size(1000, 1000, P3D);
  //cam = new PeasyCam(this, 0, 0, 0, 50);
  radiusArray = new Stack();
  background(0); 
}

void draw(){
  radiusArray.push(r);
  
  beginCamera();
  camera();
  //translate(0, 0, 100);
  endCamera();
  
  strokeWeight(1);
  background(0);
  stroke(white);
  translate(width/2, height);
  rotateY(t/100);


  String lines[] = loadStrings("l-system.txt");
  angle = PI * Float.parseFloat(lines[0]);
  len = Float.parseFloat(lines[1]);
  
  println("there are " + lines.length + " lines");
  //for (int i = 0 ; i < lines.length; i++) {
    for(int j=0;j<lines[2].length();j++){
      if(lines[2].charAt(j) == '[') {
        pushMatrix();
        r = (float)radiusArray.peek();
        radiusArray.push(r);
      }
      if(lines[2].charAt(j) == ']') {
        displayLeaf();
        popMatrix();
        radiusArray.pop();  
      }
      if(lines[2].charAt(j) == '+') rotate(angle);
      if(lines[2].charAt(j) == '-') rotate(-angle);
      if(lines[2].charAt(j) == 'F'){
        r = (float)radiusArray.pop();
        //line(x, y, z, x, y-len, z);
        pushMatrix();
        noFill();
        rotateX(PI/2);
        ellipse(x, y, r, r);
        popMatrix();
        radiusArray.push(r-radiusDiff);
        
        rotateY(PI/14);
        translate(0,-len, 0);
      }
      if(lines[2].charAt(j) == 'G'){
        line(x, y, x, y-len*1.5);
        translate(0,-len*1.5, 0);
      }
      
      println(radiusArray.size());
    //}
  }
  t+=1;
}

/*
F X+F-Y
X G[++G[F-F]F[--X]]
G F-[G+X]
*/