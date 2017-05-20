
float x = 0, y = 0;
float angle;
float len = 1.0;
float r=255, g=255, b=255;

void setup(){
  size(1000, 1000);
  background(0);
  
  stroke(r, g, b);
  strokeWeight(0.1);
  translate(width/2, height);
  //rotate(-PI/4);


  String lines[] = loadStrings("l-system.txt");
  angle = PI * Float.parseFloat(lines[0]);
  len = Float.parseFloat(lines[1]);
  
  println("there are " + lines.length + " lines");
  //for (int i = 0 ; i < lines.length; i++) {
    for(int j=0;j<lines[1].length();j++){
      if(lines[2].charAt(j) == '[') pushMatrix();
      if(lines[2].charAt(j) == ']') popMatrix();
      if(lines[2].charAt(j) == '+') rotate(angle);
      if(lines[2].charAt(j) == '-') rotate(-angle);
      if(lines[2].charAt(j) == 'F'){
        line(x, y, x, y-len);
        translate(0,-len);
      }
      if(lines[2].charAt(j) == 'G'){
        line(x, y, x, y-len*1.5);
        translate(0,-len*1.5);
      }
      
      //println(lines[i].charAt(j));
    //}
  }

  
  
}

void draw(){
  /*setup();
  angle+=0.003;
  */
}

/*
F X+F-Y
X G[++G[F-F]F[--X]]
G F-[G+X]
*/