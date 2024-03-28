import processing.core.*;

public class Kidney extends GameMap {
    Kidney(PImage kidney, Runner runner) {
        super(runner);
        this.background = kidney;
    }

    @Override
    public void setup() {
        super.setup();

        try {
            pathMask = runner.loadImage("data/route.png");  // Load new path mask image
            pathMask.resize(runner.WIDTH, runner.HEIGHT);
            path.mask(pathMask);
        } catch (Exception e) {
           System.out.println("Error loading image Kidney: " + e.getMessage());
        }
    }

    @Override                                      //load new vector for new path
    public void initialisePath() {
        Vector[] path = new Vector[]{
                new Vector(0, 5),
                new Vector(3, 5),
                new Vector(3, 8),
                new Vector(1, 8),
                new Vector(1, 11),
                new Vector(9, 11),
                new Vector(9, 8),
                new Vector(6, 8),
                new Vector(6, 3),
                new Vector(10, 3),
                new Vector(10, 5),
                new Vector(11, 5),
                new Vector(11, 10),
                new Vector(14, 10),
                new Vector(14, 8),
                new Vector(17, 8),
                new Vector(17, 5),
                new Vector(13, 5),
                new Vector(13, 0),


        };
        runner.mapPath = new Path(path, runner);
    }
}
