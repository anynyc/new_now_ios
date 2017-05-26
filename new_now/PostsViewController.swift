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
      let post = postViewModel.postsArray[indexPath.row]
      let topicText = postViewModel.postsArray[indexPath.row].category
      let attributedString = NSMutableAttributedString(string: topicText)
      attributedString.addAttribute(NSKernAttributeName, value: 2.0, range: NSMakeRange(0, topicText.characters.count))
      cell.topicLabel.attributedText = attributedString
      let bodyText = postViewModel.postsArray[indexPath.row].body
      let image = postViewModel.postsArray[indexPath.row].image
      cell.imageView.image = image
      
      let lineArray = getIndividualLines(string: bodyText)
//      var newSpacedBodyText = ""
      
      //check if cell is visible.  if visible update the read this
      let rValue = Int(post.rValue)
      let gValue = Int(post.gValue)
      let bValue = Int(post.bValue)
      let aValue = Double(post.aValue)
      
      cell.rValue = rValue
      cell.gValue = gValue
      cell.bValue = bValue
      cell.aValue = aValue
      
      let backgroundColor = UIColor(red: CGFloat(rValue!) / 255, green: CGFloat(gValue!) / 255, blue: CGFloat(bValue!) / 255, alpha: CGFloat(aValue!))



      let foregroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
      let fullAttributedString = NSMutableAttributedString()
      var count = 1
      for line in lineArray {
        var lineWithDot = ""
        if count >= lineArray.count {
          lineWithDot = "\(line)."
          //need to make each line its own attributed string. adding the . and new line.  foreground color to cover the . at end giving illusion of padding
          let attributedText = NSMutableAttributedString(string: lineWithDot)
          //add purple background for entire string
          attributedText.addAttribute(NSBackgroundColorAttributeName, value: backgroundColor, range: NSRange(location: 0, length: lineWithDot.characters.count - 1))
          attributedText.addAttribute(NSForegroundColorAttributeName, value: foregroundColor, range: NSRange(location: 0, length: lineWithDot.characters.count - 1))
          attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.clear, range: NSRange(location: lineWithDot.characters.count - 1, length: 1))
          fullAttributedString.append(attributedText)
          count += 1
        } else {
          lineWithDot = "\(line).\n"
          //need to make each line its own attributed string. adding the . and new line.  foreground color to cover the . at end giving illusion of padding
          let attributedText = NSMutableAttributedString(string: lineWithDot)
          //add purple background for entire string
          attributedText.addAttribute(NSBackgroundColorAttributeName, value: backgroundColor, range: NSRange(location: 0, length: lineWithDot.characters.count - 1))
          attributedText.addAttribute(NSForegroundColorAttributeName, value: foregroundColor, range: NSRange(location: 0, length: lineWithDot.characters.count - 1))
          attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.clear, range: NSRange(location: lineWithDot.characters.count - 2, length: 1))
          fullAttributedString.append(attributedText)
          count += 1
        }

//        
//        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: lineWithDot.characters.count - 1, length: 1))

        
      }
      //attributed text for body.  background color DYNAMIC BG COLOR. will pull from backend
//      let backgroundColor = UIColor(red: 80 / 255, green: 68 / 255, blue: 231 / 255, alpha: 0.76)

//      let attributes = [
//        NSBackgroundColorAttributeName : backgroundColor,
//        NSForegroundColorAttributeName : UIColor.white,
//      ]
//      //do the below for every line in line Array. make attributed body string array
//      let attributedBodyString = NSAttributedString(string: newSpacedBodyText, attributes: attributes)
//      let mutableBodyString = NSMutableAttributedString()
//      mutableBodyString.append(attributedBodyString)
//     
//      // Define paragraph styling
//      let paraStyle = NSMutableParagraphStyle()
//      paraStyle.firstLineHeadIndent = 15.0
//      paraStyle.paragraphSpacingBefore = 10.0
//      paraStyle.tailIndent = 10.0
//      paraStyle.minimumLineHeight = 100.0
//      
//      
//      // Apply paragraph styles to paragraph
//      mutableBodyString.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0,length: newSpacedBodyText.characters.count))
//      
      

      
      //want to append each individual line here. need to find line breaks in attribute body string
