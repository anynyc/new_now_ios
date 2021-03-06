//
//  PostContentManager.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit


struct ContentConstants {
  static let pushToken = "pushtoken"
  static let storedPushToken = "storedpushtoken"


}

class PostContentManager: NSObject {
  
  //access item type directory, add each item in
  func fetchCachedPosts(_ itemType: ItemCacheType) -> Array<PostModel> {
    var postsArray = Array<PostModel>()
    //hardcoding item type as was receiving error
    let postDirectory = MainCacheManager.cacheLocationForItemType(ItemCacheType.postHomePage)
    let fileManager = FileManager.default
    if let subPaths = fileManager.subpaths(atPath: postDirectory) {
      for path in subPaths {
        if path != ".DS_Store" {
          let cachedPostPath = (postDirectory as NSString).appendingPathComponent(path)
          let item = NSKeyedUnarchiver.unarchiveObject(withFile: cachedPostPath)
          if let cachedPost = item as? PostModel {
            postsArray.append(cachedPost)
          }
        }
      }
    }
    
//    postsArray.sorted({ $0.position > $1.position })
    return postsArray.sorted(by: { $0.position > $1.position })
  }
  
  func fetchCachedGratification(_ itemType: ItemCacheType) -> GratificationModel? {
    let gratificationDirectory = MainCacheManager.cacheLocationForItemType(ItemCacheType.gratificationHomePage)
    let fileManager = FileManager.default
    var gratificationModel: GratificationModel?
    
    if let subPaths = fileManager.subpaths(atPath: gratificationDirectory) {
      for path in subPaths {
        if path != ".DS_Store" {
          let cachedGratificationPath = (gratificationDirectory as NSString).appendingPathComponent(path)
          let item = NSKeyedUnarchiver.unarchiveObject(withFile: cachedGratificationPath)
          if let cachedGratification = item as? GratificationModel {
            gratificationModel = cachedGratification
          }
        }
      }
    }
  
    return gratificationModel
  }
  
  func isPostCachePresent(_ contentItem: ContentItemModel, itemType: ItemCacheType) -> Bool {
    let postArray = fetchCachedPosts(itemType)
    let isPresent = false
    if postArray.count > 0 {
      for post in postArray {
        if post.identifier == contentItem.identifier {
          return true
        }
      }
    }
    return isPresent
  }
  
  static func loadPosts(withCompletion completion: @escaping ([PostModel]?) -> Void) {
    //    guard Reachability.connectedToNetwork() else {
    //      completion(nil)
    //      return
    //    }
    
    MainCacheManager.clearAllCachedPosts()
    MainCacheManager.clearAllCachedGratifications()
    
    
    PostAPIManager.fetchPostsWithCompletion(comp: { contentArray, gratificationArray in
      guard let posts = contentArray, posts.count > 0 else {
        completion(nil)
        return
      }
      
      guard let gratificationRaw = gratificationArray else {
        completion(nil)
        return
      }
      
      
      if let gratification = GratificationModel(dictionary: gratificationRaw) {
        let newGratificationFilePath = MainCacheManager.cacheLocationForObject(gratification, itemType: ItemCacheType.gratificationHomePage)
        MainCacheManager.cacheInformationForItem(gratification, filePath: newGratificationFilePath)
      }
      
      
      var postArray = [PostModel]()
      for postDict in posts {
        if let post = PostModel(dictionary: postDict) {
          let newPostFilePath = MainCacheManager.cacheLocationForObject(post, itemType: ItemCacheType.postHomePage)
          MainCacheManager.cacheInformationForItem(post, filePath: newPostFilePath)
          postArray.append(post)
        }
      }
      completion(postArray)
    })
  }
  
  static func getPostImages(postArray: [PostModel], withCompletion completion: @escaping ([UIImage]?) -> Void) {
    //    VideoAPIManager.fetchEspressoVideosWithCompletion(comp: { contentArray in
    //      guard let videos = contentArray, videos.count > 0 else {
    //        completion(nil)
    //        return
    //      }
    let postArray = postArray
    var imageArray = [UIImage]()
    
    for postModel in postArray {
      PostAPIManager.fetchImageWithCompletion(postModel) { (image) in
        postModel.image = image
        let newPostFilePath = MainCacheManager.cacheLocationForObject(postModel, itemType: ItemCacheType.postHomePage)
        MainCacheManager.cacheInformationForItem(postModel, filePath: newPostFilePath)
        imageArray.append(image!)
      }
      completion(imageArray)
    }
    completion(imageArray)
    
  }
  
  static func getGratificationImage(gratification: GratificationModel, withCompletion completion: @escaping (UIImage?) -> Void) {
    //    VideoAPIManager.fetchEspressoVideosWithCompletion(comp: { contentArray in
    //      guard let videos = contentArray, videos.count > 0 else {
    //        completion(nil)
    //        return
    //      }
    var gratificationImage = UIImage()
    
    let gratificationModel = gratification
      PostAPIManager.fetchGratificationImageWithCompletion(gratificationModel) { (image) in
        gratification.image = image
        let newGratificationFilePath = MainCacheManager.cacheLocationForObject(gratificationModel, itemType: ItemCacheType.gratificationHomePage)
        MainCacheManager.cacheInformationForItem(gratificationModel, filePath: newGratificationFilePath)
        gratificationImage = image!
      }
      completion(gratificationImage)
  }

  static func checkPushToken() {
    let prefs = UserDefaults.standard
    //check for current push token
    var currentPushToken = ""
    var storedPushToken = ""
    if let token = prefs.string(forKey: ContentConstants.pushToken) {
      currentPushToken = token
    }
    
    if let storedToken = prefs.string(forKey: ContentConstants.storedPushToken) {
      storedPushToken = storedToken
    }
    
    if currentPushToken != "" && currentPushToken != storedPushToken {
      //Send currentPushToken to backend and set storedPushToken as currentPushToken in prefs
      PostAPIManager.storePushToken(pushToken: currentPushToken)
      
    } else if currentPushToken == "" && storedPushToken != "" {
      //push token has been removed. 
//      PostAPIManager.removePushToken(pushToken: storedPushToken)
    }
    
    
    
    
  }

  
  
}
