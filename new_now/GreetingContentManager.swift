//
//  GreetingContentManager.swift
//  new_now
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit
class GreetingContentManager: NSObject {
  
//  //access item type directory, add each item in
//  func fetchCachedPosts(_ itemType: ItemCacheType) -> Array<PostModel> {
//    var postsArray = Array<PostModel>()
//    //hardcoding item type as was receiving error
//    let postDirectory = MainCacheManager.cacheLocationForItemType(ItemCacheType.postHomePage)
//    let fileManager = FileManager.default
//    if let subPaths = fileManager.subpaths(atPath: postDirectory) {
//      for path in subPaths {
//        if path != ".DS_Store" {
//          let cachedPostPath = (postDirectory as NSString).appendingPathComponent(path)
//          let item = NSKeyedUnarchiver.unarchiveObject(withFile: cachedPostPath)
//          if let cachedPost = item as? PostModel {
//            postsArray.append(cachedPost)
//          }
//        }
//      }
//    }
//    return postsArray
//  }
//  

//  
//  func isPostCachePresent(_ contentItem: ContentItemModel, itemType: ItemCacheType) -> Bool {
//    let postArray = fetchCachedPosts(itemType)
//    let isPresent = false
//    if postArray.count > 0 {
//      for post in postArray {
//        if post.identifier == contentItem.identifier {
//          return true
//        }
//      }
//    }
//    return isPresent
//  }
  
  static func loadGreeting(withCompletion completion: @escaping (GreetingModel?) -> Void) {
    //    guard Reachability.connectedToNetwork() else {
    //      completion(nil)
    //      return
    //    }
    GreetingAPIManager.fetchGreetingWithCompletion(comp: { greetingArray in
      guard let greetingRaw = greetingArray else {
        completion(nil)
        return
      }
      
      
      if let greeting = GreetingModel(dictionary: greetingRaw) {
        let newGreetingFilePath = MainCacheManager.cacheLocationForObject(greeting, itemType: ItemCacheType.greetingLaunchScreen)
        MainCacheManager.cacheInformationForItem(greeting, filePath: newGreetingFilePath)
        completion(greeting)


      } else {
        completion(nil)
        return
      }
     


    })
  }

  
  
}
