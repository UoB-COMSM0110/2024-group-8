int WIDTH = 1000;
int HEIGHT = (int)(WIDTH * 0.8);
float playWindowHeight = WIDTH * 0.65;
float cellSize = WIDTH / 20;
float menuPosY = playWindowHeight + 1;
float menuHeight = HEIGHT - menuPosY;;

Cell[][] Grid = new Cell[20][13];        //depends on the map

PImage[] TowerSprites;
GermSprite[] GermSprites;

PImage background;
PImage path;
PImage lung;
PImage pathMask;

Cell hoverCell = null;

//Level variable
Path Level;

ArrayList<Tower> AllTowers  = new ArrayList<Tower>();
ArrayList<Germ> AllGerms = new ArrayList<Germ>();
ArrayList<Projectile> AllProjectiles = new ArrayList<Projectile>();


void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  //initalise the grid
  for (int x =0; x < Grid.length; x++){
    for (int y = 0; y < Grid[0].length; y++){
      Grid[x][y] = new Cell(x, y);
    }
  }

  lung = loadImage("lung.png");
  lung.resize(WIDTH, HEIGHT);
  path = loadImage("whiteBG.png");
  path.resize(WIDTH, HEIGHT);
  pathMask = loadImage("route.png");
  //pathMask = loadImage("dirt-mask.png");
  pathMask.resize(WIDTH, HEIGHT);
  path.mask(pathMask);
  
  TowerSprites = new PImage[]{  // Corrected the array declaration
    loadImage("tower/antibody.png"),
  };
  
  GermSprites = new GermSprite[]{
    new GermSprite("germ"),
    //new GermSprite("germ"),
    
  };
  
  Vector[] _path = new Vector[]{
    
    /*new Vector( 0,  1),
    new Vector( 17,  1),
    new Vector( 17,  4),
    new Vector( 2,  4),
    new Vector( 2,  7),
    new Vector( 17,  7),
    new Vector( 17,  10),
    new Vector( 0,  10),*/
    
    new Vector( 0,  5),
    new Vector( 3,  5),
    new Vector( 3,  8),
    new Vector( 1,  8),
    new Vector( 1,  11),
    new Vector( 9,  11),
    new Vector( 9,  8),
    new Vector( 6,  8),
    new Vector( 6,  3),
    new Vector( 10,  3),
    new Vector( 10,  5),
    new Vector( 11,  5),
    new Vector( 11,  10),
    new Vector( 14,  10),
    new Vector( 14,  8),
    new Vector( 17,  8),
    new Vector( 17,  5),
    new Vector( 13,  5),
    new Vector( 13,  0),
    
  };
  Level = new Path(_path);
  
  setUnbuildable(new Vector( 0,  0));
  setUnbuildable(new Vector( 1,  0));
  setUnbuildable(new Vector( 0,  2));
  setUnbuildable(new Vector( 1,  2));
  setUnbuildable(new Vector( 0,  3));
  
  
}

void draw() {
  image(lung, 0, 0, width, playWindowHeight);
  image(path, 0, 0, width, playWindowHeight);
  
  for (int i = 0; i < AllTowers.size(); i++){  // Changed length to size()
    AllTowers.get(i).drawme();  // Changed AllToweers to AllTowers
  }
  
  for (int i = 0; i< AllGerms.size(); i++) AllGerms.get(i).move();
  
  mouseCheck();
}

void mouseCheck(){
  int x = (int)(mouseX/cellSize);
  int y = (int)(mouseY/cellSize);
  
  if(x < Grid.length && y < Grid[0].length){
    hoverCell = Grid[x][y];
    hoverCell.outline();
  }
}

void keyPressed(){
  if (key == 'a') AllGerms.add(new Germ(0)); // Assuming 0 is a valid sprite index
}

 


void mousePressed(){
  if (hoverCell != null){
    println("new Vector( " + hoverCell.x + ",  " + hoverCell.y + "),");
   if(hoverCell.buildable()){
     hoverCell.buildOn(new Tower(hoverCell.x, hoverCell.y, 0));
   }
  }
}




void setUnbuildable(Vector v){
  Grid[v.x][v.y].isPath = true;
  
  
}


void leak(Germ g){
  AllGerms.remove(g);
  println("A germ has leaked");
}

void disappear(Projectile p){
  AllProjectiles.remove(p);
}
