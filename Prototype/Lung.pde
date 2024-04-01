class Lung extends GameMap {
    Lung(PImage lung) {
        this.background = lung;
        
    }

    @Override
    void setup() {
        super.setup(); 
        
        try {
            path = loadImage("routeLung.png"); 
            path.resize(WIDTH, HEIGHT); 
        } catch (Exception e) {
            println("Error loading image: " + e.getMessage());
        }
    }
    
    //@Override
    //void draw(){
    //  super.draw();
    //  try { // Please add implementation of map animation within this if statement to avoid null pointer exception after game is won/lost:)
        
       
    //  } catch (Exception e) { System.out.println("Game is already won/lost"); }
      
    //}
    
    @Override                                      //load new vector for new path
    void initalisePath() {
      Vector[] path = new Vector[]{
        new Vector(0,  5),
        new Vector(3,  5),
        new Vector(3,  8),
        new Vector(1,  8),
        new Vector(1,  11),
        new Vector(9,  11),
        new Vector(9,  8),
        new Vector(6,  8),
        new Vector(6,  3),
        new Vector(10,  3),
        new Vector(10,  5),
        new Vector(11,  5),
        new Vector(11,  10),
        new Vector(14,  10),
        new Vector(14,  8),
        new Vector(17,  8),
        new Vector(17,  5),
        new Vector(13,  5),
        new Vector(13,  0),  
  
      
    };
    mapPath = new Path(path);
  }
}
