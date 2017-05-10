//
//  ImageCell.swift
//  new_now
//
//  Created by Mike on 3/27/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
  
  var imageView: UIImageView!
  var grayOverlay: UIView!
  var cellContainer: UIView!
  var topicLabel: UILabel!
  var bodyLabel: NRLabel!
  var gl: CAGradientLayer!
  var articleUrl: String!
  var bodyLabelContainer: UIView!
  var preBodyBackground: UIView!
  
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    //container
    cellContainer = UIView()
    cellContainer.backgroundColor = UIColor.clear
    //image
    imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.isUserInteractionEnabled = false
    //overlay needs to be a gradient
    grayOverlay = UIView()
//    grayOverlay.backgroundColor = UIColor(white: 1, alpha: 0.5)
    grayOverlay.backgroundColor = UIColor.clear
    self.isHidden = true
    
    
    topicLabel = UILabel()
//    topicLabel.numberOfLines = 0
//    topicLabel.lineBreakMode = .byCharWrapping
    topicLabel.font = UIFont(name: "Avenir-Heavy", size: 9)
    topicLabel.textColor = UIColor.lightGray
    topicLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
    topicLabel.textAlignment = .left
//    contentView.addSubview(imageView)

    bodyLabel = NRLabel()
    bodyLabel.numberOfLines = 5
    bodyLabel.font = bodyLabel.font.withSize(36)
    bodyLabel.font = UIFont(name: "Miller-Display", size: 36)
    bodyLabel.textColor = UIColor(red: 25.0 / 255, green: 26.0 / 255, blue: 36.0 / 255, alpha: 1.0)
    
    //view holding the body label.  will constrain bodylabel to bottom of this view.
    bodyLabelContainer = UIView()
    preBodyBackground = UIView()
    
    contentView.addSubview(cellContainer)
    cellContainer.addSubview(imageView)
    cellContainer.addSubview(grayOverlay)
    cellContainer.addSubview(topicLabel)
    cellContainer.addSubview(preBodyBackground)
    cellContainer.addSubview(bodyLabelContainer)
    bodyLabelContainer.addSubview(bodyLabel)
    
    self.contentView.updateConstraints()
    self.updateConstraints()
    self.layoutIfNeeded()
    self.contentView.layoutIfNeeded()
    
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
    
    
    //Set up origin x and y programmatically
//    let bodyOriginXMultiplier = CGFloat(0.16)
    let bodyOriginXMultiplier = CGFloat(0.106666)
    let bodyOriginYMultiplier = CGFloat(0.344)
    let bodyWidthMultiplier = CGFloat(0.84)
    let bodyXPosition = containerFrame.size.width * bodyOriginXMultiplier
    let bodyYPosition = containerFrame.size.height * bodyOriginYMultiplier
    let bodyWidth = containerFrame.size.width * bodyWidthMultiplier
    
    
    var bodyLabelContainerFrame = bodyLabelContainer.frame
    bodyLabelContainerFrame.size.height = self.frame.size.height / 2
    bodyLabelContainerFrame.size.width = bodyWidth
    bodyLabelContainerFrame.origin.x = bodyXPosition
    bodyLabelContainerFrame.origin.y = bodyYPosition
    bodyLabelContainer.frame = bodyLabelContainerFrame
    
    //use constraints instead.  leading trailing and bottom
    var bodyFrame = bodyLabel.frame
    bodyFrame.size.height = self.frame.size.height / 2
    bodyFrame.size.width = bodyLabelContainerFrame.size.width * 0.9
    bodyLabel.frame = bodyFrame
    
    let bottomConstraint = NSLayoutConstraint(item: bodyLabel, attribute: .top, relatedBy: .equal, toItem: bodyLabelContainer, attribute: .top, multiplier: 1, constant: 0)

    self.contentView.addConstraints([bottomConstraint])
    
    var preTextBackgroundFrame = preBodyBackground.frame
    //height is off set height in view controller?
//    preTextBackgroundFrame.size.height = 127.5
    //need to make this dynamic.  distance between leading edge of frame and origin x of bodyLabelContainerFrame
    preTextBackgroundFrame.size.width = 20.0
//    preTextBackgroundFrame.origin.y = bodyLabelContainer.frame.origin.y + 80
    preTextBackgroundFrame.origin.x = 20.0
    preBodyBackground.frame = preTextBackgroundFrame
    
    
    //constraints.  equal heights btw pretextBackground and bodyLabel. verticalConstraint
    let verticalConstraint:NSLayoutConstraint = NSLayoutConstraint(item: preBodyBackground, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: bodyLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
    let preTextHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: preBodyBackground, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: bodyLabel, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
    let preTextTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: preBodyBackground, attribute: .top, relatedBy: NSLayoutRelation.equal, toItem: bodyLabel, attribute: .top, multiplier: 1, constant: 0)
    let preTextLeadingConstraint:NSLayoutConstraint = NSLayoutConstraint(item: preBodyBackground, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: bodyLabel, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)

    
    self.contentView.addConstraints([verticalConstraint, preTextHeightConstraint, preTextTopConstraint, preTextLeadingConstraint])
    

    //making the frame for imageView.  subview of container.  positioned off centered
    
    let imageFrameHeightMultiplier = CGFloat(0.6746)
    let imageFrameWidthMultiplier = CGFloat(0.8213333)
    let imageFrameXPositionMultiplier = CGFloat(0.17866667)
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
    
    imageView.layer.shadowColor = UIColor.black.cgColor
    imageView.layer.shadowOpacity = 0.4
    imageView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
    imageView.layer.shadowRadius = 20
    
    //same frame as image view
    grayOverlay.frame = frame
    //not USING GRADIENT NOW??
//    let colorTop = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.0).cgColor
//    let colorMid = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.2).cgColor
//    let colorMiddle = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.9).cgColor
//    let colorBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.9).cgColor
//    let lineBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.99).cgColor
//    gl = CAGradientLayer()
//    gl.colors = [colorTop, colorMid, colorMiddle, colorBottom, lineBottom]
//    gl.locations = [0.0, 0.4, 0.8, 0.99, 0.99999999]
////    gl.frame = frame
////    let gl = CALayer()
////    gl.backgroundColor = UIColor.green.cgColor
//    gl.frame = frame
//    
//    cellContainer.layer.insertSublayer(gl, at: 3)
    
    //set origin x
    let topicFrameOriginXMultiplier = CGFloat(0.09333333)
    
    let topicFrameOriginXPosition = containerFrame.size.width * topicFrameOriginXMultiplier
    
    var topicFrame = topicLabel.frame
    topicFrame.size.height = 200
    topicFrame.size.width = 20
    topicFrame.origin.x = topicFrameOriginXPosition

    //align with
    topicFrame.origin.y = frame.origin.y
    topicLabel.frame = topicFrame

    

    
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
