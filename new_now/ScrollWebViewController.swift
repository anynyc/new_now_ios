//
//  ScrollWebViewController.swift
//  new_now
//
//  Created by Mike on 6/6/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import NVActivityIndicatorView
import SafariServices



@available(iOS 10.0, *)
class ScrollWebViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
  
  private var notification: NSObjectProtocol?
  private var newNotification: NSObjectProtocol?

  var navBar: UINavigationBar = UINavigationBar()
  var urlString = ""
  var webView: WKWebView!
  var overView: UIView!
  var viewOnWebButton: UIButton!
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBOutlet weak var contentView: UIView!
//  @IBOutlet weak var cutoffView: UIView!
  
  @IBOutlet weak var loaderView: NVActivityIndicatorView!
  var gradientLayer: CAGradientLayer!
  //  @IBOutlet weak var viewOnWebButton: UIButton!
  //  @IBOutlet weak var overView: UIView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.bringSubview(toFront: loaderView)
    loaderView.type = .ballScale
    loaderView.color = UIColor.black
    loaderView.startAnimating()
    let webConfiguration = WKWebViewConfiguration()
    overView = UIView()
    viewOnWebButton = UIButton()
    navigationController?.setNavigationBarHidden(false, animated: false)
    
    self.automaticallyAdjustsScrollViewInsets = false

    navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 65)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"sharePdf"), style: .plain, target: self, action: #selector(rightButtonAction))
    navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0 / 255, green: 0 / 255 , blue: 0 / 255, alpha: 1.0)
    navigationItem.rightBarButtonItem?.setBackgroundVerticalPositionAdjustment(-10.0, for: .default)
    
    
    var leftView = UIView(frame: CGRect(x: 0, y: 0, width: 31, height: 30))
    let leftImage = UIImageView(image: UIImage(named: "backNoLine"))
    
    leftImage.frame = CGRect(x: -50, y: 0, width: leftView.frame.width, height: leftView.frame.height)
    leftView.addSubview(leftImage)
    leftView.target(forAction: #selector(leftButtonAction), withSender: nil)
    leftView.tintColor = UIColor.black
    navigationItem.leftBarButtonItem?.customView = leftView
    
    
    
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"backNoLine"), style: .plain, target: self, action: #selector(leftButtonAction))
    navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    navigationItem.leftBarButtonItem?.setBackgroundVerticalPositionAdjustment(-10.0, for: .default)
    
    
    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 79.5, height: 80))
    let titleImage = UIImageView(image: UIImage(named: "AnyUnderscore"))
    
    
    //x not as far left on 5
    if UIScreen.main.bounds.size.width == 320 {
      titleImage.frame = CGRect(x: -101.5, y: -8, width: titleView.frame.width, height: titleView.frame.height)
      
    } else {
      titleImage.frame = CGRect(x: -126, y: -8, width: titleView.frame.width, height: titleView.frame.height)
      
    }
    
    
    titleView.addSubview(titleImage)
    navigationItem.titleView = titleView
    
    let webFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 6000.0)
    webView = WKWebView(frame: webFrame, configuration: webConfiguration)
//    webView = WKWebView(frame: UIScreen.main.bounds, configuration: webConfiguration)

    webView.navigationDelegate = self
    webView.uiDelegate = self
