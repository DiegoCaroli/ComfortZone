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
  func showBadge(_ class: CustomTableViewCell)
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
    updateTask()
    
    if task.isChecked {
      updateScore(score: 1)
      isLockedTrophy(isLocked: false)
//      if (UIApplication.shared.keyWindow?.rootViewController as? MyTabBarController) != nil {
//        (UIApplication.shared.keyWindow?.rootViewController as! MyTabBarController).tabBar.items![2].badgeValue = "New"
//      }
delegate?.showBadge(self)
    } else {
      updateScore(score: -1)
      isLockedTrophy(isLocked: true)
    }
    
    checkAllTodayTasksDone()
  }
  
  private func configureChechmark() {
    if task.isChecked {
      checkmarkImageView.image = #imageLiteral(resourceName: "checkTrue")
    } else {
      checkmarkImageView.image = #imageLiteral(resourceName: "checkFalse")
    }
  }
  
  private func updateTask() {
    if let i = DataModel.shared.todayTasks.index(where: {$0.id == task.id}) {
      var todayTasks = DataModel.shared.todayTasks
      todayTasks[i] = task
      DataModel.shared.todayTasks = todayTasks
    }
    
    if let i = profile.tasks.index(where: {$0.id == task.id}) {
      profile.tasks[i] = task
    }
  }
  
  private func updateScore(score: Int) {
    switch task.type {
    case "Adrenaline":
      DataModel.shared.profile.adrenalineScore += score
    case "Business":
      DataModel.shared.profile.businessScore += score
    case "Lifestyle":
      DataModel.shared.profile.lifestyleScore += score
    default:
      return
    }
  }
  
  private func isLockedTrophy(isLocked: Bool) {
    let trophies = DataModel.shared.profile.trophies
    if let i = trophies.index(where: { $0.description.contains(task.name) }) {
      trophies[i].isLocked = isLocked
    }
  }
  
  func checkAllTodayTasksDone() {
    let todayTasks = DataModel.shared.todayTasks
    
    for task in todayTasks {
      if task.isChecked == false {
        return
      }
    }
    delegate?.showAlert(self)
  }
  
}
