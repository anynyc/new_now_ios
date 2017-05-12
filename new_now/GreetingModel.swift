//
//  GreetingModel.swift
//  new_now
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

struct GreetingConstants {
  static let greetingId = "id"
  static let edition = "edition"
  static let title = "title"

  
  
}

class GreetingModel: ContentItemModel, NSCoding {
  
  var greetingId: String
  var edition: String
  var title: String

  
  
  override init?(dictionary: [String: AnyObject]) {
    guard let greetId = dictionary[GreetingConstants.greetingId] as? String else {
      return nil
    }
    greetingId = greetId
    
    guard let editionText = dictionary[GreetingConstants.edition] as? String else {
      return nil
    }
    
    edition = editionText
    
    
    guard let titleText = dictionary[GreetingConstants.title] as? String else {
      return nil
    }
    
    title = titleText

    super.init(dictionary: dictionary)
  }
  
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(greetingId, forKey: GreetingConstants.greetingId)
    aCoder.encode(edition, forKey: GreetingConstants.edition)
    aCoder.encode(title, forKey: GreetingConstants.title)

    
    super.encodeWithEncoder(aCoder)
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard let greetId = aDecoder.decodeObject(forKey: GreetingConstants.greetingId) as? String else {
      return nil
    }
    greetingId = greetId
    
    guard let editionText = aDecoder.decodeObject(forKey: GreetingConstants.edition) as? String else {
      return nil
    }
    edition = editionText
    
    guard let titleText = aDecoder.decodeObject(forKey: GreetingConstants.title) as? String else {
      return nil
    }
    
    title = titleText
    

    super.init(coder: aDecoder)
  }
  
}
