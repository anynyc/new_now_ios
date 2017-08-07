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
  static let category = "category"
  static let linkText = "link_text"
  static let rValue = "r_value"
  static let gValue = "g_value"
  static let bValue = "b_value"
  static let aValue = "a_value"
  static let position = "position"
  static let html = "html"

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
  var category: String
  var linkText: String
  var rValue: String
  var gValue: String
  var bValue: String
  var aValue: String
  var position: Int
  var html: String?

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
    
    
    
    if let postHtml = dictionary[PostConstants.html] as? String {
      html = postHtml
    }
    
    
    
    if let imageString = dictionary[PostConstants.imageUrl] as? String {
      self.imageUrl = URL(string: imageString)
    }
    
//    guard let shared = dictionary[PostConstants.timesShared] as? Int else {
//      return nil
//    }
//    
//    timesShared = shared
    
    guard let categoryText = dictionary[PostConstants.category] as? String else {
      return nil
    }
    
    category = categoryText
    
    guard let linkDescription = dictionary[PostConstants.linkText] as? String else {
      return nil
    }
    
    linkText = linkDescription
    
    
    guard let rText = dictionary[PostConstants.rValue] as? String else {
      return nil
    }
    
    rValue = rText
    
    guard let gText = dictionary[PostConstants.gValue] as? String else {
      return nil
    }
    
    gValue = gText
    
    guard let bText = dictionary[PostConstants.bValue] as? String else {
      return nil
    }
    
    bValue = bText
    
    guard let aText = dictionary[PostConstants.aValue] as? String else {
      return nil
    }
    
    aValue = aText
    
    
    guard let positionText = dictionary[PostConstants.position] as? Int else {
      return nil
    }
    
    position = positionText
    
    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(postId, forKey: PostConstants.postId)
    aCoder.encode(link, forKey: PostConstants.link)
    aCoder.encode(body, forKey: PostConstants.body)
    aCoder.encode(headline, forKey: PostConstants.headline)
    aCoder.encode(read, forKey: PostConstants.read)
    aCoder.encode(html, forKey: PostConstants.html)

//    aCoder.encode(timesShared, forKey: PostConstants.timesShared)
    aCoder.encode(linkText, forKey: PostConstants.linkText)
    aCoder.encode(category, forKey: PostConstants.category)
    aCoder.encode(imageUrl, forKey: PostConstants.imageUrl)
    aCoder.encode(image, forKey: PostConstants.image)
    aCoder.encode(rValue, forKey: PostConstants.rValue)
    aCoder.encode(gValue, forKey: PostConstants.gValue)
    aCoder.encode(bValue, forKey: PostConstants.bValue)
    aCoder.encode(aValue, forKey: PostConstants.aValue)
    aCoder.encode(position, forKey: PostConstants.position)

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
    
    if let postHtml = aDecoder.decodeObject(forKey: PostConstants.html) as? String {
      self.html = postHtml
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
    
    guard let categoryText = aDecoder.decodeObject(forKey: PostConstants.category) as? String else {
      return nil
    }
    
    category = categoryText
    
    guard let linkDescription = aDecoder.decodeObject(forKey: PostConstants.linkText) as? String else {
      return nil
    }
    
    linkText = linkDescription
    
    guard let rText = aDecoder.decodeObject(forKey: PostConstants.rValue) as? String else {
      return nil
    }
    
    rValue = rText
    
    
    guard let gText = aDecoder.decodeObject(forKey: PostConstants.gValue) as? String else {
      return nil
    }
    
    gValue = gText
    
    guard let bText = aDecoder.decodeObject(forKey: PostConstants.bValue) as? String else {
      return nil
    }
    
    bValue = bText
    
    guard let aText = aDecoder.decodeObject(forKey: PostConstants.aValue) as? String else {
      return nil
    }
    
    aValue = aText
    
//    guard let positionInt = aDecoder.decodeObject(forKey: PostConstants.position) as? Int else {
//      return nil
//    }
//    
//    position = positionInt
    
    
    let positionInt = aDecoder.decodeInteger(forKey: PostConstants.position)
    position = positionInt
    
    
    super.init(coder: aDecoder)
  }
  
}
