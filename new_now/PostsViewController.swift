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
    return 8
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    puts(String(indexPath.row))
    if indexPath.row != 7 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
      
      let topicText = postViewModel.postsArray[indexPath.row].category
      let attributedString = NSMutableAttributedString(string: topicText)
      attributedString.addAttribute(NSKernAttributeName, value: 2.0, range: NSMakeRange(0, topicText.characters.count))
      cell.topicLabel.attributedText = attributedString
      let bodyText = postViewModel.postsArray[indexPath.row].body
      let image = postViewModel.postsArray[indexPath.row].image
      cell.imageView.image = image
      
      
      //attributed text for body.  background color
      let backgroundColor = UIColor(red: 80 / 255, green: 68 / 255, blue: 231 / 255, alpha: 0.76)
      let attributes = [
        NSBackgroundColorAttributeName : backgroundColor,
        NSForegroundColorAttributeName : UIColor.white
      ]
      
      let attributedBodyString = NSAttributedString(string: bodyText, attributes: attributes)
      let mutableBodyString = NSMutableAttributedString()
      mutableBodyString.append(attributedBodyString)
     
      // Define paragraph styling
      let paraStyle = NSMutableParagraphStyle()
      paraStyle.firstLineHeadIndent = 15.0
      paraStyle.paragraphSpacingBefore = 10.0
      paraStyle.minimumLineHeight = 100.0
      
      
      // Apply paragraph styles to paragraph
      mutableBodyString.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0,length: bodyText.characters.count))
      
      cell.bodyLabel.attributedText = attributedBodyString
//
//      var text = bodyText
//      
//      let paragraphStyle = NSMutableParagraphStyle()
//      paragraphStyle.paragraphSpacing = 50
//      paragraphStyle.alignment = NSTextAlignment.left
//      paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail
//      
//      let attributes = [
//        NSParagraphStyleAttributeName: paragraphStyle
//      ] as [String : Any]
//      
//      
//      let attributedBodyString = NSAttributedString(string: text, attributes: attributes)
//      
//      cell.bodyLabel.attributedText = attributedBodyString
//      cell.bodyLabel.numberOfLines = 0
//      cell.bodyLabel.textColor = UIColor.white
//      cell.bodyLabel.backgroundColor = UIColor.purple
//      cell.bodyLabel.sizeToFit()
//      
//      
      
      cell.articleUrl = postViewModel.postsArray[indexPath.row].link
      cell.isHidden = false
      
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

    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gratificationCell", for: indexPath) as! GratificationCell
      cell.isHidden = false
      cell.imageView.image = postViewModel.gratification!.image
      
      //if no lat long show alternate message and hide button.  locationAllowed Boolean on prefs?
      let prefs = UserDefaults.standard
      if prefs.string(forKey: "locationGiven") == "true" {
        cell.messageLabel.text = postViewModel.gratification!.message
        cell.buttonLabel.setTitle(postViewModel.gratification!.buttonLabel, for: .normal)
        cell.buttonLabel.addTarget(self, action: #selector(goToGoogle), for: .touchUpInside)
      } else {
        cell.messageLabel.text = postViewModel.gratification!.alternateMessage
        cell.buttonLabel.isHidden = true
      }
      cell.titleLabel.text = postViewModel.gratification!.title
      cell.searchTerm = postViewModel.gratification!.keyword


      return cell
    }


    
  }
  

  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //if making non active cells invisible, this will be the only cell with visible attributes
    if indexPath.row != 7 {
      self.readThisButton.isHidden = false
      self.counterLabel.isHidden = false
      self.totalCountLabel.isHidden = false
      self.latLabelText.isHidden = false
      self.longLabelText.isHidden = false
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      self.readThisButton.setTitle(postViewModel.postsArray[indexPath.row].linkText, for: .normal)
    } else {
      self.readThisButton.isHidden = true
      self.counterLabel.isHidden = true
      self.totalCountLabel.isHidden = true
      self.latLabelText.isHidden = true
      self.longLabelText.isHidden = true
      self.view.sendSubview(toBack: self.slider)
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

  }
}



class PostsViewController: BaseViewController, PostViewModelDelegate {
  
  var gridCollectionView: UICollectionView!
  var gridLayout: GridLayout!
  var slider: BWCircularSlider!
  var activeCell = 0
  let fullImageView = UIImageView()
  var feedbackGenerator: UINotificationFeedbackGenerator?    // Declare the generator type.
  @IBOutlet weak var anyLogo: UIImageView!

  @IBOutlet weak var counterLabel: UILabel!
  
  @IBOutlet weak var totalCountLabel: UILabel!
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
    setUpConstraints()
    setupLogoTap()
    readThisButton.titleLabel?.adjustsFontSizeToFitWidth = true
    let prefs = UserDefaults.standard

    if prefs.string(forKey: "latitude") != ""  {
      let latitude = prefs.string(forKey: "latitude")!
      if latitude.characters.first! != "-" {
        let first5 = String(latitude.characters.prefix(5))
        latLabelText.text = first5
      } else {
        let first6 = String(latitude.characters.prefix(6))
        latLabelText.text = first6
      }
    } else {
      latLabelText.text = "-74.45"
    }
    if prefs.string(forKey: "longitude") != "" {
      let longitude = prefs.string(forKey: "longitude")!
      if longitude.characters.first! != "-" {
        let first5 = String(longitude.characters.prefix(5))
        longLabelText.text = first5
      } else {
        let first6 = String(longitude.characters.prefix(6))
        longLabelText.text = first6
      }
    } else {
      longLabelText.text = "45.14"

    }
    
    let posts = contentManager.fetchCachedPosts(ItemCacheType.postHomePage)
    postViewModel.delegate = self
    postViewModel.postsArray = posts
    
