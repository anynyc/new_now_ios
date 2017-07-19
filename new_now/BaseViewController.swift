//
//  BaseViewController.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @available(iOS 10.0, *)
  func navigateToHomeViewController() {
    guard let navCon = navigationController else {
      return
    }
    for vc in navCon.viewControllers {
      if let postsScreenVC = vc as? PostsViewController {
        _ = navigationController?.popToViewController(postsScreenVC, animated: true)
      }
    }
  }
  
  
  
}




