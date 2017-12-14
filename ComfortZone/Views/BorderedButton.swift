//
//  BorderedButton.swift
//  ComfortZone
//
//  Created by Diego Caroli on 14/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

@IBDesignable class BorderedButton: UIButton {

  @IBInspectable var cornerRadius: Double {
    get {
      return Double(self.layer.cornerRadius)
    }
    set {
      self.layer.cornerRadius = CGFloat(newValue)
    }
  }
  
  @IBInspectable var borderWidth: Double {
    get {
      return Double(self.layer.borderWidth)
    }
    set {
      self.layer.borderWidth = CGFloat(newValue)
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    get {
      let color = UIColor.init(cgColor: layer.borderColor!)
      return color
    }
    set {
      self.layer.borderColor = newValue?.cgColor
    }
  }

}
