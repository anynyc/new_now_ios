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
  var titleLabel: UILabel!
  var searchTerm: String!
  var buttonLabel: UIButton!
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    //container
    cellContainer = UIView()
    cellContainer.backgroundColor = UIColor.clear
    //image
    imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    
    messageLabel = UILabel()
    
    messageLabel.font = UIFont(name: "Avenir-Roman", size: 16)
    messageLabel.textColor = UIColor.black
    messageLabel.textAlignment = .left
    messageLabel.numberOfLines = 2
    
    
    buttonLabel = UIButton()
    buttonLabel.setTitleColor(UIColor.blue, for: .normal)
    buttonLabel.titleLabel!.font = UIFont(name: "Avenir-heavy", size: 10)
    buttonLabel.contentHorizontalAlignment = .left
    buttonLabel.isUserInteractionEnabled = true
    
    
    titleLabel = UILabel()
    titleLabel.font = UIFont(name: "Miller-Display", size: 40)
    titleLabel.textColor = UIColor.black
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 3
    
    
    self.addSubview(imageView)
    self.addSubview(titleLabel)
    self.addSubview(messageLabel)
    self.addSubview(buttonLabel)

    
    
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
    
    imageView.frame = containerFrame

       
    //set origin x

    var titleFrame = titleLabel.frame
    titleFrame.size.width = 296.0
    titleFrame.size.height = 150.0
    titleFrame.origin.x = 35
    //align with
    titleFrame.origin.y = 150
    titleLabel.frame = titleFrame
    
    var messageFrame = messageLabel.frame
    messageFrame.size.width = 295.0
    messageFrame.size.height = 52.0
    messageFrame.origin.x = 35
    //align with
    messageFrame.origin.y = 330
    messageLabel.frame = messageFrame
    
//    var buttonFrame = buttonLabel.frame
//    buttonFrame.size.width = 295.0
//    buttonFrame.size.height = 52.0
//    buttonFrame.origin.x = 35
//    //align with
//    buttonFrame.origin.y = 330
//    buttonLabel.frame = buttonFrame
//    

    var buttonFrame = buttonLabel.frame
    buttonFrame.size.width  = 120.0
    buttonFrame.size.height = 14.0
    buttonFrame.origin.x = 35
    buttonFrame.origin.y = 440
    buttonLabel.frame = buttonFrame
//
    
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func goToGoogle(_ button: UIButton) {
    //url example https://www.google.com/maps/search/ice+cream+near+me/@40.7230073,-74.0006327
    

  }
  
}
