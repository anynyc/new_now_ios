//
//  PostViewModel.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit


protocol PostViewModelDelegate: class {
  func postsDidLoad()
  func noPosts()
}
//store background emoji arrays.  Positive and negative arrays
class PostViewModel: NSObject {
  var postsArray = [PostModel]()
  weak var delegate: PostViewModelDelegate?
  
  
  
  
  //loads all home page games with users, initially without pictures(only photo urls)
  func loadPosts() {
    
    PostContentManager.loadPosts { [weak self] (postArray) in
      guard postArray != nil else {
        //call delegate for custom no more videos message
        return
      }
      //unwrap this
      self?.postsArray = postArray!
      self?.delegate?.postsDidLoad()
      //call delegate method in view to do something with the videos, loading active gif
    }
  }
  

  
  
  
  
}
