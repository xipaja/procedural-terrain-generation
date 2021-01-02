//Ximena Jaramillo
//Project 2
//CAP3027

import controlP5.*;
import java.util.Map;

ControlP5 cp5;
ControlP5 startButton;
DropdownList dropdown;
Slider maxStepSlider, stepRateSlider, stepSizeSlider, stepScaleSlider;
Textlabel maxStepText, stepRateText, stepSizeText, stepScaleText;
Toggle tog1, tog2, tog3, tog4;
Textfield seedVal;
int seedValInput;
//int startingSeed;

boolean start = false;
boolean dropped = false;
boolean toggled = false;

Square sq;
HashMap<PVector, Integer> sqHash = new HashMap<PVector, Integer>();

Hexagon hex;
HashMap<PVector, Integer> hexHash = new HashMap<PVector, Integer>();


void setup()
{
  size(2400, 2000);
  cp5 = new ControlP5(this);
  startButton = new ControlP5(this);
  sq = new Square();
  hex = new Hexagon();
  
  background(49, 140, 210); 
  //UI rectangle
  fill(99, 101, 98);
  rect(0, 0, 400, 2000);
  
  //create start button
  startButton.addButton("START")
             .setValue(0)
             .setPosition(20, 20)
             .setSize(150, 60)
             ;
             
  //create dropdown list
  dropdown = cp5.addDropdownList("SQUARES")
                .setPosition(20, 100)
                .setSize(250, 200)
                .addItem("SQUARES", 0)
                .addItem("HEXAGONS", 1)
                ;

  //customize dropdown list size
  customizeDropdown(dropdown);
  
  //create slider
  maxStepSlider = cp5.addSlider(".")
                    .setPosition(20, 300)
                    .setRange(100, 50000)
                    .setSize(300, 40)
                    .setCaptionLabel("");
                    ;
          
   maxStepSlider.getCaptionLabel();
    
  //"Maximum Steps" text above slider                    
  maxStepText = cp5.addTextlabel("Max steps text")
                   .setText("Maximum Steps")
                   .setPosition(20, 290)
                   .setColorValue(255)
                   ;
             
  stepRateSlider = cp5.addSlider(",")
                     .setPosition(20, 360)
                     .setRange(1, 1000)
                     .setSize(300, 40)
                     .setCaptionLabel("");
                     ;
  
  //"Step Rate" text above slider
  stepRateText = cp5.addTextlabel("Max steps")
                    .setText("Step Rate")
                    .setPosition(20, 350)
                    .setColorValue(255)
                    ;      
  
  stepSizeSlider = cp5.addSlider("..")
                      .setPosition(20, 475)
                      .setRange(10, 30)
                      .setSize(300, 40)
                      .setCaptionLabel("");
                      ;
                            
  stepSizeText = cp5.addTextlabel("Step size")
                    .setText("Step Size")
                    .setPosition(20, 465)
                    .setColorValue(255)
                    ;                   
    
  stepScaleSlider = cp5.addSlider(",,")
                    .setPosition(20, 535)
                    .setRange(1.0, 1.5)
                    .setSize(300, 40)
                    .setCaptionLabel("");
                    ;
                            
  stepScaleText = cp5.addTextlabel("Step scale")
                     .setText("Step Scale")
                     .setPosition(20, 525)
                     .setColorValue(255)
                     ;                  
  
  
  //whether or not the walking process should remain bound to the viewable area or not
  tog1 = cp5.addToggle("Constrain Steps")
            .setPosition(20, 595)
            .setSize(40, 40)
            ;
     
  //if the drawing process should color the steps to give a rough approx of terrain elevation
  tog2 = cp5.addToggle("Simulate Terrain")
            .setPosition(20, 655)
            .setSize(40, 40)
            ;
     
  //whether or not shapes shapes should be drawn with a stroke outline
  tog3 = cp5.addToggle("Use Stroke")
            .setPosition(20, 715)
            .setSize(40, 40)
            ;
     
  //whether a specific value should be used to seed the random num generator or not
  tog4 = cp5.addToggle("Use Random Seed")
            .setPosition(20, 775)
            .setSize(40, 40)
            ;
            
  seedVal = cp5.addTextfield("Seed Value")
               .setPosition(140, 775)
               .setSize(90, 40)
               ;
}//end setup

void customizeDropdown(DropdownList droppy)
{
   droppy.setItemHeight(50);
   droppy.setBarHeight(50);
}

//DRAW***********************************************************************
void draw()
{
    if(int(dropdown.getValue()) == 0)
    {
        doSquareStuff();
    }
    else if(int(dropdown.getValue()) == 1)
    {
        doHexStuff();
    }
}//end draw
//DRAW***********************************************************************
 

//CONTROL EVENT**************************************************************
public void controlEvent(ControlEvent theEvent)
{  
  //check if group to avoid errors from cp5
  if(theEvent.isGroup())
  {
     println("Event from group: " + theEvent.getGroup().getValue() + " from " + theEvent.getGroup()); 
  }
  else if(theEvent.isController())
  {
      println(theEvent.getController().getName());
  }
}//end controlEvent
//CONTROL EVENT**************************************************************

//START BUTTON***************************************************************
public void START(int theValue)
{
  println("START CONTROLLER" + theValue);
  
  if(!start)
  {
    start = true;
    startButton.setColorBackground(color(3, 44, 88));
  }
  else
  {
    start = false;
  }
  background(49, 140, 210); 
  //UI rectangle
  fill(99, 101, 98);
  rectMode(CORNERS);
  rect(0, 0, 400, 2000);
}//end START
//START BUTTON****************************************************************

