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


class LaunchViewController: BaseViewController, PostViewModelDelegate, GreetingViewModelDelegate {
  
  let postViewModel = PostViewModel()
  let greetingViewModel = GreetingViewModel()
  
  @IBOutlet weak var anyLogo: UIImageView!
  @IBOutlet weak var loaderView: NVActivityIndicatorView!
  
  var editionLabel: UILabel!
  
  var mainContentLabel: UILabel!
  var progressBar: UIProgressView!
  static func storyboardInstance() -> LaunchViewController? {
    
    let storyboard = UIStoryboard(name:
      "LaunchViewController", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: VCNameConstants.launch) as? LaunchViewController
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setupConstraints()
    postViewModel.delegate = self
    greetingViewModel.delegate = self
    
    
    //check iOS version.  If less than 10 show message
    
    let floatVersion = (UIDevice.current.systemVersion as NSString).floatValue
    
    


  }
  
  override func viewDidAppear(_ animated: Bool) {
    
  }
  
  //before loading hides Nav
  //checks if credentials are cached, if they are go to home page
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let floatVersion = (UIDevice.current.systemVersion as NSString).floatValue

    
    if floatVersion < 10 {
      //display error notice that they need to upgrade their operating system
      let alertController = UIAlertController(title: title, message: "Any_ is made for iOS 10 or later.  Please update your Version", preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(OKAction)
      self.present(alertController, animated: true, completion: nil)
      
    } else {
      navigationController?.setNavigationBarHidden(true, animated: false)
      //    loaderView.type = .ballClipRotate
      //    loaderView.color = UIColor.blue
      //    loaderView.startAnimating()
      presentInterstitialLoadingIndicator()
      
      mainContentLabel = UILabel()
      mainContentLabel.numberOfLines = 3
      
      
      if UIScreen.main.bounds.size.width == 320 {
        mainContentLabel.font = UIFont(name: "Miller-Display", size: 25)

      } else {
        mainContentLabel.font = UIFont(name: "Miller-Display", size: 30)

      }
      mainContentLabel.textAlignment = .left
      self.view.addSubview(mainContentLabel)
      
      
      let mainContentXMultiplier = CGFloat(0.09333)
      let mainContentYMultiplier = CGFloat(0.4197)
      let mainContentWidthMultiplier = CGFloat(0.621333)
      let mainContentHeightMultiplier = CGFloat(0.16191)
      
      let mainContentWidth = self.view.frame.size.width * mainContentWidthMultiplier
      let mainContentHeight = self.view.frame.size.height * mainContentHeightMultiplier
      let mainContentXPosition = self.view.frame.size.width * mainContentXMultiplier
      let mainContentYPosition = self.view.frame.size.height * mainContentYMultiplier
      
      var contentFrame = mainContentLabel.frame
      contentFrame.origin.x = mainContentXPosition
      contentFrame.origin.y = mainContentYPosition
      contentFrame.size.width = mainContentWidth
      contentFrame.size.height = mainContentHeight
      
      mainContentLabel.frame = contentFrame
      
      mainContentLabel.setNeedsLayout()
      mainContentLabel.layoutIfNeeded()
      
      
      
    }
    
    


    


  }
  
  override func viewDidLayoutSubviews() {

  }
  
