import controlP5.*;
import java.util.Map;

class Square extends Base 
{
  color c;
  //int xPos, yPos;
  int size;
  int stroke;
  int count; //count for color hashmap
  int startingSeed;
  boolean STROKE = false;
  float spacing;
  PVector position;
  
  Square()
  {
    c = color(160, 106, 196);
    //xPos = 1200;
    //yPos = 1000;
    position = new PVector(1200, 1000);
  }//end Square constructor
  
  void Update()
  {
    //int rando = startingSeed;
    int rando = (int)random(0, 5);
    println("Random number: " + rando);
    
      //figure out where to move
      if (rando == 1)
      {
        //move up
        position.y -= size * spacing;
      } else if (rando == 2)
      {
        //move right
        position.x += size * spacing;
      } else if (rando == 3)
      {
        //move down
        position.y += size * spacing;
      } else if (rando == 4)
      {
        //move left
        position.x -= size * spacing;
      }
  }//end Update()

  void Draw()
  {
    //draw a square according to the relevant properties
    if (STROKE == false)
    {
      rectMode(CENTER);
      fill(c);
      noStroke();
      rect(position.x, position.y, size, size);
    } else if (STROKE == true)
    {
      rectMode(CENTER);
      fill(c);
      stroke(stroke);
      rect(position.x, position.y, size, size);
    }
  }//end Draw()
  
  
  void checkHash()
  {
    for(PVector position : sqHash.keySet())
    {
      if(sqHash.get(position) < 4) 
      {
        c = color(160, 126, 84);
      }
      else if(sqHash.get(position) < 7)
      {
        c = color(143, 170, 64); 
      }
      else if(sqHash.get(position) < 10)
      {
        c = color(134, 134, 134); 
      }
      else
      {
        if(c > color(255))
          {
           c = color(255);
          }
          c = color(count * 20); 
        }//end else
      }//end for loop 
      
  }//end checkHash
  
  
}//end Square class