void doSquareStuff()
{
 if(!start)
 {
   int steps = (int)stepRateSlider.getValue();
   int maxSteps = (int)maxStepSlider.getValue();
   
   for (int i = 0; i < steps; i++)
   {
     for (int j = 0; j < maxSteps; j++)
      {
          startButton.setColorBackground(color(0,152,0));
          sq.size = (int)stepSizeSlider.getValue();
          sq.spacing = stepScaleSlider.getValue();
          
          if(sqHash.containsKey(sq.position))
          {
              sqHash.put(sq.position, sqHash.get(sq.position) + 1);
              println("HASH: " + sqHash.get(sq.position));
              if(tog2.getState() == true)
                {
                  //if terrain toggle is on, do hashmap coloring
                  sq.checkHash();
                }
          }
          else
          {
              sqHash.put(sq.position, 1); 
              if(tog2.getState() == true)
                {
                  //if terrain toggle is on, do hashmap coloring
                  sq.checkHash();
                }
          }
          
          //constrain to viewing window
          if(tog1.getState() == true)
          {
             if(sq.position.x <= 400 + (int)sq.size/2)
             {
               //if square goes into ui rect
               sq.position.x += sq.size * 4;
             }
             else if(sq.position.x >= (2400 - (int)sq.size/2))
             {
               //if square goes outside right of window
               sq.position.x -= sq.size * 4;
             }
             else if(sq.position.y <= 0 + sq.size/2)
             {
               //if square goes outside top of window
               sq.position.y += sq.size * 4;
             }
             else if(sq.position.y >= 2000 - (int)sq.size/2)
             {
               //if square goes outside bottom of window
               sq.position.y -= sq.size * 4;
             }
          }
          if(tog3.getState() == true)
          {
           //draw stroke
           sq.STROKE = true;
           sq.stroke = 0; 
          }
          else if(tog3.getState() == false)
          {
           //no stroke
           sq.STROKE = false;
           sq.Draw();
           sq.Update();
          }
          if(tog4.getState() == false)
          {
           //limit input to ints
            seedVal.setInputFilter(ControlP5.INTEGER); 
            
            //retrieve data stored in textfield
           sq.startingSeed = int(seedVal.getText());
           println("SEED VAL: " + seedValInput);
         }
          else if(tog4.getState() == true)
          {
            sq.Update();
          }
          sq.Draw();
          sq.Update();
          println(stepSizeSlider.getValue());
          println(sq.size); 
       }//end inner for loop - steps
   }//end outer for loop - max steps
 }//end if(!start) 
}//end doSquareStuff

void doHexStuff()
{
  if(!start)
 {
   int steps = (int)stepRateSlider.getValue();
   int maxSteps = (int)maxStepSlider.getValue();
   
   for (int i = 0; i < steps; i++)
   {
     for (int j = 0; j < maxSteps; j++)
      {
          startButton.setColorBackground(color(0,152,0));
          hex.radius = (int)stepSizeSlider.getValue();
          hex.hSpacing = stepScaleSlider.getValue();
          
          if(hexHash.containsKey(hex.hPosition))
          {
              hexHash.put(hex.hPosition, hexHash.get(hex.hPosition) + 1);
              println("HEX HASH: " + hexHash.get(hex.hPosition));
              if(tog2.getState() == true)
                {
                  //if terrain toggle is on, do hashmap coloring
                  hex.hexCheckHash();
                }
          }
          else
          {
              hexHash.put(hex.hPosition, 1); 
              if(tog2.getState() == true)
                {
                  //if terrain toggle is on, do hashmap coloring
                  hex.hexCheckHash();
                }
          }
                  
          if(tog1.getState() == true)
          {
             if(hex.hPosition.x <= 400 + (int)hex.radius)
             {
               //if hex goes into ui rect
               hex.hPosition.x += hex.radius * 4;
             }
             else if(hex.hPosition.x >= (2400 - (int)hex.radius))
             {
               //if hex goes outside right of window
               hex.hPosition.x -= hex.radius * 4;
             }
             else if(hex.hPosition.y <= 0 + hex.radius)
             {
               //if hex goes outside top of window
               hex.hPosition.y += hex.radius * 4;
             }
             else if(hex.hPosition.y >= 2000 - (int)hex.radius)
             {
               //if hex goes outside bottom of window
               hex.hPosition.y -= hex.radius * 4;
             }
          }
          if(tog3.getState() == true)
          {
           //draw stroke
           hex.hSTROKE = true;
           hex.hStroke = 0; 
          }
          else if(tog3.getState() == false)
          {
           //no stroke
           hex.hSTROKE = false;
           hex.hDraw();
           hex.hUpdate();
          }
          if(tog4.getState() == false)
          {
           //input seed value, make that starting point aka make that rando?
           //limit input to ints
            seedVal.setInputFilter(ControlP5.INTEGER); 
            
            //retrieve data stored in textfield
          //hex.startingSeed = seedValInput = int(seedVal.getText());
           println("SEED VAL: " + seedValInput);
          }
          else if(tog4.getState() == true)
          {
             //sq.Update();
             hex.hDraw();
          }
          hex.hDraw();
          hex.hUpdate();
          println(stepSizeSlider.getValue());
          println(sq.size); 
       }//end inner for loop - steps
   }//end outer for loop - max steps
 }//end if(!start) 
 
}//end doHexStuff