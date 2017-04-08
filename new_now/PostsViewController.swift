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
    
    feedbackGenerator?.notificationOccurred(.success)     // Trigger the haptic feedback.

//    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [],
//                               animations: {
//                                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//                                
//    },
//                               completion: { finished in
//                                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut,
//                                                           animations: {
//                                                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//                                },
//                                                           completion: nil
//                                )
//                                
//    }
//    )

    
    return cell
  }
  

  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    collectionView.scrollToItem(at: indexPath, at: .right, animated: true)

  }
}



class PostsViewController: BaseViewController, PostViewModelDelegate {
  
  var gridCollectionView: UICollectionView!
  var gridLayout: GridLayout!
  var activeCell = 0
  let fullImageView = UIImageView()
  var feedbackGenerator: UINotificationFeedbackGenerator?    // Declare the generator type.

  
  @IBInspectable var startColor:UIColor = UIColor.red
  @IBInspectable var endColor:UIColor = UIColor.blue
  
  @IBOutlet weak var latLabelText: UILabel!
  
  @IBOutlet weak var longLabelText: UILabel!
  let postViewModel = PostViewModel()
  var postIndex = 0
  let contentManager = PostContentManager()
  
  @IBOutlet weak var readThisButton: UIButton!
  
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
    
    feedbackGenerator = UINotificationFeedbackGenerator()  // Instantiate the generator.
    feedbackGenerator?.prepare()

    
    
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
    gridCollectionView.allowsSelection = true
    gridCollectionView.allowsMultipleSelection = false
    
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
    
    setupBottomButtons()

    
  }

  func valueChanged(slider:BWCircularSlider){
    //depending on the angle value reveal certain card
    let row = getSection(int: slider.angle)
    if row != activeCell {
      activeCell = row
      
      let indexPath = IndexPath(row: row, section: 0)
      gridCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
      
      //deselecet
      //    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
      gridCollectionView.delegate?.collectionView!(gridCollectionView, didSelectItemAt: indexPath)
    }
    //if cell is different call below to display a new cell. maybe call an animate out method first?
    


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

  func getSection(int: Int) -> Int {
    var returnInt = 0
    
    if int <= 71 {
        returnInt = 0
    } else if int >= 72 && int <= 77  {
      returnInt = 1
    } else if int >= 78 && int <= 83 {
      returnInt = 2
    } else if int >= 84 && int <= 89 {
      returnInt = 3
    } else if int >= 90 && int <= 95 {
      returnInt = 4
    } else if int >= 96 && int <= 101 {
      returnInt = 5
    } else if int >= 102 {
      returnInt = 6
    } else {
      
    }
    
    return returnInt
    
  }

  @IBAction func readThisBtnPressed(_ sender: Any) {
    let articleUrl = postViewModel.postsArray[activeCell].link
    
    showArticle(of: articleUrl)
    
  }
  func setupBottomButtons() {
    self.view.bringSubview(toFront: readThisButton)
    //REPURPOSE THE BELOW FOR POSITION COUNTER ON LEFT SIDE OF SCREEN
    
    /*
    readThisButton =  UIButton()
    readThisButton.titleLabel?.text = "READ THIS"
    readThisButton.titleLabel?.textColor = UIColor.blue
    readThisButton.titleLabel
    
    
    self.view.addSubview(readThisButton)
    var readThisButtonFrame = readThisButton.frame
    readThisButtonFrame.size.height = 200.0
    readThisButtonFrame.size.width = 300.0
    readThisButtonFrame.origin.x = self.view.frame.width / 2
    readThisButtonFrame.origin.y = self.view.frame.height / 2
    readThisButton.frame = readThisButtonFrame
    */
    
    //constraints
//    let bottomConstraint = NSLayoutConstraint(item: readThisButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
//    let rightConstraint = NSLayoutConstraint(item: readThisButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
//    self.view.addConstraints([bottomConstraint, rightConstraint])
//    
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}


