//
//  PostsViewController.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

extension PostsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
    
    let topicText = postViewModel.postsArray[indexPath.row].category
    let attributedString = NSMutableAttributedString(string: topicText)
    attributedString.addAttribute(NSKernAttributeName, value: 2.0, range: NSMakeRange(0, topicText.characters.count))
    cell.topicLabel.attributedText = attributedString
    let bodyText = postViewModel.postsArray[indexPath.row].body
    let image = postViewModel.postsArray[indexPath.row].image
    cell.imageView.image = image
    cell.bodyLabel.text = bodyText
    cell.articleUrl = postViewModel.postsArray[indexPath.row].link
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
    
//    if let link = cell.imageView.image {
//      self.showFullImage(of: image)
//    } else {
//      print("no photo")
//    }
    let link = postViewModel.postsArray[indexPath.row].link
    self.showArticle(of: link)
  }
}



class PostsViewController: BaseViewController, PostViewModelDelegate {
  
  var gridCollectionView: UICollectionView!
  var gridLayout: GridLayout!
  let fullImageView = UIImageView()
  @IBInspectable var startColor:UIColor = UIColor.red
  @IBInspectable var endColor:UIColor = UIColor.blue
  
  @IBOutlet weak var latLabelText: UILabel!
  
  @IBOutlet weak var longLabelText: UILabel!
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
    
    gridLayout = GridLayout()
    gridCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: gridLayout)
    gridCollectionView.backgroundColor = UIColor.clear
    gridCollectionView.showsVerticalScrollIndicator = false
    gridCollectionView.showsHorizontalScrollIndicator = false
    self.view.addSubview(gridCollectionView)
    navigationController?.setNavigationBarHidden(true, animated: false)

    gridCollectionView!.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
    gridCollectionView.dataSource = self
    gridCollectionView.delegate = self
    
    fullImageView.contentMode = .scaleAspectFit
    fullImageView.backgroundColor = UIColor.lightGray
    fullImageView.isUserInteractionEnabled = true
    fullImageView.alpha = 0
    self.view.addSubview(fullImageView)
    
    let dismissWihtTap = UITapGestureRecognizer(target: self, action: #selector(hideFullImage))
    fullImageView.addGestureRecognizer(dismissWihtTap)
    
    
    // Build the slider
    let slider:BWCircularSlider = BWCircularSlider(startColor:self.startColor, endColor:self.endColor, frame: self.view.bounds)
    
    // Attach an Action and a Target to the slider
    slider.addTarget(self, action: #selector(valueChanged), for: UIControlEvents.valueChanged)
    self.view.addSubview(slider)

    
  }

  func valueChanged(slider:BWCircularSlider){
    // Do something with the value...
    print("Value changed \(slider.angle)")
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    var frame = gridCollectionView.frame
    frame.size.height = self.view.frame.size.height
    frame.size.width = self.view.frame.size.width
    frame.origin.x = 0
    frame.origin.y = 0
    gridCollectionView.frame = frame
    
    self.fullImageView.frame = gridCollectionView.frame
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: false)
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
    postViewModel.getPostImages()
  }
  
  func noPosts() {
    
  }
  
  func imagesDidLoad() {
    
  }
  
  
  //sample methods that won't be used
  func hideFullImage() {
    UIView.animate(withDuration: 0.5, delay: 0, options: [], animations:{[unowned self] in
      self.fullImageView.alpha = 0
      }, completion: nil)
  }
  
  func showArticle(of link:String) {
    let webViewStoryboard = StoryboardInstanceConstants.webView
    let webViewController = webViewStoryboard.instantiateViewController(withIdentifier: VCNameConstants.webView) as! WebViewController
    webViewController.urlString = link
    navigationController?.pushViewController(webViewController, animated: true)
  }


  
  
}