    let gratification = contentManager.fetchCachedGratification(ItemCacheType.gratificationHomePage)
    postViewModel.gratification = gratification
    postViewModel.getGratificationImage()
    
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
    gridCollectionView!.register(GratificationCell.self, forCellWithReuseIdentifier: "gratificationCell")

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
    
    
    // Build the slider.  Changing slider frame size so it only occupies bottom of page and doesn't cover cell
//    slider = BWCircularSlider(startColor:self.startColor, endColor:self.endColor, frame: self.view.bounds)
    
    let sliderYPositionMultiplier = CGFloat(0.74362)
    let sliderYPosition = self.view.frame.size.height * sliderYPositionMultiplier
    
    slider = BWCircularSlider(startColor:self.startColor, endColor:self.endColor, frame: CGRect(x: 0, y: sliderYPosition, width: self.view.frame.size.width, height: self.view.frame.size.height / 2))

    // Attach an Action and a Target to the slider
    slider.addTarget(self, action: #selector(valueChanged), for: UIControlEvents.valueChanged)
    self.view.addSubview(slider)
    
    setupBottomButtons()

    
  }

  func valueChanged(slider:BWCircularSlider){
    //depending on the angle value reveal certain card
    let row = getSection(int: slider.angle)
    if row != activeCell && row != 7 {
      activeCell = row
      counterLabel.text = "0\(row + 1)"
      let indexPath = IndexPath(row: row, section: 0)
      gridCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
      
      //deselecet
      //    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
      gridCollectionView.delegate?.collectionView!(gridCollectionView, didSelectItemAt: indexPath)
    } else if row == 7 {
      activeCell = row
      counterLabel.text = "07"
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
    } else if int >= 102 && int <= 107 {
      returnInt = 6
    } else if int >= 108 {
      returnInt = 7
      
    }
    
    return returnInt
    
  }

  @IBAction func readThisBtnPressed(_ sender: Any) {
    let articleUrl = postViewModel.postsArray[activeCell].link
    
    showArticle(of: articleUrl)
    
  }
  func setupBottomButtons() {
    self.view.bringSubview(toFront: readThisButton)
    self.view.bringSubview(toFront: anyLogo)

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
  
  
  func setupLogoTap() {
    // or for swift 2 +
    let gesture = UITapGestureRecognizer(target: self, action:  #selector(goToAny))
    self.anyLogo.addGestureRecognizer(gesture)
  }
  
  func goToAny(_ sender:UITapGestureRecognizer){
    // do other task
    let anyWebLink = "http://www.weareany.com"
    let webViewStoryboard = StoryboardInstanceConstants.webView
    let webViewController = webViewStoryboard.instantiateViewController(withIdentifier: VCNameConstants.webView) as! WebViewController
    webViewController.urlString = anyWebLink
    navigationController?.pushViewController(webViewController, animated: true)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func setUpConstraints() {
    let screenSize = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    
    //ANY LOGO leading and top constraint added programmatically
    let anyLeadingMultiplier = CGFloat(0.106666)
    let anyTopMultiplier = CGFloat(0.045)
    let anyLeadingDistance = screenWidth * anyLeadingMultiplier
    let anyTopDistance = screenHeight * anyTopMultiplier
    
    let anyLeadingConstraint = NSLayoutConstraint(item: anyLogo, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: anyLeadingDistance)
    let anyTopConstraint = NSLayoutConstraint(item: anyLogo, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: anyTopDistance)
    
    
    self.view.addConstraints([anyLeadingConstraint, anyTopConstraint])
    
    //LatLabel bottom constraint added programmatically
    
    let latSpaceMultiplier = CGFloat(0.00449)
    let latSpaceDistance = screenHeight * latSpaceMultiplier
    
    let latSpaceConstraint = NSLayoutConstraint(item: latLabelText, attribute: .bottom, relatedBy: .equal, toItem: longLabelText, attribute: .top, multiplier: 1, constant: latSpaceDistance)
    
    self.view.addConstraints([latSpaceConstraint])
  }
  
  func goToGoogle(_button : UIButton) {
    let searchTerm = postViewModel.gratification!.keyword
    let searchArray = searchTerm.characters.split{$0 == " "}.map(String.init)
    let searchString = searchArray.joined(separator: "+")
    let urlBaseString = "https://www.google.com/maps/search/\(searchString)/@"
    var lat = ""
    var long = ""
    //get user lat and long

    let prefs = UserDefaults.standard
    
    if prefs.string(forKey: "latitude") != ""  {
      let latitude = prefs.string(forKey: "latitude")!
      if latitude.characters.first! != "-" {
        let first5 = String(latitude.characters.prefix(5))
        lat = first5
      } else {
        let first6 = String(latitude.characters.prefix(6))
        lat = first6
      }
    } else {
      //      lat = "-74.45"
    }
    if prefs.string(forKey: "longitude") != "" {
      let longitude = prefs.string(forKey: "longitude")!
      if longitude.characters.first! != "-" {
        let first5 = String(longitude.characters.prefix(5))
        long = first5
      } else {
        let first6 = String(longitude.characters.prefix(6))
        long = first6
      }
    } else {
      //      long = "45.14"
    }
    
    let locationString = "\(lat),\(long)"
    let fullURLString = urlBaseString + locationString
    
    // do other task
    let webViewStoryboard = StoryboardInstanceConstants.webView
    let webViewController = webViewStoryboard.instantiateViewController(withIdentifier: VCNameConstants.webView) as! WebViewController
    webViewController.urlString = fullURLString
    navigationController?.pushViewController(webViewController, animated: true)
    
  }
}


