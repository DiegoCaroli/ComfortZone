//
//  Date.swift
//  ComfortZone
//
//  Created by Diego Caroli on 19/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import Foundation

extension Date {
  
  var getDay: Int {
    let calendar = Calendar.current
    return calendar.component(.day, from: self)
  }
  
  var getMonth: Int {
    let calendar = Calendar.current
    return calendar.component(.month, from: self)
  }
  
}
