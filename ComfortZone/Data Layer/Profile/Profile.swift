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
  var happiness: Int
  
  var tasks: [Task] = []
  var trophies: [Trophy]
  var memories: [Photo] = []
  
  init() {
    totalScore = 0
    adrenalineScore = 0
    businessScore = 0
    lifestyleScore = 0
    happiness = 4
    
    trophies = [
      Trophy(iconName: "Bug", name: "Bug eater", description: "Eat a bug"),
      Trophy(iconName: "Trophie", name: "Sunrise watcher", description: "Wake up early. Go for a walk at sunrise and cook yourself a huge breakfast. Just because"),
      Trophy(iconName: "ZipLine" , name: "Human zipper", description: "Go to zip lining"),
      Trophy(iconName: "Trophie", name: "Dirty dancer", description: "Drive around, crank your favorite songs and have a dance off at stoplights to make strangers laugh"),
      Trophy(iconName: "Trophie", name: "Ready for the future", description: "Create your cv"),
      Trophy(iconName: "Trophie", name: "Give me my dessert", description: "Go to a restaurant, order and eat dessert first"),
      Trophy(iconName: "Trophie", name: "Adventure", description: "Go somewhere you shouldn’t be"),
      Trophy(iconName: "Trophie", name: "Midnight picnic", description: "Have a midnight picnic"),
      Trophy(iconName: "Trophie", name: "Give some post-it", description: "Go to your favorite book store, and leave notes in your favorites books for future readers"),
      Trophy(iconName: "Hug", name: "Free Hugs", description: "Give to a stranger an hug"),
      Trophy(iconName: "Trophie", name: "Business man", description: "Invest 10€ and to gain 11€"),
      Trophy(iconName: "Trophie", name: "Into the wild", description: "Travel alone"),
      Trophy(iconName: "Trophie", name: "Fancy lunch", description: "Go to lunch by yourself"),
      Trophy(iconName: "Karaoke", name: "True singer", description: "Sing karoke in a bar"),
      Trophy(iconName: "Trophie", name: "Wild swimmer", description: "Jump into a lake or something with water with your clothes on"),
      Trophy(iconName: "Trophie", name: "Explorer", description: "Take a new way home from work"),
      Trophy(iconName: "Trophie", name: "Learn from your mistakes", description: "Ask for constructive criticism at work")
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
  
  func update(score: Int, task: Task) {
    switch task.type {
    case "Adrenaline":
      adrenalineScore += score
    case "Business":
      businessScore += score
    case "Lifestyle":
      lifestyleScore += score
    default:
      return
    }
  }
  
  func isThereATrophy(isLocked: Bool, task: Task) -> Bool {
     if let i = trophies.index(where: { $0.description == task.name }) {
      toogleLockedTrophy(isLocked: isLocked, index: i)
      return true
    }
    return false
  }

  private func toogleLockedTrophy(isLocked: Bool, index: Int) {
      trophies[index].isLocked = isLocked
  }
  
}
