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
  
  var isFirstTime: Bool {
    return UserDefaults.standard.bool(forKey: "FirstTime")
  }
  
  init() {
    UserDefaults.standard.register(defaults: ["FirstTime": true])
    loadProfile()
    print(documentsDirectory)
  }
  
  var documentsDirectory: URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
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
}