  func presentInterstitialLoadingIndicator() {

    greetingViewModel.loadGreeting()
    
    
  }
  
  
  func postsReceived() {

    UIView.animate(withDuration: 0.5, delay: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
      self.view.alpha = 0


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
    //30%
    progressBar.setProgress(0.3, animated: true)
  }
  
  func postsDidLoad() {
//    getPostImages()
//    postsReceived()
    loadPostsImages()
    
  }
  func noPosts() {
  }
  
  func imagesDidLoad() {
    //70%
    progressBar.setProgress(0.7, animated: true)
    self.postViewModel.getPostHtml()

  }
  
  func htmlDidLoad() {
    progressBar.setProgress(1.0, animated: true)

    postsReceived()

  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  
  func moveLoader(view: UIView){
//    let toPoint:CGPoint = CGPoint(x: 0.0, y: -10.0)
//    let fromPoint:CGPoint = CGPoint.zero
//    let movement = CABasicAnimation(keyPath: "movement")
//    movement.isAdditive = true
//    movement.fromValue = NSValue(cgPoint: fromPoint)
//    movement.toValue = NSValue(cgPoint: toPoint)
//    movement.duration = 0.3
//    view.layer.add(movement, forKey: "move")
  }
  
  func setupConstraints() {
    let screenSize = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    
    //ANY LOGO leading and top constraint added programmatically
    let anyLeadingMultiplier = CGFloat(-0.088)
//    let anyTopMultiplier = CGFloat(0.045)
    let anyTopMultiplier = CGFloat(0.025)

    let anyLeadingDistance = screenWidth * anyLeadingMultiplier
    let anyTopDistance = screenHeight * anyTopMultiplier
    
    let anyLeadingConstraint = NSLayoutConstraint(item: anyLogo, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: anyLeadingDistance)
    let anyTopConstraint = NSLayoutConstraint(item: anyLogo, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: anyTopDistance)
//    let editionLeadingConstraint = NSLayoutConstraint(item: editionLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: anyLeadingDistance)
//    
    self.view.addConstraints([anyLeadingConstraint, anyTopConstraint])
    
    
    self.view.layoutIfNeeded()

  }

  func greetingDidLoad() {
    mainContentLabel.text = greetingViewModel.greeting?.title
    
    editionLabel = UILabel()
    editionLabel.font = UIFont(name: "Avenir-Heavy", size: 9)
    editionLabel.textColor = UIColor.lightGray
    editionLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
    editionLabel.textAlignment = .left
    
    //attributed text need character spacing 2
    let editionText = greetingViewModel.greeting?.edition
    
    let attributedBodyString = NSMutableAttributedString(string: editionText!)
    attributedBodyString.addAttribute(NSKernAttributeName, value:   CGFloat(2.0), range: NSRange(location: 0, length: (editionText?.characters.count)!))
    
    
    editionLabel.attributedText = attributedBodyString
    
    self.view.addSubview(editionLabel)
    //make dynamic
    var editionFrame = editionLabel.frame
    editionFrame.size.height = 100
    editionFrame.size.width = 12
    
    editionFrame.origin.x = 38.0
    editionFrame.origin.y = 80.0
    
    editionLabel.frame = editionFrame
    
    editionLabel.setNeedsLayout()
    editionLabel.layoutIfNeeded()
    
    progressBar = UIProgressView()
    
    let progressXMultiplier = CGFloat(0.109333)
    let progressYMultiplier = CGFloat(0.65667)
    let progressHeightMultiplier = CGFloat(0.00449)
    let progressWidthMultiplier = CGFloat(0.770666)
    
    let progressXPosition = self.view.frame.size.width * progressXMultiplier
    let progressYPosition = self.view.frame.size.height * progressYMultiplier
    let progressHeight = self.view.frame.size.height * progressHeightMultiplier
    let progressWidth = self.view.frame.size.width * progressWidthMultiplier
    
    
    var progressFrame = progressBar.frame
    progressFrame.origin.x = progressXPosition
    progressFrame.origin.y = progressYPosition
    progressFrame.size.width = progressWidth
    progressFrame.size.height = progressHeight
    
    progressBar.frame = progressFrame
    
    progressBar.setProgress(0.1, animated: true)
    self.view.addSubview(progressBar)

    editionLabel.alpha = 0
    progressBar.alpha = 0
    mainContentLabel.alpha = 0
    
    UIView.animate(withDuration: 0.5, delay: 0.2, animations: { () -> Void in
      self.editionLabel.alpha = 1
      self.progressBar.alpha = 1
      self.anyLogo.alpha = 1
      self.mainContentLabel.alpha = 1
      
      
    })
    
    UIView.animate(withDuration: 0, delay: 2.0, animations: { () -> Void in
      self.postViewModel.loadPosts()

      
    })

  }
  
  func noGreeting() {

  }
  
}
