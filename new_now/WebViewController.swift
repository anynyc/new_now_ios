//
//  WebView.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import NVActivityIndicatorView



class WebViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate {
  
  var navBar: UINavigationBar = UINavigationBar()
  var urlString = ""
  var webView: WKWebView!

  
//  @IBOutlet weak var viewOnWebButton: UIButton!
//  @IBOutlet weak var overView: UIView!
  @IBOutlet weak var loaderView: NVActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.bringSubview(toFront: loaderView)
    loaderView.type = .ballScale
    loaderView.color = UIColor.black
    loaderView.startAnimating()
    let webConfiguration = WKWebViewConfiguration()
    navigationController?.setNavigationBarHidden(false, animated: false)

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
    

    webView = WKWebView(frame: UIScreen.main.bounds, configuration: webConfiguration)
    webView.navigationDelegate = self
    webView.uiDelegate = self
    //overview size. add subview gradient image to it and button


    
    
//
    view.addSubview(webView)
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
      webView.load(request)
    }
    

    
    
    animateButtons()

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
      self.navigationItem.leftBarButtonItem?.customView?.frame.origin.x = (self.navigationItem.leftBarButtonItem?.customView?.frame.origin.x)! + 22

      
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



    //fade everything out.  on completion do the transition
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
      //
//      self.view.bringSubview(toFront: self.overView)
//      self.overView.alpha = 1
      self.webView.alpha = 1
      
    }, completion: {(true) in
      
//      self.overView.bringSubview(toFront: self.viewOnWebButton)
    })

  }
//  @IBAction func viewOnWebButtonPressed(_ sender: Any) {
//    let url = NSURL(string: self.urlString)
//    UIApplication.shared.open(url as! URL)
//  }

}
