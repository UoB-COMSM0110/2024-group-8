import processing.core.PApplet;
import processing.core.PImage;

public abstract class GameMap extends PApplet {
  
  int WIDTH = 1000;
  int HEIGHT = (int)(WIDTH * 0.8);
  float cellSize = WIDTH / 20; 
  int[][] Grid = new int[20][13];
  
  public String backgroundImage;
  public PImage background;
  
  public GameMap() {
    // Empty constructor
  }
  
  public void settings() {
    size(WIDTH, HEIGHT);
  }
  
  public void setup() {
    background = loadImage(backgroundImage);
    background.resize(WIDTH, HEIGHT);
  }
  
  public abstract void path();
 
  public abstract void twistType();
     
  public abstract void finalBoss();
  
 
}
