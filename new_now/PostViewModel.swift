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
  
  
  
  func getPostImages() {
    //main.async
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
//    if gameChallengesHomePageArray.count == 0 {
//      DispatchQueue.main.async {
//        self.delegate?.imagesDidLoad()
//      }
//    } else {
      //for game in gameChallengesHomePageArray {
      //checks if the images have already been added to the games from the previously cached games
      guard postIndex <= postsArray.count - 1 else {
        delegate?.imagesDidLoad()
        return
      }
      let post = postsArray[postIndex]
      //this does an asynchronous download of the images on each game
      //adds to the index so that it does it for all games in the game array
      loadImage(post, postIndex)
//    }
  }
  
  func loadImage(_ post: PostModel,_ postIndex: Int) {
//    guard Reachability.connectedToNetwork() else {
//      delegate?.imagesDidLoad()
//      return
////    }
//    guard game.challenger.userProfileImage == nil else {
//      photoIndex += 1
//      gamesDidLoad()
//      return
//    }
    PostAPIManager.fetchImageWithCompletion(post, comp: { [weak self] (image) in
      post.image = image
      guard let i = self?.postIndex else {
        self?.postsDidLoad()
        return
      }
      
      self?.postsArray[i].image = image
      let postFilePath = MainCacheManager.cacheLocationForObject(post, itemType: .postHomePage)
      MainCacheManager.cacheInformationForItem(post, filePath: postFilePath)
      //go back to gamesdidload to check if more photos need to be downloaded
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
