//
//  NewNowAPIConstants.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation

struct APIConstants {
  static let newNowApiUrl = "/api/v1"
  static let postUrl = "/posts"
  static let greetingUrl = "/greetings"
  static let pushTokenUrl = "/push_token"
  static let removePushTokenUrl = "/remove_push_token"
}


enum ContentItemError: Error {
  case networkUnreachableError
  case apiError(Error)
  case typeMismatch(String)
  case notFound(String)
  
  var isNetworkUnreachable: Bool {
    switch self {
    case .networkUnreachableError: return true
    default: return false
    }
  }
}
