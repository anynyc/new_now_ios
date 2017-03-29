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
  static let read = "read"
  static let imageUrl = "image"
  static let image = "image_url"
//  static let timesShared = "times_shared"

  
  
}

class PostModel: ContentItemModel, NSCoding {
  
  var postId: String
  var link: String
  var headline: String
  var body: String
  var read: Bool?
  var imageUrl: URL?
  var image: UIImage?
//  var timesShared: Int
  
  
  
  
  
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
    
    if let userRead = dictionary[PostConstants.read] as? Bool {
      read = userRead
    }
    
    if let imageString = dictionary[PostConstants.imageUrl] as? String {
      self.imageUrl = URL(string: imageString)
    }
    
//    guard let shared = dictionary[PostConstants.timesShared] as? Int else {
//      return nil
//    }
//    
//    timesShared = shared
    
    
    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(postId, forKey: PostConstants.postId)
    aCoder.encode(link, forKey: PostConstants.link)
    aCoder.encode(body, forKey: PostConstants.body)
    aCoder.encode(headline, forKey: PostConstants.headline)
    aCoder.encode(read, forKey: PostConstants.read)
//    aCoder.encode(timesShared, forKey: PostConstants.timesShared)
    aCoder.encode(imageUrl, forKey: PostConstants.imageUrl)
    aCoder.encode(image, forKey: PostConstants.image)
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
   
    if let userRead = aDecoder.decodeObject(forKey: PostConstants.read) as? Bool {
      self.read = userRead
    }
    
    
    
    if let imageURL = aDecoder.decodeObject(forKey: PostConstants.imageUrl) as? URL {
      imageUrl = imageURL
    }
    
    if let imageRaw = aDecoder.decodeObject(forKey: PostConstants.image) as? UIImage {
      image = imageRaw
    }
    
//    guard let shared = aDecoder.decodeObject(forKey: PostConstants.timesShared) as? Int else  {
//     return nil
//    }
//    
//    timesShared = shared
    
    
    super.init(coder: aDecoder)
  }
  
}
