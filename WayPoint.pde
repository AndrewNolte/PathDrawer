public class WayPoint extends PVector implements Drawable{
  
  float inchesX, inchesY;
  
  public WayPoint(float x, float y){
    super(x,y);
    inchesX = (x - originX)/pixelsPerInch;
    inchesY = -1 *(y - originY)/pixelsPerInch;
  }
  
  @Override
  public String toString(){
    return String.format("new Location(%.1f,%.1f)", inchesX, inchesY);
  }
  
  public void update(){
    
  }
  @Override
  public void paint(){
    fill(0);
    stroke(0);
    ellipse(x,y,4,4);
    
  }
}