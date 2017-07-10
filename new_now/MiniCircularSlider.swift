//
//  MiniCircularSlider.swift
//  new_now
//
//  Created by Mike on 7/9/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import UIKit

struct Conf {
  
  static let SLIDER_SIZE:CGFloat = UIScreen.main.bounds.size.width
  static let SAFEAREA_PADDING:CGFloat = 60.0
  static let LINE_WIDTH:CGFloat = 18.0
  static let FONTSIZE:CGFloat = 40.0
  
}


// MARK: Math Helpers

func DegreeToRad (value:Double) -> Double {
  return value * M_PI / 180.0
}

func RadToDegree (value:Double) -> Double {
  return value * 180.0 / M_PI
}




// MARK: Circular Slider

class MiniCircularSlider: UIControl {
  
  //    var textField:UITextField?
  var radius:CGFloat = 0
  var angle:Int = 66
  var currentHotspot:Int = 66
  var startColor = UIColor.blue
  var endColor = UIColor.purple
  var feedbackGenerator: UINotificationFeedbackGenerator?    // Declare the generator type.
  var selectionGenerator: UISelectionFeedbackGenerator?
  var impactGenerator: UIImpactFeedbackGenerator?
  // Custom initializer
  convenience init(startColor:UIColor, endColor:UIColor, frame:CGRect){
    self.init(frame: frame)
    
    self.startColor = startColor
    self.endColor = endColor
  }
  
  // Default initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = UIColor.clear
    self.isOpaque = true
    
    //Define the circle radius taking into account the safe area
    //        radius = self.frame.size.width/2 - Config.TB_SAFEAREA_PADDING
    let screenWidth = self.frame.size.width
    //radius multiplier needs to be changed.  under 1 probably
    let radiusMultiplier = CGFloat(1)
    let radiusSize = screenWidth * radiusMultiplier
    radius = radiusSize
    feedbackGenerator = UINotificationFeedbackGenerator()  // Instantiate the generator.
    feedbackGenerator?.prepare()
    selectionGenerator = UISelectionFeedbackGenerator()
    selectionGenerator?.prepare()
    impactGenerator = UIImpactFeedbackGenerator(style: .light)
    impactGenerator?.prepare()
    
    
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    
    