//      cell.bodyLabel.attributedText = attributedBodyString
//      cell.bodyLabelContainer.addTarget(self, action: #selector(goToGoogle), for: .touchUpInside)
      cell.bodyLabel.attributedText = fullAttributedString

      let gesture = UITapGestureRecognizer(target: self, action:  #selector(articleBtnPressed))
      cell.bodyLabelContainer.addGestureRecognizer(gesture)

      //build box with same background color next to text
      //get number of lines being used * line height.  Set height of preBodyBackground.
      //height brefore sizeToFit()
//      let preHeightBeforeSizeToFit = cell.bodyLabel.frame.size
      //height after sizeToFit
      let preBodySize = cell.bodyLabel.sizeThatFits(cell.bodyLabel.frame.size)
//      let preHeight = cell.bodyLabel.sizeToFit()
      //origin.y needs to be dynamic as well
      cell.preBodyBackground.backgroundColor = backgroundColor
      cell.preBodyBackground.frame.size.height = preBodySize.height
      cell.articleUrl = postViewModel.postsArray[indexPath.row].link
      cell.isHidden = false
      
//      feedbackGenerator?.notificationOccurred(.success)     // Trigger the haptic feedback.
      
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
      
     //maybe depending on height of body label or size to fit I can calculate origin.y??  
      //Does this work on different screen sizes?  what are the other heights if 1 or 4 and 5 lines?
      if preBodySize.height == 127.5 {
        //3 lines

        cell.preBodyBackground.frame.origin.y = 332.249777

      } else if preBodySize.height == 170 {
        //4 lines
        cell.preBodyBackground.frame.origin.y = 311.4

      } else if preBodySize.height == 212.5 {
        //5 lines 
        cell.preBodyBackground.frame.origin.y = 290.4

      } else if preBodySize.height == 85 {
        //2 lines
        cell.preBodyBackground.frame.origin.y = 353.4

      } else if preBodySize.height == 42.5 {
        //1 line
        cell.preBodyBackground.frame.origin.y = 374.4
      }
      
      
      return cell

    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gratificationCell", for: indexPath) as! GratificationCell
      cell.isHidden = false
      cell.imageView.image = postViewModel.gratification!.image
      
      //if no lat long show alternate message and hide button.  locationAllowed Boolean on prefs?
      let prefs = UserDefaults.standard
      if prefs.string(forKey: "locationGiven") == "true" {
        cell.messageLabel.text = postViewModel.gratification!.message
        
        //button in place of read this with proper click event
//        cell.buttonLabel.setTitle(postViewModel.gratification!.buttonLabel, for: .normal)
//        cell.buttonLabel.addTarget(self, action: #selector(goToGoogle), for: .touchUpInside)

      } else {
        cell.messageLabel.text = postViewModel.gratification!.alternateMessage
        cell.buttonLabel.isHidden = true
      }
      cell.titleLabel.text = postViewModel.gratification!.title
      cell.searchTerm = postViewModel.gratification!.keyword
      

      return cell
    }

    
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if let myCell = cell as? ImageCell {
      
      let rValue = myCell.rValue
      let gValue = myCell.gValue
      let bValue = myCell.bValue
      let aValue = myCell.aValue
      
      let backgroundColor = UIColor(red: CGFloat(rValue!) / 255, green: CGFloat(gValue!) / 255, blue: CGFloat(bValue!) / 255, alpha: CGFloat(aValue!))
      
      self.readThisButton?.setTitleColor(backgroundColor, for: .normal)
      self.view.setNeedsLayout()
      self.view.layoutIfNeeded()
      self.counterLabel?.textColor = backgroundColor
      self.view.setNeedsLayout()
      self.view.layoutIfNeeded()
      
      var topicTransform = CGAffineTransform.identity
      topicTransform = topicTransform.translatedBy(x: 25, y: 0)
      topicTransform = topicTransform.rotated(by: CGFloat.pi / 2)
      // ... add as many as you want, then apply it to to the view
      myCell.topicLabel.transform = topicTransform
      myCell.topicLabel.alpha = 0
      
      
      
      
      var bodyTextTransform = CGAffineTransform.identity
      bodyTextTransform = bodyTextTransform.translatedBy(x: -10, y: 0)
      myCell.bodyLabelContainer.transform = bodyTextTransform
      myCell.preBodyBackground.transform = bodyTextTransform
      myCell.bodyLabelContainer.alpha = 0
      myCell.preBodyBackground.alpha = 0
      
      
      var imageTransform = CGAffineTransform.identity
      imageTransform = imageTransform.translatedBy(x: 0, y: 0)
      imageTransform = imageTransform.scaledBy(x: 0.96, y: 0.96)
      myCell.imageView.transform = imageTransform
      
      
      
      
      UIView.animate(withDuration: 0.2, delay: 0.2, animations: { () -> Void in
        
        var bodyTextFinish = CGAffineTransform.identity
        bodyTextFinish = bodyTextFinish.translatedBy(x: 0, y: 0)
        myCell.bodyLabelContainer.transform = bodyTextFinish
        myCell.preBodyBackground.transform = bodyTextFinish
        myCell.preBodyBackground.alpha = 1
        myCell.bodyLabelContainer.alpha = 1
        
      })
      
      UIView.animate(withDuration: 0.25, delay: 0.2, animations: { () -> Void in
        
        //      myCell?.bodyLabelContainer.alpha = 1
        //      myCell?.preBodyBackground.alpha = 1
        var topicFinish = CGAffineTransform.identity
        topicFinish = topicFinish.translatedBy(x: 0, y: 0)
        topicFinish = topicFinish.rotated(by: CGFloat.pi / 2)
        myCell.topicLabel.transform = topicFinish
        myCell.topicLabel.alpha = 1
        
      })
      
      UIView.animate(withDuration: 0.25, animations: { () -> Void in
        
        var imageFinish = CGAffineTransform.identity
        imageFinish = imageFinish.translatedBy(x: 0, y: 0)
        imageFinish = imageFinish.scaledBy(x: 1, y: 1)
        myCell.imageView.transform = imageFinish
        
      })
      
    } else {
      if let myCell = cell as? GratificationCell {
        self.showMeWhereButton.isHidden = false
        self.view.bringSubview(toFront: self.showMeWhereButton)
        self.showMeWhereButton.setNeedsLayout()
        self.showMeWhereButton.layoutIfNeeded()
        self.readThisButton.isUserInteractionEnabled = false
      }
    }

  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //if making non active cells invisible, this will be the only cell with visible attributes
    if indexPath.row != 7 {
      self.readThisButton.isHidden = false
      self.readThisButton.isUserInteractionEnabled = true
      self.counterLabel.isHidden = false
      self.totalCountLabel.isHidden = false
      self.latLabelText.isHidden = false
      self.longLabelText.isHidden = false
      self.showMeWhereButton.isHidden = true
      self.showMeWhereButton.isUserInteractionEnabled = false
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      self.readThisButton.setTitle(postViewModel.postsArray[indexPath.row].linkText, for: .normal)
      
    } else {
      
      self.readThisButton.isHidden = true
      self.readThisButton.isUserInteractionEnabled = false
      self.showMeWhereButton.isUserInteractionEnabled = true

      self.counterLabel.isHidden = true
      self.totalCountLabel.isHidden = true
      self.latLabelText.isHidden = true
      self.longLabelText.isHidden = true
//      self.view.sendSubview(toBack: self.slider)
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

  }
  
  
  
  func getIndividualLines(string: String) -> [String] {
    
    
    let wordArray = string.components(separatedBy: " ")
    let max = 16
    var individualLineArray = [String]()
    var currentLine = ""
    var firstWord = true
    
    for word in wordArray {
      let wordLength = word.characters.count
      //if adding this word to current line is less than max
      if currentLine.characters.count + wordLength < max {
        //if first word add without space in front
        if firstWord == true {
          currentLine.append(word)
          firstWord = false
        } else {
          let spacedWord = " \(word)"
          currentLine.append(spacedWord)
        }
      } else {
        currentLine.append(" ")
        individualLineArray.append(currentLine)
        currentLine = ""
        currentLine.append(word)
      }
    }
    
    individualLineArray.append("\(currentLine) ")
    return individualLineArray
  }
}



