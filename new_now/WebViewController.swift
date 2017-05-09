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
  
  @IBOutlet weak var loaderView: NVActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.bringSubview(toFront: loaderView)
    loaderView.type = .ballClipRotate
    loaderView.color = UIColor.blue
    loaderView.startAnimating()
    let webConfiguration = WKWebViewConfiguration()

    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50)
    
//    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"shareShape"), style: .plain, target: self, action: #selector(rightButtonAction))
//    

    
//    let button = UIButton.init(type: .custom)
//    button.setImage(UIImage.init(named: "sharePdf"), for: UIControlState.normal)
//    button.tintColor = UIColor(red: 87 / 255, green: 73 / 255 , blue: 226 / 255, alpha: 1.0)
//    button.frame = CGRect.init(x: 0, y: 0, width: 16, height: 20)
//    let barButton = UIBarButtonItem.init(customView: button)
//    button.addTarget(self, action: #selector(rightButtonAction), for: UIControlEvents.touchUpInside)
//
//    self.navigationItem.rightBarButtonItem = barButton
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"sharePdf"), style: .plain, target: self, action: #selector(rightButtonAction))
    navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 87 / 255, green: 73 / 255 , blue: 226 / 255, alpha: 1.0)
    
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"backPdf"), style: .plain, target: self, action: #selector(leftButtonAction))
    navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 23))
    imageView.contentMode = .scaleAspectFill
    let image = UIImage(named: "anyGoodLogo")
    imageView.image = image
    navigationItem.titleView = imageView
//    self.navigationItem.rightBarButtonItem = rightButtonItem
    webView = WKWebView(frame: UIScreen.main.bounds, configuration: webConfiguration)
    webView.navigationDelegate = self

//    webView = WKWebView(frame: UIScreen.main.bounds)
    webView.uiDelegate = self
    view.addSubview(webView)
    webView.alpha = 0
    
    
    
    let topConstraint = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
    view.addConstraints([topConstraint])
    
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      webView.load(request)
    }

  }
  
  
  

  
  
  
//  func setNavBarToTheView() {
//    self.navBar.frame = CGRect(x: 0, y: 0, width: 320, height: 10)  // Here you can set you Width and Height for your navBar
//    self.navBar.backgroundColor = (UIColor.black)
//    self.view.addSubview(navBar)
//  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func rightButtonAction(sender: UIBarButtonItem) {
    let message = "Message goes here."
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
    
    _ = self.navigationController?.popViewController(animated: false)
  }
  
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    loaderView.stopAnimating()
    UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
      self.webView.alpha = 1

      
    }, completion: {(true) in
    })


    
  }

}
