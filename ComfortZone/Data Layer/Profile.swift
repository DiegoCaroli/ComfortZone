//
//  Profile.swift
//  ComfortZone
//
//  Created by Diego Caroli on 13/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import Foundation
import UIKit

class Profile: Codable {
  
  var firstName = ""
  var lastName = ""
  
  var fullName: String {
    return "\(firstName) \(lastName)"
  }
  
  var email = ""
  
//  var photoProfile: URL?
  var totalScore = 0
  var adrenalineScore = 0
  var businessScore = 0
  var lifestyleScore = 0
  
//  init(name: String, surname: String) {
//    self.name = name
//    self.surname = surname
//    totalScore = 0
//    adrenalineScore = 0
//    businessScore = 0
//    lifestyleScore = 0
//  }
  
  func getComics() -> UIImage {
    switch totalScore {
    case 1...13:
      return #imageLiteral(resourceName: "haveDoneAnswer")
    case 14...22:
      return #imageLiteral(resourceName: "wantToDoAnswer")
   default:
      return #imageLiteral(resourceName: "wouldNotDoAnswer")
    }
  }
  
}

