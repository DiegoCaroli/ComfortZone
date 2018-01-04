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
  
  private init() {
    userDefaults.register(defaults: ["FirstTime": true,
                                              "LastDate": Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                                              "TodayTask": []])
    loadProfile()
    print(documentsDirectory)
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
      todayTasks = profile.getTodayTasks()
    }
  }
  
}
