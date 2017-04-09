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
    topicLabel.font = topicLabel.font.withSize(12)
    topicLabel.textColor = UIColor.lightGray
    topicLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
//    contentView.addSubview(imageView)

    bodyLabel = UILabel()
    bodyLabel.numberOfLines = 3
    bodyLabel.font = bodyLabel.font.withSize(36)
    bodyLabel.font = UIFont(name: "Miller-Display", size: 36)
    
    contentView.addSubview(cellContainer)
    cellContainer.addSubview(imageView)
    cellContainer.addSubview(grayOverlay)
    cellContainer.addSubview(topicLabel)
    cellContainer.addSubview(bodyLabel)

    
    
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
    
    var bodyFrame = bodyLabel.frame
    bodyFrame.size.height = self.frame.size.height / 2
    bodyFrame.size.width = self.frame.size.width / 1.5
    bodyFrame.origin.x = 60.0
    bodyFrame.origin.y = 216.0
    bodyLabel.frame = bodyFrame
    
    //making the frame for imageView.  subview of container.  positioned off centered
    var frame = imageView.frame
    frame.size.height = 450.0
    frame.size.width = 286.0
    frame.origin.x = 100.0
    frame.origin.y = 109.0
    imageView.frame = frame
    
    //same frame as image view
    grayOverlay.frame = frame
    
    let colorTop = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.25).cgColor
    let colorBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
    gl = CAGradientLayer()
    gl.colors = [colorTop, colorBottom]
    gl.locations = [0.0, 1.0]
//    gl.frame = frame
//    let gl = CALayer()
//    gl.backgroundColor = UIColor.green.cgColor
    gl.frame = frame
    
    cellContainer.layer.insertSublayer(gl, at: 3)
    
    
    var topicFrame = topicLabel.frame
    topicFrame.size.height = 200
    topicFrame.size.width = 20
    topicFrame.origin.x = 45.0
    topicFrame.origin.y = 175.0
    topicLabel.frame = topicFrame

  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
