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
      Trophy(iconName: "Bug", name: "Bug eater", description: "Eat a bug", isLocked: true),
      Trophy(iconName: "Trophie", name: "Sunrise watcher", description: "Wake up early. Go for a walk at sunrise and cook yourself a huge breakfast. Just because", isLocked: true),
      Trophy(iconName: "ZipLine" , name: "Human zipper", description: "Go to zip lining", isLocked: true),
      Trophy(iconName: "Trophie", name: "Dirty dancer", description: "Drive around, crank your favorite songs and have a dance off at stoplights to make strangers laugh", isLocked: true),
      Trophy(iconName: "Trophie", name: "Ready for the future", description: "Create your cv", isLocked: true),
      Trophy(iconName: "Trophie", name: "Give me my dessert", description: "Go to a restaurant, order and eat dessert first", isLocked: true),
      Trophy(iconName: "Trophie", name: "Adventure", description: "Go somewhere you shouldn’t be", isLocked: true),
      Trophy(iconName: "Trophie", name: "Midnight picnic", description: "Have a midnight picnic", isLocked: true),
      Trophy(iconName: "Trophie", name: "Give some post-it", description: "Go to your favorite book store, and leave notes in your favorites books for future readers", isLocked: true),
      Trophy(iconName: "Hug", name: "Free Hugs", description: "Give to a stranger an hug", isLocked: true),
      Trophy(iconName: "Trophie", name: "Business man", description: "Invest 10€ and to gain 11€", isLocked: true),
      Trophy(iconName: "Trophie", name: "Into the wild", description: "Travel alone", isLocked: true),
      Trophy(iconName: "Trophie", name: "Fancy lunch", description: "Go to lunch by yourself", isLocked: true),
      Trophy(iconName: "Karaoke", name: "True singer", description: "Sing karoke in a bar", isLocked: true),
      Trophy(iconName: "Trophie", name: "Wild swimmer", description: "Jump into a lake or something with water with your clothes on", isLocked: true),
      Trophy(iconName: "Trophie", name: "Explorer", description: "Take a new way home from work", isLocked: true),
      Trophy(iconName: "Trophie", name: "Learn from your mistakes", description: "Ask for constructive criticism at work", isLocked: true)
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
    let adrenalineTasks = self.tasks.filter {$0.type == "Adrenaline" && !$0.isChecked }
    let businessTasks = self.tasks.filter {$0.type == "Business" && !$0.isChecked }
    let lifestyleTasks = self.tasks.filter {$0.type == "Lifestyle" && !$0.isChecked }
    
    if adrenalineScore <= 8 && businessScore <= 8 && lifestyleScore <= 8 {
      let adrenalineTask = adrenalineTasks[Int(arc4random_uniform(UInt32(adrenalineTasks.count)))]
      let businessTask = businessTasks[Int(arc4random_uniform(UInt32(businessTasks.count)))]
      let lifestyleTask = lifestyleTasks[Int(arc4random_uniform(UInt32(lifestyleTasks.count)))]
    
      tasks = [adrenalineTask, businessTask, lifestyleTask]
    } else if adrenalineScore == 9 && businessScore <= 8 && lifestyleScore <= 8 {
      let businessTask = businessTasks[Int(arc4random_uniform(UInt32(businessTasks.count)))]
      let lifestyleTask = lifestyleTasks[Int(arc4random_uniform(UInt32(lifestyleTasks.count)))]
      
      tasks = [businessTask, lifestyleTask]
    } else if adrenalineScore <= 8 && businessScore == 9 && lifestyleScore <= 8 {
      let adrenalineTask = adrenalineTasks[Int(arc4random_uniform(UInt32(adrenalineTasks.count)))]
      let lifestyleTask = lifestyleTasks[Int(arc4random_uniform(UInt32(lifestyleTasks.count)))]
      
      tasks = [adrenalineTask, lifestyleTask]
    } else if adrenalineScore <= 8 && businessScore <= 8 && lifestyleScore == 9 {
      let adrenalineTask = adrenalineTasks[Int(arc4random_uniform(UInt32(adrenalineTasks.count)))]
      let businessTask = businessTasks[Int(arc4random_uniform(UInt32(businessTasks.count)))]
      
      tasks = [adrenalineTask, businessTask]
    }
    return tasks
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

class Trophy: Codable {
  let iconName: String
  let name: String
  let description: String
  var isLocked: Bool
  
  init(iconName: String, name: String, description: String, isLocked: Bool) {
    self.iconName = iconName
    self.name = name
    self.description = description
    self.isLocked = isLocked
  }
  
  
}

class Task: Codable {
  
  let id: String
  var name: String
  var type: String
  var isChecked: Bool
  
  var titleTypeTask: String {
    return "\(type) Task"
  }
  
  init(name: String, type: String) {
    id = UUID().uuidString
    self.name = name
    self.type = type
    isChecked = false
  }
  
  func getTypeImage() -> UIImage {
    if type == "Adrenaline" {
      return #imageLiteral(resourceName: "imageTaskAdrenaline")
    } else if type == "Business" {
      return #imageLiteral(resourceName: "imageTaskBusiness")
    } else {
      return #imageLiteral(resourceName: "imageTaskLifestyle")
    }
  }
  
  func toogleChecked() {
    isChecked = !isChecked
  }
  
  
}
