//
//  GreetingViewModel.swift
//  new_now
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import Foundation
import UIKit


protocol GreetingViewModelDelegate: class {
  func greetingDidLoad()
  func noGreeting()
}
//store background emoji arrays.  Positive and negative arrays
class GreetingViewModel: NSObject {
  weak var delegate: GreetingViewModelDelegate?
  var greeting: GreetingModel?
  
  
  
  
  //loads all home page games with users, initially without pictures(only photo urls)
  func loadGreeting() {
    
    GreetingContentManager.loadGreeting { [weak self] (greeting) in
      guard greeting != nil else {
        //call delegate for custom no more videos message
        return
      }
      //unwrap this
      self?.greeting = greeting!
      self?.delegate?.greetingDidLoad()
      //call delegate method in view to do something with the videos, loading active gif
    }
  }
  
  
  

  
  //it is called by loadGames after all games finished downloading
  //downloads pictures for users
  func greetingDidLoad() {

  }
  

  

  
  
  
}
