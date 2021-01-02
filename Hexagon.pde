import controlP5.*;
import java.util.Map;

class Hexagon extends Base
{
  color hC;
  int radius;
  int hStroke;
  int hCount; //count for color hashmap
  int hStartingSeed;
  boolean hSTROKE = false;
  float hSpacing;
  PVector hPosition;
  
  Hexagon()
  {
    hC = color(160, 106, 196);
    hPosition = new PVector(1200, 1000);
  }//end hexagon constructor
  
  void hUpdate()
  {
    
    int rando = (int)random(0, 7);
    println("Random number: " + rando);
    
      //figure out where to move
      if (rando == 1)
      { 
        hPosition.x += 2 * radius * hSpacing;
        hPosition.y += radius * sqrt(3) * hSpacing;
      } else if (rando == 2)
      {
       hPosition.y += 2 * radius * sqrt(3) * hSpacing;
      } else if (rando == 3)
      {
       hPosition.x -= 2 * radius * hSpacing;
       hPosition.y += radius * sqrt(3) * hSpacing;
      } else if (rando == 4)
      {
        hPosition.x -= 2 * radius * hSpacing;
        hPosition.y -= radius * sqrt(3) * hSpacing;
      }
      else if(rando == 5)
      {
        hPosition.y -= 2 * radius * sqrt(3) * hSpacing;
      }
      else if(rando == 6)
      {       
        hPosition.x += 2 * radius * hSpacing;
        hPosition.y -= radius * sqrt(3) * hSpacing;
      }
  }//end Update()
  void hDraw()
  {
    
    if (hSTROKE == false)
    {
      fill(hC);
      noStroke();
      drawHexShape(hPosition.x,hPosition.y, radius, 6);
    } else if (hSTROKE == true)
    {
      
      fill(hC);
      stroke(hStroke);
      drawHexShape(hPosition.x,hPosition.y, radius, 6);
    }
  }//end hDraw()
  
  
  void drawHexShape(float x, float y, int radius, float npts)
  {
    float angle = TWO_PI/npts;
    beginShape();
    for(float ang = 0; ang < TWO_PI; ang += angle)
    {
     float sx = x + cos(ang) * radius;
     float sy = y + sin(ang) * radius;
     vertex(sx, sy);
    }
    endShape(CLOSE);
  }

void hexCheckHash()
  {
    for(PVector position : hexHash.keySet())
    {
      if(hexHash.get(position) < 4) 
      {
        hC = color(160, 126, 84);
      }
      else if(hexHash.get(position) < 7)
      {
        hC = color(143, 170, 64); 
      }
      else if(hexHash.get(position) < 10)
      {
        hC = color(134, 134, 134); 
      }
      else
      {
        if(hC > 255)
          {
           hC = 255;
          }
          hC = color(hCount * 20); 
        }//end else
      }//end for loop   
  }//end hexCheckHash
  
}//end class Hexagon