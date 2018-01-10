//
//  DataModel.swift
//  ComfortZone
//
//  Created by Diego Caroli on 14/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import Foundation

final class DataModel {
  static let shared = DataModel()
  
  var profile = Profile()
  private let userDefaults = UserDefaults.standard
  
  var documentsDirectory: URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  var isFirstTime: Bool {
    return userDefaults.bool(forKey: "FirstTime")
  }
  
  var lastDate: Date {
    get {
      return userDefaults.object(forKey: "LastDate") as! Date
    }
    set {
      userDefaults.set(newValue, forKey: "LastDate")
      userDefaults.synchronize()
    }
  }
  
  var isTheSameDay: Bool {
    let todayDate = Date()
    return lastDate.day == todayDate.day && lastDate.month == todayDate.month
  }
  
  var todayTasks: [Task] {
    get {
      return try! PropertyListDecoder().decode([Task].self, from: userDefaults.object(forKey: "TodayTasks") as! Data)
    }
    set {
      userDefaults.set(try! PropertyListEncoder().encode(newValue), forKey: "TodayTasks")
      userDefaults.synchronize()
    }
  }
  
  lazy var allTasks: [Task] = {
    var tasks: [Task] = []
    if let path = Bundle.main.path(forResource: "Tasks", ofType: "plist") {
      if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
        
        for (key, value) in dict {
          for i in value as! [[String: Any]] {
            let name = i["name"] as! String
            let priority = i["priority"] as! Int
            let task = Task(name: name, type: key, priority: priority)
            tasks.append(task)
          }
        }
      }
    }
    return tasks
  }()
  
  private init() {
    userDefaults.register(defaults: ["FirstTime": true,
                                              "LastDate": Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                                              "TodayTask": []])
    loadProfile()
    print(documentsDirectory)
    profile.tasks = allTasks
  }
  
  func dataFilePath() -> URL {
    return documentsDirectory.appendingPathComponent("Profile.plist")
  }
  
  func saveProfile() {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(profile)
      try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
    } catch {
      print("Error encoding item array!")
    }
  }
  
  func loadProfile() {
    let path = dataFilePath()
    if let data = try? Data(contentsOf: path) {
      let decoder = PropertyListDecoder()
      do {
        profile = try decoder.decode(Profile.self, from: data)
      } catch {
        print("Error decoding item array!")
      }
    }
  }
  
  func nextPhotoID() -> Int {
    let currentID = userDefaults.integer(forKey: "PhotoID") + 1
    userDefaults.set(currentID, forKey: "PhotoID")
    userDefaults.synchronize()
    return currentID
  }
  
  func update(task: Task) {
    var todayTasks = self.todayTasks
    
    if let i = todayTasks.index(where: {$0.id == task.id}) {
      todayTasks[i] = task
      self.todayTasks = todayTasks
    }
    
    if let i = profile.tasks.index(where: {$0.id == task.id}) {
      profile.tasks[i] = task
    }
  }
  
  func generateNewTodayTasks() {
    let todayDate = Date()
    if lastDate.day != todayDate.day || lastDate.month != todayDate.month {
      todayTasks = getTodayTasks()
    }
  }
  
  private func getTodayTasks() -> [Task] {
    var tasks: [Task] = []
    let adrenalineTasks = profile.tasks.filter {$0.type == "Adrenaline" && !$0.isDone }
    let businessTasks = profile.tasks.filter {$0.type == "Business" && !$0.isDone }
    let lifestyleTasks = profile.tasks.filter {$0.type == "Lifestyle" && !$0.isDone }
    
    if let adrenalineTask = extractNormalTask(score: profile.adrenalineScore, tasks: adrenalineTasks) {
      tasks.append(adrenalineTask)
    }
    
    if let businessTask = extractNormalTask(score: profile.businessScore, tasks: businessTasks) {
      tasks.append(businessTask)
    }
    
    if let lifestyleTask = extractNormalTask(score: profile.lifestyleScore, tasks: lifestyleTasks) {
      tasks.append(lifestyleTask)
    }
    
    if profile.adrenalineScore >= 9 && profile.businessScore >= 9 && profile.lifestyleScore >= 9 {
      if let adrenalineTask = extractExtremeTask(adrenalineTasks) {
        tasks.append(adrenalineTask)
      }
      
      if let businessTask = extractExtremeTask(businessTasks) {
        tasks.append(businessTask)
      }
      
      if let lifestyleTask = extractExtremeTask(lifestyleTasks) {
        tasks.append(lifestyleTask)
      }
    }
    return tasks
  }
  
  private func extractNormalTask(score: Int, tasks: [Task]) -> Task? {
    let tasks = tasks.filter { $0.priority == 0 }
    if score <= 8 {
      return tasks[Int(arc4random_uniform(UInt32(tasks.count)))]
    }
    return nil
  }
  
  private func extractExtremeTask(_ tasks: [Task]) -> Task? {
    let tasks = tasks.filter { $0.priority == 1 }
    if !tasks.isEmpty {
      return tasks[Int(arc4random_uniform(UInt32(tasks.count)))]
    }
    return nil
  }
  
}
