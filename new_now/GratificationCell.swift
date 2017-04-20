//
//  GratificationCell.swift
//  new_now
//
//  Created by Mike on 4/20/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import UIKit

class GratificationCell: UICollectionViewCell {
  
  var imageView: UIImageView!
  var cellContainer: UIView!
  var messageLabel: UILabel!
  var keywordButton: UIButton!

  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    //container
    cellContainer = UIView()
    cellContainer.backgroundColor = UIColor.clear
    //image
    imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    //overlay needs to be a gradient

    
    
    messageLabel = UILabel()
    messageLabel.font = UIFont(name: "Avenir-Heavy", size: 18)
    messageLabel.textColor = UIColor.black
    messageLabel.textAlignment = .center
    messageLabel.numberOfLines = 2
    
    
    self.addSubview(imageView)
    self.addSubview(messageLabel)

    
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    
    //making frame for main container holder. whole screen.
    var containerFrame = cellContainer.frame
    containerFrame.size.height = self.frame.size.height
    containerFrame.size.width = self.frame.size.width
    containerFrame.origin.x = 0.0
    containerFrame.origin.y = 0.0
    cellContainer.frame = containerFrame
    
    
    

    
    //making the frame for imageView.  subview of container.  positioned off centered
    
    let imageFrameHeightMultiplier = CGFloat(0.6746)
    let imageFrameWidthMultiplier = CGFloat(0.7626)
    let imageFrameXPositionMultiplier = CGFloat(0.2666)
    let imageFrameYPositionMultiplier = CGFloat(0.1634)
    
    let imageFrameHeight = containerFrame.size.height * imageFrameHeightMultiplier
    let imageFrameWidth = containerFrame.size.width * imageFrameWidthMultiplier
    let imageFrameXPosition = containerFrame.size.width * imageFrameXPositionMultiplier
    let imageFrameYPosition = containerFrame.size.height * imageFrameYPositionMultiplier
    
    
    //need to bring y position up to make perfect square of white space.  3 pixels on a 6
    let yMultiplier = CGFloat(0.00449)
    let yAdjustmentValue = containerFrame.size.height * yMultiplier
    
    var frame = imageView.frame
    frame.size.height = imageFrameHeight
    frame.size.width = imageFrameWidth
    frame.origin.x = imageFrameXPosition
    frame.origin.y = imageFrameYPosition - yAdjustmentValue
    imageView.frame = frame
    

       
    //set origin x

    var messageFrame = messageLabel.frame
    messageFrame.size.width = self.frame.size.width / 2
    messageFrame.size.height = 200
    messageFrame.origin.x = 15
    //align with
    messageFrame.origin.y = self.center.y
    messageLabel.frame = messageFrame
    
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
