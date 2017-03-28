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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    //container
    cellContainer = UIView()
    cellContainer.backgroundColor = UIColor.clear
    //image
    imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.isUserInteractionEnabled = false
    //overlay
    grayOverlay = UIView()
    grayOverlay.backgroundColor = UIColor(white: 1, alpha: 0.5)
    
    topicLabel = UILabel()
//    topicLabel.numberOfLines = 0
//    topicLabel.lineBreakMode = .byCharWrapping
    topicLabel.font = topicLabel.font.withSize(12)
    topicLabel.textColor = UIColor.lightGray
    topicLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
//    contentView.addSubview(imageView)

    contentView.addSubview(cellContainer)
    cellContainer.addSubview(imageView)
    cellContainer.addSubview(grayOverlay)
    cellContainer.addSubview(topicLabel)
    
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
    var frame = imageView.frame
    frame.size.height = 450.0
    frame.size.width = 286.0
    frame.origin.x = 100.0
    frame.origin.y = 109.0
    imageView.frame = frame
    
    //same frame as image view
    grayOverlay.frame = frame
    
    var topicFrame = topicLabel.frame
    topicFrame.size.height = 100
    topicFrame.size.width = 20
    topicFrame.origin.x = 45.0
    topicFrame.origin.y = 175.0
    topicLabel.frame = topicFrame

  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
