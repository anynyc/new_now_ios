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

    let titleOriginXMultiplier = CGFloat(0.09333)
    let titleOriginYMultiplier = CGFloat(0.2248)
    let titleWidthMultiplier = CGFloat(0.78933)
    let titleHeightMultiplier = CGFloat(0.2248)

    let titleXPosition = containerFrame.size.width * titleOriginXMultiplier
    let titleYPosition = containerFrame.size.height * titleOriginYMultiplier
    let titleWidth = containerFrame.size.width * titleWidthMultiplier
    let titleHeight = containerFrame.size.height * titleHeightMultiplier
    
    var titleFrame = titleLabel.frame
    titleFrame.size.width = titleWidth
    titleFrame.size.height = titleHeight
    titleFrame.origin.x = titleXPosition
    //align with
    titleFrame.origin.y = titleYPosition
    titleLabel.frame = titleFrame
    
    //Make responsive.  iphone 6 375 X 667
    
    
    let messageOriginXMultiplier = CGFloat(0.09333)
    let messageOriginYMultiplier = CGFloat(0.494752)
    let messageHeightMultiplier = CGFloat(0.07796)
    let messageWidthMultiplier = CGFloat(0.78666)
    
    let messageXPosition = containerFrame.size.width * messageOriginXMultiplier
    let messageYPosition = containerFrame.size.height * messageOriginYMultiplier
    let messageHeight = containerFrame.size.height * messageHeightMultiplier
    let messageWidth = containerFrame.size.width * messageWidthMultiplier
    
    
    var messageFrame = messageLabel.frame
    messageFrame.size.width = messageWidth
    messageFrame.size.height = messageHeight
    messageFrame.origin.x = messageXPosition
    //align with
    messageFrame.origin.y = messageYPosition
    messageLabel.frame = messageFrame
    
    //Make responsive.  iphone 6 375 X 667
    let buttonOriginXMultiplier = CGFloat(0.0933)
    let buttonOriginYMultiplier = CGFloat(0.65967)
    let buttonWidthMultiplier = CGFloat(0.32)
    let buttonHeightMultiplier = CGFloat(0.0209)
    
    let buttonXPosition = containerFrame.size.width * buttonOriginXMultiplier
    let buttonYPosition = containerFrame.size.height * buttonOriginYMultiplier
    let buttonWidth = containerFrame.size.width * buttonWidthMultiplier
    let buttonHeight = containerFrame.size.width * buttonHeightMultiplier
    
    var buttonFrame = buttonLabel.frame
    buttonFrame.size.width  = buttonWidth
    buttonFrame.size.height = buttonHeight
    buttonFrame.origin.x = buttonXPosition
    buttonFrame.origin.y = buttonYPosition
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
