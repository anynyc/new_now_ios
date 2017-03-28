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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.isUserInteractionEnabled = false
    contentView.addSubview(imageView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    var frame = imageView.frame
    frame.size.height = self.frame.size.height
    frame.size.width = self.frame.size.width
    frame.origin.x = 0
    frame.origin.y = 0
    imageView.frame = frame
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
