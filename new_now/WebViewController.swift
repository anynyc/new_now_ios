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


class WebViewController: BaseViewController, WKUIDelegate {
  
  var navBar: UINavigationBar = UINavigationBar()
  var urlString = ""
  var webView: WKWebView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
//    self.setNavBarToTheView()
    let webConfiguration = WKWebViewConfiguration()

    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"shareShape"), style: .plain, target: self, action: #selector(rightButtonAction))
    
    
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"backShape"), style: .plain, target: self, action: #selector(leftButtonAction))
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 159, height: 69))
    imageView.contentMode = .scaleAspectFit
    let image = UIImage(named: "AnyLogo")
    imageView.image = image
    navigationItem.titleView = imageView
//    self.navigationItem.rightBarButtonItem = rightButtonItem
    webView = WKWebView(frame: UIScreen.main.bounds, configuration: webConfiguration)

//    webView = WKWebView(frame: UIScreen.main.bounds)
    webView.uiDelegate = self
    view.addSubview(webView)
    
    
    
    let topConstraint = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
    view.addConstraints([topConstraint])
    
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      webView.load(request)
    }

  }
  
  
  
  
  

  

  
  func setNavBarToTheView() {
    self.navBar.frame = CGRect(x: 0, y: 0, width: 320, height: 10)  // Here you can set you Width and Height for your navBar
    self.navBar.backgroundColor = (UIColor.black)
    self.view.addSubview(navBar)
  }
  
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

}
