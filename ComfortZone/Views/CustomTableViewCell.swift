//
//  CustomTableViewCell.swift
//  ComfortZone
//
//  Created by Nicola Centonze on 14/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
  
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var taskImageView: UIImageView!
  @IBOutlet weak var typeTaskLabel: UILabel!
  @IBOutlet weak var taskLabel: UILabel!
  
  @IBOutlet weak var checkButton: UIButton!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let selectionView = UIView(frame: CGRect.zero)
    selectionView.backgroundColor = UIColor(red: 0.56, green: 0.33, blue: 0.19, alpha: 0.5)
    selectedBackgroundView = selectionView
  }
  
  @IBAction func checkButtonPressed(_ sender: Any) {
    
    if checkButton.currentBackgroundImage == #imageLiteral(resourceName: "checkFalse") {
      checkButton.setBackgroundImage(#imageLiteral(resourceName: "checkTrue"), for: .normal)
    } else {
      checkButton.setBackgroundImage(#imageLiteral(resourceName: "checkFalse"), for: .normal)
    }
    
  }
  
}
