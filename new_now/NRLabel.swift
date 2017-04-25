//
//  NRLabel.swift
//  new_now
//
//  Created by Mike on 4/25/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

class NRLabel : UILabel {
  
  var textInsets = UIEdgeInsets.zero {
    didSet { invalidateIntrinsicContentSize() }
  }
  
  override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    let insetRect = UIEdgeInsetsInsetRect(bounds, textInsets)
    let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
    let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                      left: -textInsets.left,
                                      bottom: -textInsets.bottom,
                                      right: -textInsets.right)
    return UIEdgeInsetsInsetRect(textRect, invertedInsets)
  }
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
  }
}
