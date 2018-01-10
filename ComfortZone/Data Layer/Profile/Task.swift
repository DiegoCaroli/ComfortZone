//
//  Task.swift
//  ComfortZone
//
//  Created by Diego Caroli on 04/01/2018.
//  Copyright © 2018 Diego Caroli. All rights reserved.
//

import Foundation
import UIKit

class Task: Codable, CustomStringConvertible {
  let id: String
  var name: String
  var type: String
  var priority: Int
  var isDone: Bool
  
  var titleTypeTask: String {
    return "\(type) Task"
  }
  
  init(name: String, type: String, priority: Int) {
    id = UUID().uuidString
    self.name = name
    self.type = type
    self.priority = priority
    isDone = false
  }
  
  func getTypeImage() -> UIImage {
    if type == "Adrenaline" {
      return #imageLiteral(resourceName: "ImageTaskAdrenaline")
    } else if type == "Business" {
      return #imageLiteral(resourceName: "ImageTaskBusiness")
    } else {
      return #imageLiteral(resourceName: "ImageTaskLifestyle")
    }
  }
  
  func toogleChecked() {
    isDone = !isDone
  }
  var description: String {
    return "name: \(name), type: \(type), description: \(priority)"
  }
}
