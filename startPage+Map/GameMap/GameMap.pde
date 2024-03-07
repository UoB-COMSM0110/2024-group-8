class Map{
  int WIDTH = 1000;
  int HEIGHT = (int)(WIDTH * 0.8);
  float playWindowHeight = WIDTH * 0.65;
  float cellSize = WIDTH / 20;
  float menuPosY = playWindowHeight + 1;
  float menuHeight = HEIGHT - menuPosY;
  
  int[][] Grid = new int[20][13];
  
  PImage path;
  PImage pathMask;
  
  
  void settings(){
    size(WIDTH, HEIGHT);
  }

}

Lung lung; 
Kidney kidney;
Brain brain;
Heart heart;

void setup() {
  size(1000, 800); 
  lung = new Lung(); 
  kidney = new Kidney();
  brain = new Brain();
  heart = new Heart();
}

void draw(){
}

///////////////select map////////////
//void keyPressed(){
// if (key =='1'){
//   lung.draw();
// } if (key =='2'){
//   kidney.draw();
// } if (key =='3'){
//   brain.draw();
// } if (key =='4'){
//   heart.draw();
// }
  
}

class Vector{
  int x, y;
  
  Vector(int x, int y){
    this.x = x;
    this.y = y;
  }
  
}
