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
  
  var firstName: String?
  var lastName: String?
  
  var fullName: String {
    guard let firstName = firstName,
      let lastName = lastName else {
        return ""
    }
    return "\(firstName) \(lastName)"
  }
  
  var email: String?
  
  var photoProfile: Photo?
  
  var totalScore: Int
  var adrenalineScore: Int
  var businessScore: Int
  var lifestyleScore: Int
  
  var trophies: [Trophy]
  
  init() {
    totalScore = 0
    adrenalineScore = 0
    businessScore = 0
    lifestyleScore = 0
    
    trophies = [
      Trophy(iconName: "Bug", name: "Bug eater", description: "Eat a bug", isLocked: true),
      Trophy(iconName: "Trophie", name: "Lock Trophy", description: "Wake up early. Go for a walk at sunrise and cook yourself a huge breakfast. Just because.", isLocked: true),
      Trophy(iconName: "ZipLine" , name: "Human zipper", description: "Go to zip lining", isLocked: true),
      Trophy(iconName: "Trophie", name: "Dirty dancer", description: "Drive around, crank your favorite songs and have a dance off at stoplights to make strangers laugh.", isLocked: true),
      Trophy(iconName: "Trophie", name: "Ready for the future", description: "Create your cv", isLocked: true),
      Trophy(iconName: "Trophie", name: "Give me my dessert", description: "Go to a restaurant, order and eat dessert first.", isLocked: true),
      Trophy(iconName: "Trophie", name: "Adventure", description: "Go somewhere you shouldn’t be.", isLocked: true),
      Trophy(iconName: "Trophie", name: "Midnight picnic", description: "Have a midnight picnic.", isLocked: true),
      Trophy(iconName: "Trophie", name: "Give some post-it", description: "Go to your favorite book store, and leave notes in your favorites books for future readers.", isLocked: true),
      Trophy(iconName: "Hug", name: "Free Hugs", description: "Give to a stranger an hug", isLocked: true),
      Trophy(iconName: "Trophie", name: "Business man", description: "Invest 10€ and to gain 11€.", isLocked: true),
      Trophy(iconName: "Trophie", name: "Into the wild", description: "Travel alone.", isLocked: true),
      Trophy(iconName: "Trophie", name: "Fancy lunch", description: "Go to lunch by yourself.", isLocked: true),
      Trophy(iconName: "Karaoke", name: "True singer", description: "Sing karoke in a bar", isLocked: true),
      Trophy(iconName: "Trophie", name: "Wild swimmer", description: "Jump into a lake or something with water with your clothes on.", isLocked: true),
      Trophy(iconName: "Trophie", name: "Explorer", description: "Take a new way home from work.", isLocked: true),
      Trophy(iconName: "Trophie", name: "Learn from your mistakes", description: "Ask for constructive criticism at work.", isLocked: true)
    ]
  }
  
  func getComics() -> UIImage {
    switch totalScore {
    case 1...13:
      return #imageLiteral(resourceName: "wouldNotDoAnswer")
    case 14...22:
      return #imageLiteral(resourceName: "wantToDoAnswer")
   default:
      return #imageLiteral(resourceName: "haveDoneAnswer")
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

struct Trophy: Codable {
  let iconName: String
  var name: String
  let description: String
  var isLocked: Bool
}

