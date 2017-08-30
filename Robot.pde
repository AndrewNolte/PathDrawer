
public class Robot extends MovablePoint{
  public static final float l = 31;
  public static final float w = 37;
  
  public Robot(float x, float y){
    super(x,y);
    
  }
  @Override
  public void update(){
      if(isMoving){
      y = mouseY;
      askForRepaint();
    }
  }
  
  @Override
  public void paint(){
     noFill();
     strokeWeight(3);
     stroke(#C60700);
     rectMode(CENTER);
     rect(x,y,l*pixelsPerInch,w*pixelsPerInch); 
     line(x-5, y, x+10, y);
     line(x,y-5,x,y+5);
     rectMode(CORNER);
    
  }
  
}