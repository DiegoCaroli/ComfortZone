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
  @IBOutlet weak var checkmarkImageView: UIImageView!
  
  
  var task: Task! 

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
    updateTask(id: task.id)
    updateScore()
    unlockTrophy()
  }
  
  func configureChechmark() {
    if task.isChecked {
      checkmarkImageView.image = #imageLiteral(resourceName: "checkTrue")
    } else {
      checkmarkImageView.image = #imageLiteral(resourceName: "checkFalse")
    }
  }
  
  func updateTask(id: String) {
    let profile = DataModel.shared.profile
    
    if let i = DataModel.shared.todayTasks.index(where: {$0.id == id}) {
      var tasks = DataModel.shared.todayTasks
      tasks[i] = task
      DataModel.shared.todayTasks = tasks
    }
    
    if let i = profile.tasks.index(where: {$0.id == id}) {
      profile.tasks[i] = task
    }
  }
  
  func updateScore() {
    if task.isChecked {
      switch task.type {
      case "Adrenaline":
        DataModel.shared.profile.adrenalineScore += 1
      case "Business":
        DataModel.shared.profile.businessScore += 1
      case "Lifestyle":
        DataModel.shared.profile.lifestyleScore += 1
      default:
        return
      }
    } else {
      switch task.type {
      case "Adrenaline":
        DataModel.shared.profile.adrenalineScore -= 1
      case "Business":
        DataModel.shared.profile.businessScore -= 1
      case "Lifestyle":
        DataModel.shared.profile.lifestyleScore -= 1
      default:
        return
      }
    }
    
  }
  
  func unlockTrophy() {
    let trophies = DataModel.shared.profile.trophies.filter { $0.name == task.name }
    if var firstTrophy = trophies.first {
      firstTrophy.isLocked = false
    }
    
    
  }
  
}