//    webView.scrollView.isScrollEnabled = false
    webView.isUserInteractionEnabled = false
    //overview size. add subview gradient image to it and button
    overView.frame = CGRect(x: 0, y: 2850, width: self.view.frame.width, height: 500)
    
    
    //not USING GRADIENT NOW??
    let colorTop = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0).cgColor
    let lineBottom = UIColor(red: 167.0/255.0, green: 167.0/255.0, blue: 167.0/255.0, alpha: 1).cgColor
    let bottom = UIColor(red: 167.0/255.0, green: 167.0/255.0, blue: 167.0/255.0, alpha: 1).cgColor
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop, lineBottom, bottom]
    gradientLayer.locations = [0.0, 0.35, 1.0]
    gradientLayer.frame = overView.frame
    
    overView.layer.insertSublayer(gradientLayer, at: 3)
    
    //view on web button
    var frameDivisor = CGFloat(4)
    if UIScreen.main.bounds.size.width == 320 {
      frameDivisor = CGFloat(5)
    }
    
    let lightBlue = UIColor(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1)
    let buttonFrame = CGRect(x: self.view.frame.width / frameDivisor, y: 5850.0, width: 200.0, height: 45.0)
    viewOnWebButton.frame = buttonFrame
    viewOnWebButton.setTitle("OPEN IN SAFARI", for: .normal)
    viewOnWebButton.titleLabel?.font = UIFont(name: "Miller-Display", size: 12)
    viewOnWebButton.setTitleColor(lightBlue, for: .normal)
    viewOnWebButton.backgroundColor = UIColor.white
    viewOnWebButton.layer.shadowColor = UIColor.black.cgColor
    viewOnWebButton.layer.shadowOffset.height = 5
    viewOnWebButton.layer.shadowOpacity = 0.6
    viewOnWebButton.layer.shadowRadius = 10
    viewOnWebButton.layer.cornerRadius = 20
    viewOnWebButton.layer.borderColor = UIColor.gray.cgColor
    
    viewOnWebButton.addTarget(self, action: #selector(goToArticle), for: .touchUpInside)
    
//    overView.addSubview(viewOnWebButton)
//    overView.bringSubview(toFront: viewOnWebButton)
    overView.isUserInteractionEnabled = true
    overView.alpha = 1
    contentView.addSubview(overView)
    contentView.addSubview(webView)
    contentView.addSubview(viewOnWebButton)
    contentView.bringSubview(toFront: overView)
    contentView.bringSubview(toFront: viewOnWebButton)
    webView.alpha = 0
    
    
    ///
    navigationController?.navigationBar.clipsToBounds = false
    navigationController?.navigationBar.layer.shadowOpacity = 0.2
    navigationController?.navigationBar.layer.shadowOffset.height = 5
    navigationController?.navigationBar.layer.shadowRadius = 100
    
    let topConstraint = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
    view.addConstraints([topConstraint])
    
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      
      
//      let safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
//      present(safariVC, animated: true, completion: nil)
//      
      webView.load(request)
    }
    
    
    
    
    animateButtons()
   
    
    
    
    notification = NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: .main) {
      [unowned self] notification in
      self.navBar.alpha = 0
      self.navigationController?.navigationBar.alpha = 0
      self.automaticallyAdjustsScrollViewInsets = false

      self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 65)
      
      self.navigationItem.rightBarButtonItem?.setBackgroundVerticalPositionAdjustment(-10.0, for: .default)
      self.animateNavBackIn()
      

    }
    
    newNotification = NotificationCenter.default.addObserver(forName: .UIApplicationDidEnterBackground, object: nil, queue: .main) {
      [unowned self] notification in
      
      self.navigationController?.navigationBar.alpha = 0
      self.navBar.alpha = 0

      
    }
    

    self.scrollView.pinchGestureRecognizer?.isEnabled = false
    
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeLeft))
    swipeLeft.direction = UISwipeGestureRecognizerDirection.left
    swipeLeft.require(toFail: self.scrollView.panGestureRecognizer)
    self.scrollView.addGestureRecognizer(swipeLeft)
    
    
    
    
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
  
  
  func didSwipeLeft(gesture: UIGestureRecognizer) {
    
    let titleImage = UIImageView(image: UIImage(named: "AnyUnderscore"))
    let fakeNavView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    fakeNavView.backgroundColor = UIColor.white
    fakeNavView.alpha = 0
    
    let fakeNavBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
    fakeNavBar.backgroundColor = UIColor.white
    fakeNavBar.alpha = 1
    fakeNavBar.layer.shadowOpacity = 0.2
    fakeNavBar.layer.shadowOffset.height = 5
    fakeNavBar.layer.shadowRadius = 100
    
    
    //x not as far left on 5
    if UIScreen.main.bounds.size.width == 320 {
      titleImage.frame = CGRect(x: 34, y: 23.5, width: 79.5, height: 80)
      
    } else {
      titleImage.frame = CGRect(x: 40, y: 23.5, width: 79.5, height: 80)

    }
    self.view.addSubview(fakeNavView)
    self.view.bringSubview(toFront: fakeNavView)
    self.view.addSubview(fakeNavBar)
    self.view.bringSubview(toFront: fakeNavBar)
    
    self.navigationController?.navigationBar.layer.shadowOpacity = 0
    self.navigationController?.navigationBar.layer.shadowOffset.height = 0
    self.navigationController?.navigationBar.layer.shadowRadius = 0
    
    self.view.addSubview(titleImage)
    self.view.bringSubview(toFront: titleImage)
    
    
    
    let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
    DispatchQueue.main.asyncAfter(deadline: when) {
      // Your code with delay
      
      self.navigationController?.setNavigationBarHidden(true, animated: false)
      
    }
    
    
    
    //fade everything out.  on completion do the transition
    UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
      fakeNavView.alpha = 1
      fakeNavBar.layer.shadowOpacity = 0.0
      fakeNavBar.layer.shadowOffset.height = 0
      fakeNavBar.layer.shadowRadius = 0
    })
    
    
    
    UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: {
      
      titleImage.frame.origin.y = titleImage.frame.origin.y + 21
      
      
      
    }, completion:  { (finished: Bool) in
      
      let transition: CATransition = CATransition()
      transition.duration = 0.2
      transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      transition.type = kCATransitionFade
      self.navigationController?.view.layer.add(transition, forKey: nil)
      
      
      self.navigationController?.popViewController(animated: false)
      
    })
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    
    
    if gestureRecognizer.state == UIGestureRecognizerState.ended {
      puts("gesture ended")
      
      //how to check if this view is still the active one?
      
    }
    
    return true
  }
  
  
  @available(iOS 10.0, *)
  func goToArticle() {
    
    
    //Animate nav bar out first
    UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
      
      self.navBar.alpha = 0
      self.navigationController?.navigationBar.alpha = 0
      
      
    }, completion:  { (finished: Bool) in
      
      
      let url = NSURL(string: self.urlString)
      self.navigationController?.navigationBar.isHidden = true
      self.navBar.isHidden = true
      UIApplication.shared.open(url as! URL)
      
    })
    
    

  }
  
  func animateButtons() {
    //    //not using currently
    //    var leftButtonStart = CGAffineTransform.identity
    //    leftButtonStart = leftButtonStart.translatedBy(x: -50, y: 0)
    //    self.navigationItem.leftBarButtonItem?.customView?.transform = leftButtonStart
    //
    //
    //
    UIView.animate(withDuration: 1, delay: 0.2, animations: { () -> Void in
      //
      //      var leftButtonFinish = CGAffineTransform.identity
      //      leftButtonFinish = leftButtonFinish.translatedBy(x: 0, y: 0)
      //      self.navigationItem.leftBarButtonItem?.customView?.transform = leftButtonFinish
      self.navigationItem.leftBarButtonItem?.customView?.frame.origin.x = (self.navigationItem.leftBarButtonItem?.customView?.frame.origin.x)! + 21
      
      
    })
  }
  
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func rightButtonAction(sender: UIBarButtonItem) {
    let message = "Take a look at this great article!"
    //Set the link to share.
    if let link = NSURL(string: urlString)
    {
      let objectsToShare = [message,link] as [Any]
      let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
      activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
      self.present(activityVC, animated: true, completion: nil)
    }
  }
  
  func leftButtonAction(sender: UIBarButtonItem) {
    
    let titleImage = UIImageView(image: UIImage(named: "AnyUnderscore"))
    let fakeNavView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    fakeNavView.backgroundColor = UIColor.white
    fakeNavView.alpha = 0
    
    let fakeNavBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
    fakeNavBar.backgroundColor = UIColor.white
    fakeNavBar.alpha = 1
    fakeNavBar.layer.shadowOpacity = 0.2
    fakeNavBar.layer.shadowOffset.height = 5
    fakeNavBar.layer.shadowRadius = 100
    
    
    //old logo x and y
//    if UIScreen.main.bounds.size.width == 320 {
//      titleImage.frame = CGRect(x: 34, y: 23.5, width: 79.5, height: 80)
//      
//    } else {
//      titleImage.frame = CGRect(x: 40, y: 23.5, width: 79.5, height: 80)
//      
//    }
    //new logo x and y
    if UIScreen.main.bounds.size.width == 320 {
      titleImage.frame = CGRect(x: 19, y: -5, width: 79.5, height: 80)
      
    } else {
      titleImage.frame = CGRect(x: 22, y: -5, width: 79.5, height: 80)
      
    }
    
    self.view.addSubview(fakeNavView)
    self.view.bringSubview(toFront: fakeNavView)
    self.view.addSubview(fakeNavBar)
    self.view.bringSubview(toFront: fakeNavBar)
    
    self.navigationController?.navigationBar.layer.shadowOpacity = 0
    self.navigationController?.navigationBar.layer.shadowOffset.height = 0
    self.navigationController?.navigationBar.layer.shadowRadius = 0
    
    self.view.addSubview(titleImage)
    self.view.bringSubview(toFront: titleImage)
    
    
    
    let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
    DispatchQueue.main.asyncAfter(deadline: when) {
      // Your code with delay
      
      self.navigationController?.setNavigationBarHidden(true, animated: false)
      
    }
    
    
    
//    fade everything out.  on completion do the transition
    UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
      fakeNavView.alpha = 1
      fakeNavBar.layer.shadowOpacity = 0.0
      fakeNavBar.layer.shadowOffset.height = 0
      fakeNavBar.layer.shadowRadius = 0
    })
    
    
    
    UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: {
      
      titleImage.frame.origin.y = titleImage.frame.origin.y + 22
      
      
      
    }, completion:  { (finished: Bool) in
      
      let transition: CATransition = CATransition()
      transition.duration = 0.2
      transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      transition.type = kCATransitionFade
      self.navigationController?.view.layer.add(transition, forKey: nil)
      
      
      self.navigationController?.popViewController(animated: false)
      
    })
    
    
    
    
  }
  
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    loaderView.stopAnimating()
    UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
//      self.contentView.bringSubview(toFront: self.overView)
//      self.overView.alpha = 1
      self.webView.alpha = 1
      
    }, completion: {(true) in
      
      self.webView.bringSubview(toFront: self.overView)
    })
    
  }

  func animateNavBackIn() {
    UIView.animate(withDuration: 0.4, delay: 0, animations: { () -> Void in
    self.navigationController?.navigationBar.isHidden = false
    self.navBar.isHidden = false
    self.navigationController?.navigationBar.alpha = 1
    self.navBar.alpha = 1

      
    })
  }
  
  
  override func viewDidDisappear(_ animated: Bool) {
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
  }
  
  

  deinit {
    
    if let notification = notification {
      NotificationCenter.default.removeObserver(notification)
    }
    
    if let newNotification = newNotification {
      NotificationCenter.default.removeObserver(newNotification)
      
    }
    
  }

}
