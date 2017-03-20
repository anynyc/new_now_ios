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
  

  let postViewModel = PostViewModel()
  var postIndex = 0
  let contentManager = PostContentManager()
  
  
  static func storyboardInstance() -> PostsViewController? {
    let storyboard = UIStoryboard(name:
      "PostsViewController", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: VCNameConstants.posts) as? PostsViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let posts = contentManager.fetchCachedPosts(ItemCacheType.postHomePage)
    postViewModel.delegate = self
    postViewModel.postsArray = posts
//    navigationController?.setNavigationBarHidden(true, animated: false)

  }
  
  

  
  
  func postsDidLoad() {

  }
  
  func noPosts() {
    
  }

  
  
}
