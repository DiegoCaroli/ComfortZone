//
//  Trophy.swift
//  ComfortZone
//
//  Created by Diego Caroli on 04/01/2018.
//  Copyright © 2018 Diego Caroli. All rights reserved.
//

import Foundation

class Trophy: Codable {
  let iconName: String
  let name: String
  let description: String
  var isLocked: Bool
  
  init(iconName: String, name: String, description: String) {
    self.iconName = iconName
    self.name = name
    self.description = description
    self.isLocked = true
  }
}
