//
//  CustomTableViewCell.swift
//  ComfortZone
//
//  Created by Nicola Centonze on 14/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate: class {
  func showAlert(_ class: CustomTableViewCell)
  func showBadge(_ class: CustomTableViewCell, isThereNewTrophy: Bool)
}

class CustomTableViewCell: UITableViewCell {
  
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var taskImageView: UIImageView!
  @IBOutlet weak var typeTaskLabel: UILabel!
  @IBOutlet weak var taskLabel: UILabel!
  @IBOutlet weak var checkmarkImageView: UIImageView!
  
  var task: Task! {
    didSet {
      configureChechmark()
      checkAllTodayTasksDone()
    }
  }
  
  let profile = DataModel.shared.profile
//  let todayTasks = DataModel.shared.todayTasks
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
    task.toogleChecked()
    
    configureChechmark()
    DataModel.shared.update(task: task)
    
    var isNewTrophy: Bool
    if task.isDone {
      profile.update(score: 1, task: task)
      isNewTrophy = false
    } else {
      profile.update(score: -1, task: task)
      isNewTrophy = true
    }
    if profile.isThereATrophy(isLocked: isNewTrophy, task: task) {
      delegate?.showBadge(self, isThereNewTrophy: !isNewTrophy)
    }

    checkAllTodayTasksDone()
  }
  
  private func configureChechmark() {
    if task.isDone {
      checkmarkImageView.image = #imageLiteral(resourceName: "checkTrue")
    } else {
      checkmarkImageView.image = #imageLiteral(resourceName: "checkFalse")
    }
  }
  
  func checkAllTodayTasksDone() {
    let todayTasks = DataModel.shared.todayTasks
    
    for task in todayTasks  {
      if task.isDone == false {
        return
      }
    }
    delegate?.showAlert(self)
  }
  
}
