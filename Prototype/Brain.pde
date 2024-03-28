
             //////*****I know the new path doesn't look so great, it's just for testing, I will try to find other more interesting path for each map :)*****//////////

class Brain extends GameMap {
    Brain(PImage brain) {
        this.background = brain;
        //this.pathMask = loadImage("route2.png"); 
        
    }

    @Override
    void setup() {
        super.setup(); 

        try {
            pathMask = loadImage("route2.png");  // Load new path mask image
            pathMask.resize(WIDTH, HEIGHT); 
            path.mask(pathMask); 
        } catch (Exception e) {
            println("Error loading image: " + e.getMessage());
        }
    }
    
    @Override                                      //load new vector for new path
    void initalisePath() {
      Vector[] path = new Vector[]{
        new Vector(0, 1),
        new Vector(17,  1),
        new Vector(17,  4),
        new Vector(2,  4),
        new Vector(2,  7),
        new Vector(17,  7),
        new Vector(17,  10),
        new Vector(0,  10),
  
      
    };
    mapPath = new Path(path);
  }
}
