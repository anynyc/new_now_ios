//
//  GratificationModel.swift
//  new_now
//
//  Created by Mike on 4/20/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

struct GratificationConstants {
  static let gratificationId = "id"
  static let message = "message"
  static let keyword = "keyword"
  static let alternateMessage = "alternate_message"
  static let imageUrl = "image"
  static let image = "image_url"
  static let title = "title"
  static let buttonLabel = "button_label"
  
  
}

class GratificationModel: ContentItemModel, NSCoding {
  
  var gratificationId: String
  var message: String
  var keyword: String
  var alternateMessage: String
  var imageUrl: URL?
  var image: UIImage?
  var title: String
  var buttonLabel: String

  
  
  
  
  
  override init?(dictionary: [String: AnyObject]) {
    guard let gratId = dictionary[GratificationConstants.gratificationId] as? String else {
      return nil
    }
    gratificationId = gratId
    
    guard let messageText = dictionary[GratificationConstants.message] as? String else {
      return nil
    }
    
    message = messageText
    
    
    guard let keywordText = dictionary[GratificationConstants.keyword] as? String else {
      return nil
    }
    
    keyword = keywordText
    
    guard let alternateText = dictionary[GratificationConstants.alternateMessage] as? String else {
      return nil
    }
    
    alternateMessage = alternateText
    
 
    
    if let imageString = dictionary[GratificationConstants.imageUrl] as? String {
      self.imageUrl = URL(string: imageString)
    }
    
    guard let titleText = dictionary[GratificationConstants.title] as? String else {
      return nil
    }
    
    title = titleText
    
    guard let buttonText = dictionary[GratificationConstants.buttonLabel] as? String else {
      return nil
    }
    
    buttonLabel = buttonText
    
    
    
    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(gratificationId, forKey: GratificationConstants.gratificationId)
    aCoder.encode(message, forKey: GratificationConstants.message)
    aCoder.encode(keyword, forKey: GratificationConstants.keyword)
    aCoder.encode(alternateMessage, forKey: GratificationConstants.alternateMessage)
    aCoder.encode(imageUrl, forKey: GratificationConstants.imageUrl)
    aCoder.encode(image, forKey: GratificationConstants.image)
    aCoder.encode(title, forKey: GratificationConstants.title)
    aCoder.encode(buttonLabel, forKey: GratificationConstants.buttonLabel)

    super.encodeWithEncoder(aCoder)
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard let gratId = aDecoder.decodeObject(forKey: GratificationConstants.gratificationId) as? String else {
      return nil
    }
    gratificationId = gratId
    
    guard let messageText = aDecoder.decodeObject(forKey: GratificationConstants.message) as? String else {
      return nil
    }
    message = messageText
    
    guard let keywordText = aDecoder.decodeObject(forKey: GratificationConstants.keyword) as? String else {
      return nil
    }
    
    keyword = keywordText
    
    guard let alternateText = aDecoder.decodeObject(forKey: GratificationConstants.alternateMessage) as? String else {
      return nil
    }
    
    alternateMessage = alternateText
    
    
    
    if let imageURL = aDecoder.decodeObject(forKey: GratificationConstants.imageUrl) as? URL {
      imageUrl = imageURL
    }
    
    if let imageRaw = aDecoder.decodeObject(forKey: GratificationConstants.image) as? UIImage {
      image = imageRaw
    }
    
    guard let titleText = aDecoder.decodeObject(forKey: GratificationConstants.title) as? String else {
      return nil
    }
    
    title = titleText
    
    guard let buttonText = aDecoder.decodeObject(forKey: GratificationConstants.buttonLabel) as? String else {
      return nil
    }
    
    buttonLabel = buttonText
    
    
    super.init(coder: aDecoder)
  }
  
}
