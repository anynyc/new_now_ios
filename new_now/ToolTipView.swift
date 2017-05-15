////
////  ToolTip.swift
////  new_now
////
////  Created by Mike on 5/15/17.
////  Copyright © 2017 AnyNYC. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class ToolTipView: UIView {
//  
//  
//  var background: UIView!
//  var dot: UIImageView!
//  var hand: UIImageView!
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    background = UIView()
//    background.backgroundColor = UIColor.darkGray
//    //image
//    dot = UIImageView()
//    dot.contentMode = .scaleToFill
//    
//    hand = UIImageView()
//    hand.contentMode = .scaleToFill
//    
//    self.view.addSubview(background)
//    self.view.addSubview(dot)
//    self.view.addSubview(hand)
//    
//    setupView()
//    //ad gesture recognizer.  any kind of swipe or touch dismisses view controller
//    
//  }
//  
//  
//  //hide
//  override var prefersStatusBarHidden: Bool {
//    return true
//  }
//  
//  func setupView() {
//    //bg, dot set image and position, hand set position
//    
//    var backgroundFrame = background.frame
//    backgroundFrame.size.height = self.frame.size.height
//    backgroundFrame.size.width = self.frame.size.width
//    backgroundFrame.origin.x = 0.0
//    backgroundFrame.origin.y = 0.0
//    backgroundFrame.frame = containerFrame
//    
//    
//
//  }
//  
//  func dismissVC() {
//    //this should probably live on the post view controller.  so add gesture recognizer and action on post view controller
//  }
//  
//  
//  
//}
