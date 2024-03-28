import processing.core.*;

public class MapSelection extends Display {
    PImage startPageBackground;
    int imageSize = 200; // Define imageSize here

    MapSelection(Runner runner) {
        super(runner);
    }

    public void setup() {
        startPageBackground = runner.loadImage("data/startpage.png");
        startPageBackground.resize(runner.WIDTH, runner.HEIGHT); // Resize the image to match window dimensions

        // Load and resize organ images
        runner.brain = runner.loadImage("data/brain.png");
        runner.brain.resize(imageSize, imageSize);

        runner.lung = runner.loadImage("data/lung.png");
        runner.lung.resize(imageSize, imageSize);

        runner.heart = runner.loadImage("data/heart.png");
        runner.heart.resize(imageSize, imageSize);

        runner.kidney = runner.loadImage("data/kidney.png");
        runner.kidney.resize(imageSize, imageSize);

        runner.backButton = runner.loadImage("data/backButton.png");

        //backButton.resize(imageSize/3, imageSize/3);

    }

    public void draw() {
        runner.background(startPageBackground);
        runner.image(runner.germ, runner.germX, runner.germY);

        runner.textSize(40);
        runner.fill(255);
        runner.text("Choose which organ to defend:", (float) runner.WIDTH / 5, (float) runner.HEIGHT / 4 - 25);

        int outlineSize = imageSize + 20;

        runner.strokeWeight(8); // Format for squares outlining the map images
        runner.strokeJoin(runner.ROUND);
        runner.stroke(255);
        runner.noFill();

        // Display map images and make them pressable buttons
        handleMapSelection(runner.brain, runner.WIDTH / 6, runner.HEIGHT / 5 + 50, outlineSize, GameState.BRAIN);
        handleMapSelection(runner.lung, runner.WIDTH / 3 + 250, runner.HEIGHT / 5 + 50, outlineSize, GameState.LUNG);
        handleMapSelection(runner.heart, runner.WIDTH / 6, runner.HEIGHT / 5 + 350, outlineSize, GameState.HEART);
        handleMapSelection(runner.kidney, runner.WIDTH / 3 + 250, runner.HEIGHT / 5 + 350, outlineSize, GameState.KIDNEY);

        BackButton(runner.backButton, runner.WIDTH / 50, runner.HEIGHT / 50, 100, GameState.TITLE);
    }


    // Handle map selection and animate the selected map
    public void handleMapSelection(PImage mapImage, int x, int y, int outlineSize, GameState state) {
        // Check if runner.mouse is over the map image
        if (runner.mouseX >= x - 10 && runner.mouseX <= x + outlineSize &&
                runner.mouseY >= y - 10 && runner.mouseY <= y + outlineSize) {
            runner.image(mapImage, x - 5, y - 5, outlineSize + 10, outlineSize + 10); // Scale up slightly
            if (runner.mousePressed) {
                runner.currentGameState = state; // Change game state if the map is clicked
            }
        } else {
            runner.image(mapImage, x + 5, y + 5, imageSize, imageSize); // Normal size if not hovered
        }
        //rect(x - 10, y - 10, outlineSize, outlineSize); // Draw outline
    }

    public void BackButton(PImage mapImage, int x, int y, int outlineSize, GameState state) {
        // Check if runner.mouse is over the map image
        if (runner.mouseX >= x - 10 && runner.mouseX <= x + 70 &&
                runner.mouseY >= y - 10 && runner.mouseY <= y + 70) {
            runner.image(mapImage, x - 20, y - 20, 110, 110); // Scale up slightly
            if (runner.mousePressed) {
                runner.currentGameState = state; // Change game state if the map is clicked
            }
        } else {
            runner.image(mapImage, x, y, 70, 70); // Normal size if not hovered
        }
    }
}
