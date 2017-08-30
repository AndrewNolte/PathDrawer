
public class BezierCurve implements Drawable{
  MovablePoint v0,v1,v2,v3;
  int SEGMENT_COUNT = 20; //number of segments to use when calculating length of curve
  double distBetween = 20;
  
  public BezierCurve(MovablePoint a, MovablePoint b, MovablePoint c, MovablePoint d){
    this.v0 = a;
    this.v1 = b;
    this.v2 = c;
    this.v3 = d;
    stack.add(this);
    paint();
  }
  
  public void update(){
    if(v0.isMoving || v1.isMoving || v2.isMoving || v3.isMoving){
      //askForRepaint();
      //not needed because the points themselves request a repaint
    }
  }
  
  public void paint(){
    noFill();
    bezier(v0.x,v0.y,v1.x,v1.y,v2.x,v2.y,v3.x,v3.y);
    for(PVector p : points()){
      fill(#187E17);
      noStroke();
      ellipse(p.x,p.y,2,2);
    }
  }
  
  public void remove(){
    stack.remove(this);
    stack.remove(v0);
    stack.remove(v1);
    stack.remove(v2);
    stack.remove(v3);
  }

  // Returns an array of points on the curve.
  PVector[] points() {
    int howMany = (int) (arcLength()/distBetween);
    PVector[] resultPoints = new PVector[howMany];
    
    // we already know the first and the last point of the curve
    resultPoints[0] = v0.get();
    resultPoints[howMany - 1] = v3.get();
    
    for (int i = 1; i < howMany - 1; i++) {
      
      // map index to parameter in range (0.0, 1.0)
      float parameter = (float) i / (howMany - 1);
      
      resultPoints[i] = pointAtParameter(parameter);
    }
    
    return resultPoints;
  }
  
  PVector pointAtParameter(float t) {
    PVector result = new PVector();
    result.x = bezierPoint(v0.x, v1.x, v2.x, v3.x, t);
    result.y = bezierPoint(v0.y, v1.y, v2.y, v3.y, t);
    result.z = bezierPoint(v0.z, v1.z, v2.z, v3.z, t);
    return result;
  }
  private float arcLengths[] = new float[SEGMENT_COUNT + 1]; // there are n segments between n+1 points

  private float arcLength(){
    float arcLength = 0;
    
    PVector prev = new PVector();
    prev.set(v0);
    
    // i goes from 0 to SEGMENT_COUNT
    for (int i = 0; i <= SEGMENT_COUNT; i++) {
      
      // map index from range (0, SEGMENT_COUNT) to parameter in range (0.0, 1.0)
      float t = (float) i / SEGMENT_COUNT;
      
      // get point on the curve at this parameter value
      PVector point = pointAtParameter(t);
      
      // get distance from previous point
      float distanceFromPrev = PVector.dist(prev, point);
      
      // add arc length of last segment to total length
      arcLength += distanceFromPrev;
      
      // save current arc length to the look up table
      arcLengths[i] = arcLength;
      
      // keep this point to compute length of next segment
      prev.set(point);
    }
    return arcLength;
  }
  
 
  @Override
  public String toString(){
    String ans = "[";
    for(PVector p : points()){
      if(ans.length() > 2) ans += ", ";
      ans += String.format("new Location(%.1f,%.1f)", (p.x - originX)/pixelsPerInch, -1 *(p.y - originY)/pixelsPerInch);
    }
    return ans + "]";
  }
}