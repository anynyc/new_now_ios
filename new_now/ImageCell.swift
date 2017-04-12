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
  var bodyLabel: UILabel!
  var gl: CAGradientLayer!
  var articleUrl: String!
  var bodyLabelContainer: UIView!

  
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

    
    
    topicLabel = UILabel()
//    topicLabel.numberOfLines = 0
//    topicLabel.lineBreakMode = .byCharWrapping
    topicLabel.font = UIFont(name: "Avenir-Heavy", size: 9)
    topicLabel.textColor = UIColor.lightGray
    topicLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
    topicLabel.textAlignment = .left
//    contentView.addSubview(imageView)

    bodyLabel = UILabel()
    bodyLabel.numberOfLines = 5
    bodyLabel.font = bodyLabel.font.withSize(36)
    bodyLabel.font = UIFont(name: "Miller-Display", size: 36)
    bodyLabel.textColor = UIColor(red: 25.0 / 255, green: 26.0 / 255, blue: 36.0 / 255, alpha: 1.0)
    
    //view holding the body label.  will constrain bodylabel to bottom of this view.
    bodyLabelContainer = UIView()
    
    contentView.addSubview(cellContainer)
    cellContainer.addSubview(imageView)
    cellContainer.addSubview(grayOverlay)
    cellContainer.addSubview(topicLabel)
    cellContainer.addSubview(bodyLabelContainer)
    bodyLabelContainer.addSubview(bodyLabel)

    
    
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
    
    
    
    var bodyLabelContainerFrame = bodyLabelContainer.frame
    bodyLabelContainerFrame.size.height = self.frame.size.height / 2
    bodyLabelContainerFrame.size.width = 315.0
    bodyLabelContainerFrame.origin.x = 60.0
    bodyLabelContainerFrame.origin.y = 230.0
    bodyLabelContainer.frame = bodyLabelContainerFrame
    
    //use constraints instead.  leading trailing and bottom
    var bodyFrame = bodyLabel.frame
    bodyFrame.size.height = self.frame.size.height / 2
    bodyFrame.size.width = 315.0
//    bodyLabel.backgroundColor = UIColor.red
//    bodyFrame.origin.x = 60.0
//    bodyFrame.origin.y = 230.0
    bodyLabel.frame = bodyFrame
    
    let bottomConstraint = NSLayoutConstraint(item: bodyLabel, attribute: .bottom, relatedBy: .equal, toItem: bodyLabelContainer, attribute: .bottom, multiplier: 1, constant: 0)
//    let widthConstraint = NSLayoutConstraint(item: bodyLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: bodyLabelContainer.frame.size.width)
//    let heightConstraint = NSLayoutConstraint(item: bodyLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: bodyLabelContainer.frame.size.height)

    self.contentView.addConstraints([bottomConstraint])
    
    
    //making the frame for imageView.  subview of container.  positioned off centered
    var frame = imageView.frame
    frame.size.height = 450.0
    frame.size.width = 286.0
    frame.origin.x = 100.0
    frame.origin.y = 109.0
    imageView.frame = frame
    
    imageView.layer.shadowColor = UIColor.black.cgColor
    imageView.layer.shadowOpacity = 0.1
    imageView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
    imageView.layer.shadowRadius = 20
    
    //same frame as image view
    grayOverlay.frame = frame
    
    let colorTop = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.25).cgColor
    let colorMiddle = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
    let lineBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.99).cgColor
    gl = CAGradientLayer()
    gl.colors = [colorTop, colorMiddle, colorBottom, lineBottom]
    gl.locations = [0.0, 0.8, 0.99, 0.99999999]
//    gl.frame = frame
//    let gl = CALayer()
//    gl.backgroundColor = UIColor.green.cgColor
    gl.frame = frame
    
    cellContainer.layer.insertSublayer(gl, at: 3)
    
    
    var topicFrame = topicLabel.frame
    topicFrame.size.height = 200
    topicFrame.size.width = 20
    topicFrame.origin.x = 60.0
    //align with 
    topicFrame.origin.y = frame.origin.y
    topicLabel.frame = topicFrame

  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
