//
//  ViewIdentifierConstants.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit

struct VCNameConstants {
  static let launch = "Launch"
  static let posts = "postScreenVC"
  static let webView = "webViewVC"
  static let scrollWebView = "scrollWebViewVC"
}

struct StoryboardInstanceConstants {
  static let launch = UIStoryboard(name: "LaunchViewController", bundle: nil)
  static let webView = UIStoryboard(name: "WebViewController", bundle: nil)
  static let postsScreen = UIStoryboard(name: "PostsViewController", bundle: nil)
  static let scrollWebView = UIStoryboard(name: "ScrollWebViewController", bundle: nil)
  
}

struct NibInstanceConstants {
//  static let favoriteCell = UINib.init(nibName: "FavoritesTableViewCell", bundle: nil)
  
}

struct XibNameConstants {
//  static let favoriteCell = "FavoritesTableViewCell"
  
}
