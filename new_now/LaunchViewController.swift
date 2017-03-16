//
//  LaunchViewController.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

class LaunchViewController: BaseViewController, PostViewModelDelegate {
  
  let postViewModel = PostViewModel()
  
  
  static func storyboardInstance() -> LaunchViewController? {
    
    let storyboard = UIStoryboard(name:
      "LaunchViewController", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: VCNameConstants.launch) as? LaunchViewController
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    postViewModel.delegate = self
    postViewModel.loadPosts()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
  }
  
  //before loading hides Nav
  //checks if credentials are cached, if they are go to home page
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    view.alpha = 0
    navigationController?.setNavigationBarHidden(true, animated: false)
    
  }
  
  func presentHomeScreen() {
    let postsScreenStoryboard = StoryboardInstanceConstants.postsScreen
    let postsScreenViewController = postsScreenStoryboard.instantiateViewController(withIdentifier: VCNameConstants.posts) as! PostsViewController
    navigationController?.pushViewController(postsScreenViewController, animated: false)
    
  }
  
  func postsDidLoad() {
    
  }
  func noPosts() {
  }
  
  
  
}
