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
  
  var photoProfile: Photo?
  
  var totalScore = 0
  var adrenalineScore = 0
  var businessScore = 0
  var lifestyleScore = 0
  
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

struct Photo: Codable {
  var photoID: Int
  var photoURL: URL {
    let filename = "Photo-\(photoID).jpg"
    return DataModel.shared.documentsDirectory.appendingPathComponent(filename)
  }
  
  func save(image: UIImage) {
    if let data = UIImageJPEGRepresentation(image, 0.5) {
      do {
        try data.write(to: photoURL, options: .atomic)
      } catch {
        print("Error writing file: \(error)")
      }
    }
  }
}

