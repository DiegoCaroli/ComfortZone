//
//  Photo.swift
//  ComfortZone
//
//  Created by Diego Caroli on 04/01/2018.
//  Copyright © 2018 Diego Caroli. All rights reserved.
//

import Foundation
import UIKit

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
