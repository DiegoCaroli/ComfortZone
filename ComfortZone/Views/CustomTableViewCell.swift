//
//  CustomTableViewCell.swift
//  ComfortZone
//
//  Created by Nicola Centonze on 14/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate: class {
  func checkmarkTapped(_ cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
  
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var taskImageView: UIImageView!
  @IBOutlet weak var typeTaskLabel: UILabel!
  @IBOutlet weak var taskLabel: UILabel!
  @IBOutlet weak var checkmarkImageView: UIImageView!
  
  var task: Task!
  
  let profile = DataModel.shared.profile
  weak var delegate: CustomTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let selectionView = UIView(frame: CGRect.zero)
    selectionView.backgroundColor = UIColor(red: 0.56, green: 0.33, blue: 0.19, alpha: 0.5)
    selectedBackgroundView = selectionView
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
    
    checkmarkImageView.addGestureRecognizer(tapGesture)
    checkmarkImageView.isUserInteractionEnabled = true
  }
  
  @objc func imageTapped(sender: UITapGestureRecognizer) {
    delegate?.checkmarkTapped(self)
  }
  
  func configureChechmark() {
    if task.isDone {
      checkmarkImageView.image = #imageLiteral(resourceName: "checkTrue")
    } else {
      checkmarkImageView.image = #imageLiteral(resourceName: "checkFalse")
    }
  }
  
}
