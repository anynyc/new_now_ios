////
////  ToolTip.swift
////  new_now
////
////  Created by Mike on 5/15/17.
////  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

class ToolTipView: UIView {
  
  
  var background: UIView!
  var dot: UIImageView!
  var hand: UIImageView!
  


  override init(frame: CGRect) {
    super.init(frame: frame)


//    addBehavior()
  }
  
//  convenience init() {
//    self.init(frame: CGRect.zero)
//  }
//  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  func addBehavior() {
    print("Add all the behavior here")
  }



  func setupView(superView: UIView) {
    //bg, dot set image and position, hand set position
    self.frame = superView.frame
    background = UIView()
    background.backgroundColor = UIColor.black
    background.alpha = 0.8
    //image
    dot = UIImageView()
    dot.contentMode = .scaleToFill
    
    hand = UIImageView()
    hand.contentMode = .scaleToFill
    
    self.addSubview(background)
    self.addSubview(dot)
    self.addSubview(hand)
    
    var backgroundFrame = background.frame
    backgroundFrame.size.height = self.frame.size.height
    backgroundFrame.size.width = self.frame.size.width
    backgroundFrame.origin.x = 0.0
    backgroundFrame.origin.y = 0.0
    background.frame = backgroundFrame
    
    var handFrame = hand.frame

    if UIScreen.main.bounds.size.width == 414 {
      //plus
      handFrame.size.height = 39
      handFrame.size.width = 40
      handFrame.origin.x = 20.0
      handFrame.origin.y = 595.0
    } else if UIScreen.main.bounds.size.width == 375 {
      //6 and 7
      handFrame.size.height = 39
      handFrame.size.width = 40
      handFrame.origin.x = 20.0
      handFrame.origin.y = 575.0
      
    } else {
      //5
      handFrame.size.height = 39
      handFrame.size.width = 40
      handFrame.origin.x = 20.0
      handFrame.origin.y = 500.0
      
    }
    

    hand.frame = handFrame
    
    hand.image = UIImage(named: "handSwipe")

  }


  
  func drawSlider() {
    let TB_SLIDER_SIZE:CGFloat = UIScreen.main.bounds.size.width
    let TB_SAFEAREA_PADDING:CGFloat = 60.0
    let TB_LINE_WIDTH:CGFloat = 20.0
    let TB_FONTSIZE:CGFloat = 40.0
    let screenWidth = self.frame.size.width
    let screenHeight = self.frame.size.height
    var angle:Int = 67

    let ctx = UIGraphicsGetCurrentContext()
    
    let radiusMultiplier = CGFloat(1.0666)
    let radius = screenWidth * radiusMultiplier
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
    //    CGContextAddArc(imageCtx!, CGFloat(self.frame.size.width/2)  , CGFloat(-80.0), radius, 0, CGFloat(DegreesToRadians(value: Double(angle))) , 0);
    //    UIColor.red.set()
    //
    
    imageCtx!.setStrokeColor(UIColor.red.cgColor)
    imageCtx!.setLineWidth(Config.TB_LINE_WIDTH)
    
    let imageCenter = CGPoint(x: self.frame.size.width, y: self.bounds.size.height)
    //    ctx.setFillColor(UIColor.clear.cgColor)
    imageCtx!.addArc(center: imageCenter,
                     radius: radius,
                     startAngle: 0,
                     endAngle: CGFloat(DegreesToRadians(value: Double(angle))),
                     clockwise: true)
    
    //Use shadow to create the Blur effect
    imageCtx!.setShadow(offset: CGSize(width: 0, height: 0), blur: CGFloat(angle/15), color: UIColor.blue.cgColor);
    
    //define the path
    imageCtx!.drawPath(using: .stroke)
    
    //save the context content into the image mask
    let mask:CGImage = UIGraphicsGetCurrentContext()!.makeImage()!
    UIGraphicsEndImageContext();
    
    /** Clip Context to the mask **/
    ctx!.saveGState()
    
    
    ctx!.clip(to: self.bounds, mask: mask)
    
    

    ctx!.restoreGState();
    
  }
  
  func animateHand() {
    UIView.animate(withDuration: 0.6, delay: 0, options: [.repeat, .autoreverse], animations: {
      
      self.hand.frame.origin.x = 60
      
    }, completion: nil)
  }
  
  
  
}
