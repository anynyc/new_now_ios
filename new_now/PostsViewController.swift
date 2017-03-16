//
//  PostsViewController.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

class PostsViewController: BaseViewController, PostViewModelDelegate {
  

  let postViewModel = PostsViewModel()
  var postIndex = 0

  
  
  static func storyboardInstance() -> PostsViewController? {
    let storyboard = UIStoryboard(name:
      "PostsViewController", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: VCNameConstants.posts) as? PostsViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    postViewModel.delegate = self
//    navigationController?.setNavigationBarHidden(true, animated: false)
    postViewModel.loadPosts()

  }
  
  

  

  func postsDidLoad() {

  }
  
  func noVideos() {
    
  }

  
  
}
