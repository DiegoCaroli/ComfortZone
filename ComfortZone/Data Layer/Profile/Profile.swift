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
    
    tasks = loadTasks()
  }
  
  private func loadTasks() -> [Task] {
    var tasks: [Task] = []
    if let path = Bundle.main.path(forResource: "Tasks", ofType: "plist") {
      if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
        
        for (key, value) in dict {
          for i in value as! [String] {
            let task = Task(name: i, type: key)
            tasks.append(task)
          }
        }
      }
    }
    return tasks
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
  
  func getTodayTasks() -> [Task] {
    var tasks: [Task] = []
    let adrenalineTasks = self.tasks.filter {$0.type == "Adrenaline" && !$0.isDone }
    let businessTasks = self.tasks.filter {$0.type == "Business" && !$0.isDone }
    let lifestyleTasks = self.tasks.filter {$0.type == "Lifestyle" && !$0.isDone }
    
    if adrenalineScore <= 8  {
      let adrenalineTask = adrenalineTasks[Int(arc4random_uniform(UInt32(adrenalineTasks.count)))]
      tasks.append(adrenalineTask)
    }
    
    if businessScore <= 8 {
      let businessTask = businessTasks[Int(arc4random_uniform(UInt32(businessTasks.count)))]
      tasks.append(businessTask)
    }
    
    if lifestyleScore <= 8 {
      let lifestyleTask = lifestyleTasks[Int(arc4random_uniform(UInt32(lifestyleTasks.count)))]
      tasks.append(lifestyleTask)
    }
    return tasks
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
