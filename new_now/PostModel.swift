//
//  PostModel.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

struct PostConstants {
  static let postId = "id"
  static let link = "link"
  static let headline = "headline"
  static let body = "body"

  
  
}

class PostModel: ContentItemModel, NSCoding {
  
  var postId: String
  var link: String
  var headline: String
  var body: String
  
  
  
  
  
  override init?(dictionary: [String: AnyObject]) {
    guard let post = dictionary[PostConstants.postId] as? String else {
      return nil
    }
    postId = post
    
    guard let linkURL = dictionary[PostConstants.link] as? String else {
      return nil
    }
    
    link = linkURL


    guard let headlineText = dictionary[PostConstants.headline] as? String else {
      return nil
    }
    
    headline = headlineText
    
    guard let bodyText = dictionary[PostConstants.body] as? String else {
      return nil
    }
    
    body = bodyText
    
    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(postId, forKey: PostConstants.postId)
    aCoder.encode(link, forKey: PostConstants.link)
    aCoder.encode(body, forKey: PostConstants.body)
    aCoder.encode(headline, forKey: PostConstants.headline)
    
    super.encodeWithEncoder(aCoder)
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard let post = aDecoder.decodeObject(forKey: PostConstants.postId) as? String else {
      return nil
    }
    postId = post
    
    guard let linkURL = aDecoder.decodeObject(forKey: PostConstants.link) as? String else {
      return nil
    }
    link = linkURL
    
    guard let headlineText = aDecoder.decodeObject(forKey: PostConstants.headline) as? String else {
      return nil
    }
    
    headline = headlineText
    
    guard let bodyText = aDecoder.decodeObject(forKey: PostConstants.body) as? String else {
      return nil
    }
    
    body = bodyText
    
    
    super.init(coder: aDecoder)
  }
  
}
