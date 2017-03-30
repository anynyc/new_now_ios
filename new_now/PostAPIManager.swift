//
//  PostAPIManager.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import Alamofire


struct PostAPIConstants {
  static let posts = "posts"
}

class PostAPIManager: NSObject {
  
  
  static func fetchPostsWithCompletion(comp: @escaping ([[String: AnyObject]]?) -> Void) {
    let baseUrl = "https://329cbcb8.ngrok.io"
    
    let postUrlString = baseUrl + APIConstants.newNowApiUrl + APIConstants.postUrl
    
    guard let postUrl = URL(string: postUrlString) else {
      print("CAPI: contacts url failed")
      comp([[String: AnyObject]]())
      return
    }
    
    Alamofire.request(postUrl, encoding: URLEncoding.default).responseJSON { response in
      guard let jsonDict = response.result.value as? [String: AnyObject] else {
        comp(nil)
        return
      }
      if let postDictArray = jsonDict["posts"] as? [[String: AnyObject]], postDictArray.count > 0 {
        comp(postDictArray)
      } else {
        comp(nil)
      }
    }
  }
  
  static func fetchImageWithCompletion(_ post: PostModel, comp: @escaping (UIImage?) -> Void) {
    guard let url = post.imageUrl else {
      comp(nil)
      return
    }
    let urlString = "https://329cbcb8.ngrok.io" + "\(url)"
    
    guard let imageUrl = URL(string: urlString) else {
      print("CAPI: contacts url failed")
      comp(nil)
      return
    }
    
//    URLCache.shared.removeAllCachedResponses()
    
    Alamofire.request(imageUrl, encoding: URLEncoding.default).responseJSON { response in
      guard let imageData = response.data else {
        comp(nil)
        return
      }
      guard let image = UIImage(data: imageData) else {
        comp(nil)
        return
      }
      comp(image)
    }
  }
  
  
  
  
}
