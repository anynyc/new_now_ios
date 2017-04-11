//
//  LaunchViewController.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class LaunchViewController: BaseViewController, PostViewModelDelegate {
  
  let postViewModel = PostViewModel()
  
  @IBOutlet weak var loaderView: NVActivityIndicatorView!
  
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
    navigationController?.setNavigationBarHidden(true, animated: false)
    loaderView.type = .ballClipRotate
    loaderView.color = UIColor.blue
    loaderView.startAnimating()
    presentInterstitialLoadingIndicator()
  }
  
  override func viewDidLayoutSubviews() {
    
  }
  
  func presentInterstitialLoadingIndicator() {
//    let loader = NVActivityIndicatorView(frame: self.loaderView.frame, type: .ballClipRotate, color: UIColor.black)
//    loaderView.addSubview(loader)
//    loader.startAnimating()

//    let loadingStoryboard = UIStoryboard.init(name: "LoadingInterstitialViewController", bundle: nil)
//    let loadingViewController = loadingStoryboard.instantiateViewController(withIdentifier: "LoadingInterstitialVC")
//    loadingViewController.modalPresentationStyle = .overCurrentContext
//    guard Reachability.connectedToNetwork() else {
//      navigateToHomeScreenIfLoggedIn()
//      return
//    }
//
//    let activityIndicatorView = NVActivityIndicatorView(frame: loadingViewController.view.frame, type: NVActivityIndicatorType(rawValue: 0)!)
//    loadingViewController.view.addSubview(activityIndicatorView)
//
//    present(loadingViewController, animated: false) { [weak self] _ in
      postViewModel.loadPosts()
//    }
  }
  
  
  func postsReceived() {
//    moveLoader(view: loaderView)
    
    
    UIView.animate(withDuration: 3, delay: 0.5, options: UIViewAnimationOptions.curveLinear, animations: {
      self.view.alpha = 0
      self.view.center.y = self.view.center.y + 195
      self.view.center.x = self.view.center.x - 155
      self.loaderView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)

    }, completion: {(true) in
      self.perform(#selector(self.navigateToMainScreen), with: self, afterDelay: 0.0)
    })
//    UIView.animate(withDuration: 1, delay: 1, options: .curveEaseInOut, animations: {
//      if let views = self.presentedViewController?.view.subviews {
//        for view in views {
//          view.alpha = 0
//        }
//      }
//    }, completion: { (true) in
//      self.perform(#selector(self.navigateToMainScreen), with: self, afterDelay: 1.0)
//    })
  }
  
  func navigateToMainScreen() {
//    dismiss(animated: false, completion: nil)
//    let transition = CATransition()
//    transition.duration = 0.2
//    transition.type = kCATransitionFade
//    navigationController?.view.layer.add(transition, forKey: nil)
    let homeScreenStoryboard = StoryboardInstanceConstants.postsScreen
    let homeScreenViewController = homeScreenStoryboard.instantiateViewController(withIdentifier: VCNameConstants.posts)

    navigationController?.pushViewController(homeScreenViewController, animated: false)
  }
  
  
  func getPostImages() {
   postViewModel.getPostImages()
  }
  
  
  func loadPostsImages() {
    postViewModel.postsDidLoad()
  }
  
  func postsDidLoad() {
//    getPostImages()
//    postsReceived()
    loadPostsImages()
    
  }
  func noPosts() {
  }
  
  func imagesDidLoad() {
    postsReceived()

  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  
  func moveLoader(view: UIView){
    let toPoint:CGPoint = CGPoint(x: 0.0, y: -10.0)
    let fromPoint:CGPoint = CGPoint.zero
    let movement = CABasicAnimation(keyPath: "movement")
    movement.isAdditive = true
    movement.fromValue = NSValue(cgPoint: fromPoint)
    movement.toValue = NSValue(cgPoint: toPoint)
    movement.duration = 0.3
    view.layer.add(movement, forKey: "move")
  }

  
}
