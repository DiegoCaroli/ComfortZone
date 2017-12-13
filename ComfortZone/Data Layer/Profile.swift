//
//  Profile.swift
//  ComfortZone
//
//  Created by Diego Caroli on 13/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import Foundation
import UIKit

class Profile {
  
  let name: String
  let surname: String
  
  var fullName: String {
    return "\(name) \(surname)"
  }
  
  var photoProfile: UIImage?
  var totalScore: Int
  var adrenalineScore: Int
  var businessScore: Int
  var lifestyleScore: Int
  
  init(name: String, surname: String) {
    self.name = name
    self.surname = surname
    totalScore = 0
    adrenalineScore = 0
    businessScore = 0
    lifestyleScore = 0
  }
  
  func getComics() -> UIImage? {
    switch totalScore {
    case 1...13:
      return #imageLiteral(resourceName: "haveDoneAnswer")
    case 14...22:
      return #imageLiteral(resourceName: "wantToDoAnswer")
    case 23...27:
      return #imageLiteral(resourceName: "wouldNotDoAnswer")
    default:
      return nil
    }
  }
  
}

