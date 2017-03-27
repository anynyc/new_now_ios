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
  
  

  @IBAction func shareButtonPressed(_ sender: Any) {
    
    let message = "Message goes here."
    //Set the link to share.
    if let link = NSURL(string: "http://yoururl.com")
    {
      let objectsToShare = [message,link] as [Any]
      let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
      activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
      self.present(activityVC, animated: true, completion: nil)
    }
    
  }
  
  
  func postsDidLoad() {

  }
  
  func noPosts() {
    
  }
  
  

  
  
}
