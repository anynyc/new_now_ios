//
//  PostViewModel.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit


protocol PostViewModelDelegate: class {
  func postsDidLoad()
  func noPosts()
  func imagesDidLoad()
  func htmlDidLoad()
}
//store background emoji arrays.  Positive and negative arrays
class PostViewModel: NSObject {
  var postsArray = [PostModel]()
  weak var delegate: PostViewModelDelegate?
  var postImages = [UIImage]()
  var postIndex = 0
  var gratification: GratificationModel?
  var gratificationImage = UIImage()

  
  
  
  //loads all home page games with users, initially without pictures(only photo urls)
  func loadPosts() {
    
    PostContentManager.loadPosts { [weak self] (postArray) in
      guard postArray != nil else {
        //call delegate for custom no more videos message
        return
      }
      //unwrap this
      self?.postsArray = postArray!
      self?.delegate?.postsDidLoad()
      //call delegate method in view to do something with the videos, loading active gif
    }
  }
  
  func getPostHtml() {
    //iterate through all posts. For each one make the call and save html to post Model. use background thread
    DispatchQueue.global(qos: .userInteractive).async { // 1
      DispatchQueue.main.async { // 2
        
        for postModel in self.postsArray {
          
          do {
            if let url = URL(string: postModel.link){
                let myHTMLString = try String(contentsOf: url, encoding: .utf8)
                let htmlString:String! = myHTMLString
              postModel.html = htmlString
              let newPostFilePath = MainCacheManager.cacheLocationForObject(postModel, itemType: ItemCacheType.postHomePage)
              MainCacheManager.cacheInformationForItem(postModel, filePath: newPostFilePath)
              print("Got string for post Model")
            }
            
          } catch let error {
            print("Error: \(error)")
          }
          
          
        }
        self.delegate?.htmlDidLoad()

      }
    }
  }
  
  
  
  func getPostImages() {
    PostContentManager.getPostImages(postArray: postsArray) {[weak self] (imageArray) in
      
      guard imageArray != nil else {
        return
      }
      
      self?.postImages = imageArray!
      self?.delegate?.imagesDidLoad()
    }
  }
  
  //it is called by loadGames after all games finished downloading
  //downloads pictures for users
  func postsDidLoad() {
      //checks if the images have already been added to the games from the previously cached games
      guard postIndex <= postsArray.count - 1 else {
        delegate?.imagesDidLoad()
        return
      }
      let post = postsArray[postIndex]
      //this does an asynchronous download of the images on each game
      //adds to the index so that it does it for all games in the game array
      loadImage(post, postIndex)
    
    
    //check user defaults.  if they have push token send it to back end
    PostContentManager.checkPushToken()
    
  }
  
  func loadImage(_ post: PostModel,_ postIndex: Int) {
//    guard Reachability.connectedToNetwork() else {
//      delegate?.imagesDidLoad()
//      return
////    }
    PostAPIManager.fetchImageWithCompletion(post, comp: { [weak self] (image) in
      post.image = image
      guard let i = self?.postIndex else {
        self?.postsDidLoad()
        return
      }
      
      self?.postsArray[i].image = image
      let postFilePath = MainCacheManager.cacheLocationForObject(post, itemType: .postHomePage)
      MainCacheManager.cacheInformationForItem(post, filePath: postFilePath)
      self?.postIndex += 1
      self?.postsDidLoad()
    })
  }
  
  
  func getGratificationImage() {
    //main.async
    PostContentManager.getGratificationImage(gratification: gratification!) {[weak self] (image) in
      
      guard image != nil else {
        return
      }
      
      self?.gratificationImage = image!
    }
  }
  
  
  
  
}