    super.beginTracking(touch, with: event)
    return true
  }
  
  
  
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    
    
    
    
    //When this is resized to the bottom of the screen I do not need to check the y position
    super.continueTracking(touch, with: event)
    
    let lastPoint = touch.location(in: self)
    
    self.moveHandle(lastPoint: lastPoint)
    
    self.sendActions(for: UIControlEvents.valueChanged)
    
    return true
    
    
    
  }
  
  
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    super.endTracking(touch, with: event)
  }
  
  
  
  
  //Use the draw rect to draw the Background, the Circle and the Handle
  override func draw(_ rect: CGRect){
    super.draw(rect)
    
    let ctx = UIGraphicsGetCurrentContext()
    
    
    /** Draw the Background  BLACK OUTLINE**/
    
    //    CGContextAddArc(ctx!, CGFloat(self.frame.size.width / 2.0), CGFloat(400.0), radius, 0, CGFloat(M_PI * 2), 0)
    //    UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).set()
    //
    //    let strokeColor = UIColor(red: 174 / 255, green: 179 / 255, blue: 183 / 255, alpha: 0.1)
    let strokeColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
    
    ctx!.setStrokeColor(strokeColor.cgColor)
    ctx!.setLineWidth(1)
    ctx!.setLineCap(CGLineCap.butt)
    
    //Y position for circle center needs to be dynamic. Will have to change after resizing screen.  float will be   much less so it gets to the top of the frame
    //    let circleYPositionMultiplier = CGFloat(1.205)
    
    let circleYPositionMultiplier = CGFloat(1.4)
    let circleYPosition = self.frame.size.height * circleYPositionMultiplier
    let center = CGPoint(x: self.frame.size.width / 2.0, y: circleYPosition)
    //    ctx.setFillColor(UIColor.clear.cgColor)
    
    //
    //    let dashArray:[CGFloat] = [37,6]
    //    ctx!.setLineDash(phase: 3, lengths: dashArray)
    //    let shadowColor = UIColor.black
    //    let shadowWithAlpha = shadowColor.withAlphaComponent(0.25)
    ctx!.setShadow(offset: CGSize(width: 0, height: 4), blur: 10)
    ctx!.addArc(center: center,
                radius: radius,
                startAngle: 0,
                endAngle: CGFloat(M_PI * 2),
                clockwise: true)
    
    
    
    
    ctx!.drawPath(using: .stroke)
    
    
    /** Draw the circle **/
    //I DON'T THINK WE NEED THIS MASK CODE HERE ANYMORE
    /** Create THE MASK Image **/
    UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width, height: self.bounds.size.height));
    let imageCtx = UIGraphicsGetCurrentContext()
    //    CGContextAddArc(imageCtx!, CGFloat(self.frame.size.width/2)  , CGFloat(-80.0), radius, 0, CGFloat(DegreesToRads(value: Double(angle))) , 0);
    //    UIColor.red.set()
    //
    
    imageCtx!.setStrokeColor(UIColor.red.cgColor)
    imageCtx!.setLineWidth(Conf.LINE_WIDTH)
    
    let imageCenter = CGPoint(x: self.frame.size.width, y: self.bounds.size.height)
    //    ctx.setFillColor(UIColor.clear.cgColor)
    imageCtx!.addArc(center: imageCenter,
                     radius: radius,
                     startAngle: 0,
                     endAngle: CGFloat(DegreeToRad(value: Double(angle))),
                     clockwise: true)
    
    //Use shadow to create the Blur effect
    imageCtx!.setShadow(offset: CGSize(width: 0, height: 0), blur: CGFloat(self.angle/15), color: UIColor.blue.cgColor);
    
    //define the path
    imageCtx!.drawPath(using: .stroke)
    
    //save the context content into the image mask
    let mask:CGImage = UIGraphicsGetCurrentContext()!.makeImage()!
    UIGraphicsEndImageContext();
    
    /** Clip Context to the mask **/
    ctx!.saveGState()
    
    
    ctx!.clip(to: self.bounds, mask: mask)
    
    
    //    /** The Gradient **/
    //
    //    // Split colors in components (rgba)
    //    let startColorComps  = startColor.cgColor.components
    //    let endColorComps = endColor.cgColor.components;
    //
    //    let components : [CGFloat] = [
    //      startColorComps![0], startColorComps![1], startColorComps![2], 1.0,     // Start color
    //      endColorComps![0], endColorComps![1], endColorComps![2], 1.0      // End color
    //    ]
    //
    //    // Setup the gradient
    //    let baseSpace = CGColorSpaceCreateDeviceRGB()
    //    let gradient = CGGradient(colorSpace: baseSpace, colorComponents: components, locations: nil, count: 2)
    //
    //    // Gradient direction
    //    let startPoint = CGPoint(x: rect.midX, y: rect.minY)
    //    let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
    //
    // Draw the gradient
    //    ctx!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)));
    ctx!.restoreGState();
    let emptyDashArray:[CGFloat] = []
    /* Draw the handle */
    ctx!.setLineDash(phase: 3, lengths: emptyDashArray);
    drawTheHandle(ctx: ctx!)
    drawHotSpotDots(ctx: ctx!)
  }
  
  
  
  
  func drawTheHandle(ctx:CGContext){
    
    ctx.saveGState();
    
    //shadows
    //    let shadowColor = UIColor.black
    //    let shadowWithAlpha = shadowColor.withAlphaComponent(0.25)
    ctx.setShadow(offset: CGSize(width: 0, height: 14), blur: 14)
    
    
    //Get the handle position
    let handleCenter = pointFromAngle(angleInt: angle)
    
    
    
    
    
    
    //Draw It!
    //    UIColor.white.set();
    let strokeColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.21)
    //    let strokeColor = UIColor(red: 80 / 255, green: 68 / 255, blue: 231 / 255, alpha: 0.5)
    
    ctx.setStrokeColor(strokeColor.cgColor)
    ctx.setLineWidth(8.0)
    
    ctx.strokeEllipse(in: CGRect(x: handleCenter.x, y: handleCenter.y, width: Conf.LINE_WIDTH, height: Conf.LINE_WIDTH));
    
    ctx.restoreGState();
    
    enlargeDot(angle: angle)
  }
  
  func drawHotSpotDots(ctx: CGContext) {
    ctx.saveGState();
    let hotSpots = [66, 73, 79, 86, 93, 99, 105, 112]
    
    
    for spot in hotSpots {
      //Get the handle position
      //      let dotCenter = pointFromAngle(angleInt: spot)
      let dotCenter = pointFromAngleForSpots(angleInt: spot)
      //Draw It!
      
      ctx.setLineWidth(2.0)
      ctx.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
      ctx.setStrokeColor(UIColor.white.cgColor)
      ctx.setFillColor(UIColor.white.cgColor)
      
      ctx.strokeEllipse(in: CGRect(x: dotCenter.x, y: dotCenter.y, width: 3.0, height: 3.0))
      
      
      //      ctx.move(to:CGPoint(x: 0, y: 0))
      //      ctx.addLine(to:CGPoint(x: self.bounds.size.width, y: 0))
      //      ctx.addLine(to:CGPoint(x: 175, y: 100))
      //      ctx.setFillColor(UIColor.blue.cgColor)
      //      ctx.fillPath()
    }
    
    ctx.restoreGState();
    
  }
  
  
  /** Move the Handle **/
  
  func moveHandle(lastPoint:CGPoint){
    
    //Get the center
    
    //    let centerPoint:CGPoint  = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2);
    
    //    let circleYPositionMultiplier = CGFloat(1.205)
    let circleYPositionMultiplier = CGFloat(1.4)
    let circleYPosition = self.frame.size.height * circleYPositionMultiplier
    //Circle center
    let centerPoint = CGPoint(x: 160 - Conf.LINE_WIDTH/2.0, y: circleYPosition - Conf.LINE_WIDTH / 2);
    //Calculate the direction from a center point and a arbitrary position.
    
    let currentAngle:Double = AngleFromNorth(p1: centerPoint, p2: lastPoint, flipped: false);
    let angleInt = Int(floor(currentAngle))
    
    //Store the new angle
    angle = abs(Int(180 - angleInt))
    
    
    //    print("Angle  before set needs display \(angle)")
    //logic before redrawing. check that it crossed X threshold
    //Redraw
    let crossedThresholdReturn = crossedThreshold(angle: angle, lastPoint: lastPoint)
    
    if crossedThresholdReturn.0 == true {
      angle = crossedThresholdReturn.1
      //trigger heptic feedback
      //      self.feedbackGenerator?.notificationOccurred(.error)     // Trigger the haptic feedback.
      print("impact hit")
      //      self.selectionGenerator?.selectionChanged()
      self.impactGenerator?.impactOccurred()
      
      self.setNeedsDisplay()
      //call animation of dot to be enlarged
      enlargeDot(angle: angle)
    }
    
  }
  
  
  func enlargeDot(angle: Int) {
    //clear subviews first
    let subviews = self.subviews
    
    for subview in subviews {
      subview.removeFromSuperview()
    }
    
    
    
    let dotCenter = pointFromAngleForAnimation(angleInt: angle)
    let lineWidth = CGFloat(1)
    let lineHeight = CGFloat(1)
    
    let outerLayer = UIView()
    //CGRect x and y are lower left corner not origin + linewidth / 2
    outerLayer.backgroundColor = UIColor.white
    outerLayer.frame = CGRect(x: dotCenter.x, y: dotCenter.y, width: lineWidth, height: lineHeight)
    outerLayer.layer.cornerRadius = outerLayer.frame.size.height / 2
    outerLayer.clipsToBounds = true
    outerLayer.layer.masksToBounds = true
    
    
    
    
    UIView.animate(withDuration: 0.25, delay: 0,options: UIViewAnimationOptions.curveEaseOut,animations: {
      outerLayer.transform = CGAffineTransform(scaleX: 18, y: 18)
    })
    outerLayer.isUserInteractionEnabled = false
    self.addSubview(outerLayer)
    
    
    //    self.layer.addSublayer(redLayer)
  }
  func crossedThreshold(angle: Int, lastPoint: CGPoint) -> (Bool, Int) {
    //if angle is X different from last point need to change display?
    //just setNeeds display at closes hot spot?
    //need list of hot spots.  Find hotspot with the smallest difference
    //the control for boolean
    //    var last = lastPoint
    let currentAngle = angle
    //initializations
    var newAngle = angle
    //will never be more than 360
    var leastDifference = 360
    //this will need to be dynamic eventually
    let hotSpots = [66, 73, 79, 86, 93, 99, 105, 112]
    
    
    for spot in hotSpots {
      
      let difference = abs(spot - currentAngle)
      
      if difference < leastDifference {
        leastDifference = difference
        newAngle =  spot
      }
    }
    //need to set current hotspot if globally if hotspot is changing
    //may need to be more specific.
    if newAngle != currentHotspot {
      self.currentHotspot = newAngle
      return(true, newAngle)
    } else {
      return (false, currentAngle)
    }
  }
  /** Given the angle, get the point position on circumference **/
  func pointFromAngle(angleInt:Int)->CGPoint{
    //    let circleYPositionMultiplier = CGFloat(1.205)
    let circleYPositionMultiplier = CGFloat(1.4)
    
    let circleYPosition = self.frame.size.height * circleYPositionMultiplier
    //Circle center
    let centerPoint = CGPoint(x: 160 - Conf.LINE_WIDTH/2.0, y: circleYPosition - Conf.LINE_WIDTH / 2);
    
    //The point position on the circumference
    var result:CGPoint = CGPoint.zero
    let y = round(Double(radius) * sin(DegreeToRad(value: Double(-angleInt)))) + Double(centerPoint.y)
    let x = round(Double(radius) * -(cos(DegreeToRad(value: Double(-angleInt))))) + Double(centerPoint.x)
    result.y = CGFloat(y)
    result.x = CGFloat(x)
    
    return result;
  }
  
  /** Given the angle, get the point position on circumference **/
  func pointFromAngleForSpots(angleInt:Int)->CGPoint{
    //    let circleYPositionMultiplier = CGFloat(1.205)
    let circleYPositionMultiplier = CGFloat(1.4)
    
    let circleYPosition = self.frame.size.height * circleYPositionMultiplier
    //Circle center
    let centerPoint = CGPoint(x: 160 - 3 / 2 , y: circleYPosition - 3 / 2);
    
    //The point position on the circumference
    var result:CGPoint = CGPoint.zero
    let y = round(Double(radius) * sin(DegreeToRad(value: Double(-angleInt)))) + Double(centerPoint.y)
    let x = round(Double(radius) * -(cos(DegreeToRad(value: Double(-angleInt))))) + Double(centerPoint.x)
    result.y = CGFloat(y)
    result.x = CGFloat(x)
    
    return result;
  }
  
  /** Given the angle, get the point position on circumference **/
  func pointFromAngleForAnimation(angleInt:Int)->CGPoint{
    //    let circleYPositionMultiplier = CGFloat(1.205)
    let circleYPositionMultiplier = CGFloat(1.4)
    
    let circleYPosition = self.frame.size.height * circleYPositionMultiplier
    //Circle center // 1 is the lineHeight and width of the frame
    let centerPoint = CGPoint(x: 160 - 1 / 2 , y: circleYPosition - 1 / 2);
    
    //The point position on the circumference
    var result:CGPoint = CGPoint.zero
    let y = round(Double(radius) * sin(DegreeToRad(value: Double(-angleInt)))) + Double(centerPoint.y)
    let x = round(Double(radius) * -(cos(DegreeToRad(value: Double(-angleInt))))) + Double(centerPoint.x)
    result.y = CGFloat(y)
    result.x = CGFloat(x)
    
    return result;
  }
  
  
  
  
  //Sourcecode from Apple example clockControl
  //Calculate the direction in degrees from a center point to an arbitrary position.
  func AngleFromNorth(p1:CGPoint , p2:CGPoint , flipped:Bool) -> Double {
    var v:CGPoint  = CGPoint(x: p2.x - p1.x, y: p2.y - p1.y)
    let vmag:CGFloat = Square(value: Square(value: v.x) + Square(value: v.y))
    var result:Double = 0.0
    v.x /= vmag;
    v.y /= vmag;
    let radians = Double(atan2(v.y,v.x))
    result = RadToDegree(value: radians)
    return (result >= 0  ? result : result + 360);
  }
  
}

