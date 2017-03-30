//
//  WebView.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit


class WebViewController: BaseViewController, UIWebViewDelegate {
  
  var navBar: UINavigationBar = UINavigationBar()
  var urlString = ""
  var webView: UIWebView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
//    self.setNavBarToTheView()
    
    navigationController?.setNavigationBarHidden(false, animated: false)

    webView = UIWebView(frame: UIScreen.main.bounds)
    webView.delegate = self
    view.addSubview(webView)
    
    let topConstraint = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
    view.addConstraints([topConstraint])
    
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      webView.loadRequest(request)
    }

  }
  
  
  
  
  @IBAction func shareButtonPressed(_ sender: Any) {
    
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
  

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let backItem = UIBarButtonItem()
    backItem.title = "Back"
    navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
  }
  
  func setNavBarToTheView() {
    self.navBar.frame = CGRect(x: 0, y: 0, width: 320, height: 10)  // Here you can set you Width and Height for your navBar
    self.navBar.backgroundColor = (UIColor.black)
    self.view.addSubview(navBar)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