class PostsViewController: BaseViewController, PostViewModelDelegate {
  
  var gridCollectionView: UICollectionView!
  var gridLayout: GridLayout!
  var slider: BWCircularSlider!
  var toolTip: ToolTipView!
  var activeCell = 0
  let fullImageView = UIImageView()
  var feedbackGenerator: UINotificationFeedbackGenerator?    // Declare the generator type.
  @IBOutlet weak var anyLogo: UIImageView!

  @IBOutlet weak var counterLabel: UILabel!
  
  @IBOutlet weak var youAreHereLabel: UILabel!
  @IBOutlet weak var totalCountLabel: UILabel!
  @IBInspectable var startColor:UIColor = UIColor.red
  @IBInspectable var endColor:UIColor = UIColor.blue
  
  @IBOutlet weak var showMeWhereButton: UIButton!
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
      latLabelText.isHidden = true
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
      longLabelText.isHidden = true
      showYouAreHere()
//      longLabelText.text = "-45.14"

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
    gridCollectionView.isScrollEnabled = false

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

    
//    let sliderYPositionMultiplier = CGFloat(0.73)
    let sliderYPositionMultiplier = CGFloat(0.68)


    let sliderYPosition = self.view.frame.size.height * sliderYPositionMultiplier
    
    slider = BWCircularSlider(startColor:self.startColor, endColor:self.endColor, frame: CGRect(x: 0, y: sliderYPosition, width: self.view.frame.size.width, height: self.view.frame.size.height / 2))

