/*************************************************************************************************
 * Assignment 1 COSC101 - A scaled generative artwork
 * Daniel Noble 2022
 *
 * This program uses the draw loop to incrementally draw a simple "Wave Clock" inspired graphic.
 * The Scale effect provides an illusion of the wave clock receding into infinity.
 *
 * This pattern is created by repeated drawing lines outwards at different angles 
 * (incremented at 0.25 degrees) from the centre of continuous scaled circles.
 * Typically the scale() function is used to increase or decrease the size/shape of an object.
 * Here, each line is drawn from the centre of a random circle scaled between 0% and 100%. 
 *
 * Each lines colour is updated to a different shade in each iteration (RGBA +/- 10) 
 * The length of each line is updated (+/- 0.2), giving each line a unique shape.
 * As the program progresses, the start length of each line before noise is reduced (0.06 units)
 * Each iteration produces a layered effect as coloured lines grow and retreat in a cycle.
 * Alpha is initialised to 400, creating an initial anti-opacity bias.
 * Colour is initialised to purple as a result of testing and colour harmonics research.
 *
 *To run the program: download and install processing from https://processing.org/download
 *Open this .pde file in processing and click "Run"
 **************************************************************************************************/

// Global varibles & functions used in the draw loop

float radius;     //Length of the current line
float radius_ini; //Length of the initial line, used in radius looping to avoid hard-coding
int centX;        //Center X Coordinate
int centY;        //Center X Coordinate
float x;          //Current line end x coodinate
float y;          //Current line end y coodinate
float radiusNoise;//The random noise value added to the line
float ang_value;  //Current angle of the line to draw
int rgbArray[] = {92, 64, 156, 400}; // List of RGBA channels: (Red, Green, Blue, Alpha)

//Inputs a float (x), returns a random float between its negative and positive values (-x : x)
float random_range(float x)
{
  return random(-x, x);
}

/*************************************************************************************************
 * Setup() - Initialise all required values for our program.
 *************************************************************************************************/

void setup()
{
  frameRate(90);
  size(1000, 1000);
  background(10);
  radius = 300;
  radius_ini = radius;
  centX = 500;
  centY = 500;
  ang_value = 0;
}


/*************************************************************************************************
 * draw() - Iteratively render the artwork.
 *************************************************************************************************/
void draw()
{
  smooth();
  ang_value += 0.25;
  radiusNoise += random_range(0.2);
  
  // Loops radius/line length through 300px to -300px creating a large-small-large cycle.
  if (radius > -radius_ini)
  {
    radius -= 0.06;
  } else {
    radius = radius_ini;
  }

  // Creates unique colour pattern, each RGBA value is randomly changed between -10 and 10.
  for (int i = 0; i < (rgbArray.length); i++) //Array.length used to avoid hardcoding
  {
    rgbArray[i] += int(random_range(10));
  }

  // Calculates the radius (line length) of the circle including noise, line angle and origin.
  float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
  float rad = radians(ang_value);
  x = centX + (thisRadius * cos(rad));
  y = centY + (thisRadius * sin(rad));

  //Outputs lines from: Scale of the circle, line thickness, RGBA, origin, and destination.
  scale(random(0,1)); //Decreases the size of the circle a random amount for each line.
  strokeWeight(4);    //Thickness of stroke
  stroke(rgbArray[0], rgbArray[1], rgbArray[2], rgbArray[3]); // RGBA colour
  line(centX, centY, x, y); //Origin and destination of line
}
