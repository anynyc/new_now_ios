//
//  PostContentManager.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit
class PostContentManager: NSObject {
  
  //access item type directory, add each item in
  func fetchCachedPosts(_ itemType: ItemCacheType) -> Array<PostModel> {
    var postsArray = Array<PostModel>()
    let postDirectory = MainCacheManager.cacheLocationForItemType(itemType)
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
    return postsArray
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
    PostAPIManager.fetchPostsWithCompletion(comp: { contentArray in
      guard let posts = contentArray, posts.count > 0 else {
        completion(nil)
        return
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
  

  
  
}