    // Attach an Action and a Target to the slider
    slider.addTarget(self, action: #selector(valueChanged), for: UIControlEvents.valueChanged)
    self.view.addSubview(slider)
    

    setupBottomButtons()

    
  }

  func valueChanged(slider:BWCircularSlider){
    //depending on the angle value reveal certain card
    if toolTip != nil {
      clearToolTip()
    }
    
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
    
    
    //animate any logo up and then on completion do this transition
    
    
    UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
      self.anyLogo.frame.origin.y = self.anyLogo.frame.origin.y - 16
      
    }, completion:  { (finished: Bool) in
      self.anyLogo.frame.origin.y = self.anyLogo.frame.origin.y + 16

      let transition: CATransition = CATransition()
      transition.duration = 0.4
      transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      transition.type = kCATransitionFade
      self.navigationController?.view.layer.add(transition, forKey: nil)
      
      let webViewStoryboard = StoryboardInstanceConstants.webView
      let webViewController = webViewStoryboard.instantiateViewController(withIdentifier: VCNameConstants.webView) as! WebViewController
      webViewController.urlString = link
      self.navigationController?.pushViewController(webViewController, animated: false)
      
      
    })
    

    

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
  
  func articleBtnPressed(_ sender: Any) {
    let articleUrl = postViewModel.postsArray[activeCell].link
    
    showArticle(of: articleUrl)
  }
  func setupBottomButtons() {
    self.view.bringSubview(toFront: readThisButton)
    self.view.bringSubview(toFront: anyLogo)
    
    let prefs = UserDefaults.standard
    if prefs.string(forKey: "returningVisitor") != "true" {
      toolTip = ToolTipView()
      toolTip.setupView(superView: self.view)
      toolTip.animateHand()
      self.view.addSubview(toolTip)
      self.view.bringSubview(toFront: slider)
    }
  
    
    
    
    


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
    let anyTopConstraint = NSLayoutConstraint(item: anyLogo, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 40.0)
    
    
    self.view.addConstraints([anyLeadingConstraint, anyTopConstraint])
    
    //LatLabel bottom constraint added programmatically
    
    let latSpaceMultiplier = CGFloat(0.00449)
    let latSpaceDistance = screenHeight * latSpaceMultiplier
    
    let latSpaceConstraint = NSLayoutConstraint(item: latLabelText, attribute: .bottom, relatedBy: .equal, toItem: longLabelText, attribute: .top, multiplier: 1, constant: latSpaceDistance)
    
    self.view.addConstraints([latSpaceConstraint])
    
    
    
    
  }
  
