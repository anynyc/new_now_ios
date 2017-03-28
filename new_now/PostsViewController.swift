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
    cell.imageView.image = UIImage.init(named: "instagramsports")
    let text = "Technology"
    let attributedString = NSMutableAttributedString(string: text)
    attributedString.addAttribute(NSKernAttributeName, value: 1.0, range: NSMakeRange(0, text.characters.count))
    cell.topicLabel.attributedText = attributedString
    
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
    
    if let image = cell.imageView.image {
      self.showFullImage(of: image)
    } else {
      print("no photo")
    }
  }
  
  
}



class PostsViewController: BaseViewController, PostViewModelDelegate {
  
  var gridCollectionView: UICollectionView!
  var gridLayout: GridLayout!
  let fullImageView = UIImageView()

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
//    navigationController?.setNavigationBarHidden(true, animated: false)

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
  
  func showFullImage(of image:UIImage) {
    fullImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
    fullImageView.contentMode = .scaleAspectFit
    UIView.animate(withDuration: 0.5, delay: 0, options: [], animations:{
      self.fullImageView.image = image
      self.fullImageView.alpha = 1
      self.fullImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
    }, completion: nil)
  }
  
  
}


