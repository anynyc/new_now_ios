//
//  GreetingAPIManager.swift
//  new_now
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import Alamofire


struct GreetingAPIConstants {
  static let greeting = "greeting"
}

class GreetingAPIManager: NSObject {
  
  
  static func fetchGreetingWithCompletion(comp: @escaping ([String: AnyObject]?) -> Void) {
//    let baseUrl = "https://27ec82f5.ngrok.io"
    let baseUrl = "https://otheranother.com"

    
    let greetingUrlString = baseUrl + APIConstants.newNowApiUrl + APIConstants.greetingUrl
    
    guard let greetingUrl = URL(string: greetingUrlString) else {
      print("CAPI: contacts url failed")
      comp([String: AnyObject]())
      return
    }
    
    Alamofire.request(greetingUrl, encoding: URLEncoding.default).responseJSON { response in
      guard let jsonDict = response.result.value as? [String: AnyObject] else {
        comp(nil)
        return
      }
      if let greetingDictArray = jsonDict["greeting"] as? [String: AnyObject] {
        
        comp(greetingDictArray)
      } else {
        comp(nil)
      }
    }
  }


  
  
  
}