//  func goToGoogle(_button : UIButton) {
//    let searchTerm = postViewModel.gratification!.keyword
//    let searchArray = searchTerm.characters.split{$0 == " "}.map(String.init)
//    let searchString = searchArray.joined(separator: "+")
//    let urlBaseString = "https://www.google.com/maps/search/\(searchString)/@"
//    var lat = ""
//    var long = ""
//    //get user lat and long
//
//    let prefs = UserDefaults.standard
//    
//    if prefs.string(forKey: "latitude") != ""  {
//      let latitude = prefs.string(forKey: "latitude")!
//      if latitude.characters.first! != "-" {
//        let first5 = String(latitude.characters.prefix(5))
//        lat = first5
//      } else {
//        let first6 = String(latitude.characters.prefix(6))
//        lat = first6
//      }
//    } else {
//      //      lat = "-74.45"
//    }
//    if prefs.string(forKey: "longitude") != "" {
//      let longitude = prefs.string(forKey: "longitude")!
//      if longitude.characters.first! != "-" {
//        let first5 = String(longitude.characters.prefix(5))
//        long = first5
//      } else {
//        let first6 = String(longitude.characters.prefix(6))
//        long = first6
//      }
//    } else {
//      //      long = "45.14"
//    }
//    
//    let locationString = "\(lat),\(long)"
//    let fullURLString = urlBaseString + locationString
//    
//    // do other task
//    let webViewStoryboard = StoryboardInstanceConstants.webView
//    let webViewController = webViewStoryboard.instantiateViewController(withIdentifier: VCNameConstants.webView) as! WebViewController
//    webViewController.urlString = fullURLString
//    navigationController?.pushViewController(webViewController, animated: true)
//  }
  
  
  
  func showYouAreHere() {
    youAreHereLabel.isHidden = false
    let screenSize = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    let leadingMultiplier = CGFloat(0.7333333)
    let leadingDistance = screenWidth * leadingMultiplier
    
    //    //constraints. verticalConstraint
    let verticalConstraint:NSLayoutConstraint = NSLayoutConstraint(item: youAreHereLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: anyLogo, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
    let leadingConstraint = NSLayoutConstraint(item: youAreHereLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: leadingDistance)
    self.view.addConstraints([verticalConstraint, leadingConstraint])

  }
  @IBAction func goToGoogle(_ sender: Any) {
    
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
    
    
    UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
      self.anyLogo.frame.origin.y = self.anyLogo.frame.origin.y - 16
      
    }, completion:  { (finished: Bool) in
      self.anyLogo.frame.origin.y = self.anyLogo.frame.origin.y + 16
      
      let transition: CATransition = CATransition()
      transition.duration = 0.4
      transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      transition.type = kCATransitionFade
      self.navigationController?.view.layer.add(transition, forKey: nil)
      
      let webViewStoryboard = StoryboardInstanceConstants.webView
      let webViewController = webViewStoryboard.instantiateViewController(withIdentifier: VCNameConstants.webView) as! WebViewController
      webViewController.urlString = fullURLString
      self.navigationController?.pushViewController(webViewController, animated: false)

      
    })

  }

  func clearToolTip() {
    
      //animate out
    let prefs = UserDefaults.standard
    prefs.set("true", forKey: "returningVisitor")

    
      UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
        
        self.toolTip.alpha = 0
      }, completion:  { (finished: Bool) in
        self.toolTip.isHidden = true
        self.view.bringSubview(toFront: self.readThisButton)
      })


  }
  
}


