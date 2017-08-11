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
  
  
  static func fetchPostsWithCompletion(comp: @escaping ([[String: AnyObject]]?, [String: AnyObject]?) -> Void) {
//    let baseUrl = "https://27ec82f5.ngrok.io"
    let baseUrl = "https://otheranother.com"

    
    let postUrlString = baseUrl + APIConstants.newNowApiUrl + APIConstants.postUrl
    
    guard let postUrl = URL(string: postUrlString) else {
      print("CAPI: contacts url failed")
      comp([[String: AnyObject]](), [String: AnyObject]())
      return
    }
    
    Alamofire.request(postUrl, encoding: URLEncoding.default).responseJSON { response in
      guard let jsonDict = response.result.value as? [String: AnyObject] else {
        comp(nil, nil)
        return
      }
      if let postDictArray = jsonDict["posts"] as? [[String: AnyObject]], postDictArray.count > 0, let gratificationDictArray = jsonDict["gratification"] as? [String: AnyObject] {
        
        comp(postDictArray, gratificationDictArray)
      } else {
        comp(nil, nil)
      }
    }
  }
  
  static func fetchImageWithCompletion(_ post: PostModel, comp: @escaping (UIImage?) -> Void) {
    guard let url = post.imageUrl else {
      comp(nil)
      return
    }
    
//    let url = post.imageUrl!
//    let urlString = "https://27ec82f5.ngrok.io" + "\(url)"
    let urlString = "https://otheranother.com" + "\(url)"

    
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
  
  static func   fetchGratificationImageWithCompletion(_ gratification: GratificationModel, comp: @escaping (UIImage?) -> Void) {
    guard let url = gratification.imageUrl else {
      comp(nil)
      return
    }
//    let urlString = "https://27ec82f5.ngrok.io" + "\(url)"
    let urlString = "https://otheranother.com" + "\(url)"

    
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
  
  static func storePushToken(pushToken: String) {
    let baseUrl = "https://otheranother.com"
//    let baseUrl = "https://27ec82f5.ngrok.io"

    
    let pushTokenUrlString = baseUrl + APIConstants.newNowApiUrl + APIConstants.pushTokenUrl
    
    guard let pushTokenUrl = URL(string: pushTokenUrlString) else {
      print("CAPI: contacts url failed")
      return
    }
    
    let tokenParams = ["push_token": pushToken]
    
    Alamofire.request(pushTokenUrl, method: .post, parameters: tokenParams, encoding: URLEncoding.default).responseJSON { response in
      guard let jsonDict = response.result.value as? [String: AnyObject] else {
        return
      }
      if let pushTokenDictArray = jsonDict["token"] as? [String: AnyObject] {
        //set prefs storedPushToken equals this returned one
        let prefs = UserDefaults.standard
  
        guard let token = pushTokenDictArray["push_token"] as? String else {
          return
        }
        
        prefs.set(token, forKey: "storedpushtoken")

      } else {
      }
    }
  }
//  
//  static func removePushToken(pushToken: String) {
//    let baseUrl = "http://otheranother.com"
//    //    let baseUrl = "https://27ec82f5.ngrok.io"
//    
//    
//    let pushTokenUrlString = baseUrl + APIConstants.newNowApiUrl + APIConstants.removePushTokenUrl
//    
//    guard let pushTokenUrl = URL(string: pushTokenUrlString) else {
//      print("CAPI: contacts url failed")
//      return
//    }
//    
//    let tokenParams = ["push_token": pushToken]
//    
//    Alamofire.request(pushTokenUrl, method: .delete, parameters: tokenParams, encoding: URLEncoding.default).responseJSON { response in
//      guard let jsonDict = response.result.value as? [String: AnyObject] else {
//        return
//      }
//      if let success = jsonDict["success"] as? [String: AnyObject] {
//        //set prefs storedPushToken equals this returned one
//        let prefs = UserDefaults.standard
//        
//        prefs.set("", forKey: "storedpushtoken")
//        
//      } else {
//      }
//    }
//  }
  
  
  
  
}
