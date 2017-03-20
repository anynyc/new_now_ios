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
  }
  
  override func viewDidAppear(_ animated: Bool) {
  }
  
  //before loading hides Nav
  //checks if credentials are cached, if they are go to home page
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    view.alpha = 0
    navigationController?.setNavigationBarHidden(true, animated: false)
    presentInterstitialLoadingIndicator()
  }
  
  
  
  func presentInterstitialLoadingIndicator() {
    let loadingStoryboard = UIStoryboard.init(name: "LoadingInterstitialViewController", bundle: nil)
    let loadingViewController = loadingStoryboard.instantiateViewController(withIdentifier: "LoadingInterstitialVC")
    loadingViewController.modalPresentationStyle = .overCurrentContext
//    guard Reachability.connectedToNetwork() else {
//      navigateToHomeScreenIfLoggedIn()
//      return
//    }
    present(loadingViewController, animated: false) { [weak self] _ in
      self?.postViewModel.loadPosts()
    }
  }
  
  
  func postsReceived() {
    UIView.animate(withDuration: 1, delay: 1, options: .curveEaseInOut, animations: {
      if let views = self.presentedViewController?.view.subviews {
        for view in views {
          view.alpha = 0
        }
      }
    }, completion: { (true) in
      self.perform(#selector(self.navigateToMainScreen), with: self, afterDelay: 1.0)
    })
  }
  
  func navigateToMainScreen() {
    dismiss(animated: false, completion: nil)
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCATransitionFade
    navigationController?.view.layer.add(transition, forKey: nil)
    let homeScreenStoryboard = StoryboardInstanceConstants.postsScreen
    let homeScreenViewController = homeScreenStoryboard.instantiateViewController(withIdentifier: VCNameConstants.posts)
    navigationController?.pushViewController(homeScreenViewController, animated: false)
  }
  
  
  
  
  func postsDidLoad() {
    postsReceived()
  }
  func noPosts() {
  }
  
  
  
}
