//
//  TaskViewController.swift
//  ComfortZone
//
//  Created by Gaetano Acunzo on 11/12/17.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//  Virtual Assistant - Coder: Nicola Centonze

import UIKit

//EXTENSION - With this modified extension of the function scrollToTop() we can scroll from the
//            Top to the Bottom of the scrollView

extension UIScrollView {
  func scrollToTop() {
    let height = UIScreen.main.bounds.height == 667 ? 260 : 230
    let desiredOffset = CGPoint(x: 0, y: CGFloat(height))
    setContentOffset(desiredOffset, animated: true)
  }
}

// MAIN

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  // Interface Builder
  @IBOutlet weak var adventureLabel: UILabel!
  @IBOutlet weak var taskTableView: UITableView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var thirdStaticCloudView: UIImageView!
  @IBOutlet weak var secondStaticCloudView: UIImageView!
  @IBOutlet weak var firstStaticCloudView: UIImageView!
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var welcomeBackLabel: UILabel!
  @IBOutlet weak var adventureLabelLayoutConstraint: NSLayoutConstraint!
  
  var profile: Profile!
  var memoryImage: UIImage?
  lazy var notificationCenter: NotificationCenter = {
    return NotificationCenter.default
  }()
  var notificationObserver: NSObjectProtocol?
  let height667 = 260
  let height736 = 230
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    taskTableView.delegate = self
    taskTableView.dataSource = self
    profile = DataModel.shared.profile
    notificationObserver = notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
      self.updateUI()
    }
    welcomeBackLabel.isHidden = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    cloudAnimation(viewOfTheCloud: firstStaticCloudView , duration: 10 , amount: -100)
    cloudAnimation(viewOfTheCloud: secondStaticCloudView , duration: 15 , amount: 60)
    cloudAnimation(viewOfTheCloud: thirdStaticCloudView , duration: 12 , amount: -50)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.updateUI()
  }
  
  deinit {
    if let observer = notificationObserver {
      notificationCenter.removeObserver(observer)
    }
  }
  
  // SEGUE - In order to allow each UIView to comunicate and pass data
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toCustomPopUpViewController" {
      let customPopUpView = segue.destination as! CustomPopUpViewController
      
      if let indexPath = taskTableView.indexPath(for: sender as! UITableViewCell) {
        customPopUpView.task = DataModel.shared.todayTasks[indexPath.row]
      }
    }
  }
  
  //  TABLE VIEW -  UITableViewDelegate, UITableViewDataSource - Delegation in order to use
  //                this particular function to customize our tableView
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return DataModel.shared.todayTasks.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = taskTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
    
    let task = DataModel.shared.todayTasks[indexPath.row]
    
    cell.taskLabel.text = task.name
    cell.typeTaskLabel.text = task.titleTypeTask
    cell.taskImageView.image = task.getTypeImage()
    cell.task = task
    cell.configureChechmark()
    cell.delegate = self
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  private func addMemory() {
    let alert = UIAlertController(title: "Add a memory", message: "Your journey must be remembered, take a photo about it.", preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
      self.addImage()
    })
    alert.addAction(cancelAction)
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  private func addImage() {
    ImagePickerManager.shared.pickPhoto { image in
      let photoMemory = Photo(photoID: DataModel.shared.nextPhotoID())
      photoMemory.save(image: image)
      DataModel.shared.profile.memories.append(photoMemory)
      
      self.checkAllTodayTasksDone()
    }
  }
  
  
  
  private func updateUI() {
    let height = UIScreen.main.bounds.height
    DispatchQueue.main.async {
      if !DataModel.shared.isTheSameDay {
        DataModel.shared.generateNewTodayTasks()
        let rightHeight = height == 667 ? CGFloat(60) : CGFloat(0)
        self.scrollView.contentOffset = CGPoint(x: 0, y: rightHeight)
        if height == 667 {
          self.adventureLabelLayoutConstraint.constant = self.adventureLabelLayoutConstraint.constant + 20
        }
        self.adventureLabel.frame = CGRect(x: (UIScreen.main.bounds.width - self.adventureLabel.bounds.width) / 2, y: 79, width: self.adventureLabel.bounds.width, height: self.adventureLabel.bounds.height)
        self.adventureLabel.isHidden = false
        self.welcomeBackLabel.isHidden = true
        self.taskTableView.reloadData()
      } else {
        let rightHeight = height == 667 ? CGFloat(260) : CGFloat(230)
        self.scrollView.contentOffset = CGPoint(x: 0, y: rightHeight)
        self.adventureLabel.isHidden = true
        self.welcomeBackLabel.isHidden = false
      }
      
      if self.profile.adrenalineScore >= 9 && self.profile.businessScore >= 9 && self.profile.lifestyleScore >= 9 {
        self.backgroundImage.image = #imageLiteral(resourceName: "VirtualAssistantLevel2")
      }
    }
  }
  
  func generalButtonFunction(){
    scrollView.scrollToTop()
    labelAnimation(label: adventureLabel, duration: 0.5, amount: -210)
  }
  
  //  ANIMATION: Functions to use custom animation for the Clouds and the label "Hello my adventure Friend"
  
  func cloudAnimation(viewOfTheCloud: UIView , duration: Double , amount: CGFloat){
    UIView.animate(withDuration: duration, delay: 0.25, options: [.autoreverse, .repeat], animations: {
      viewOfTheCloud.frame.origin.x -= amount
    },completion: nil)
  }
  
  func labelAnimation(label: UILabel , duration: Double , amount: CGFloat){
    UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: {
      label.frame.origin.y -= amount
    })
  }
  
  //  CLOUD BUTTONS - For each button there are some methods defined in the previous part of the code.
  //                  generalFunction includes the function to scrollDown into the scrollView and the
  //                  function to animate "Hello my adventure friend!" after the scrooling of the sV.
  
  @IBAction func angryCloudButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 0
    setTodayDate()
  }
  
  @IBAction func sadCloudButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 1
    setTodayDate()
  }
  
  @IBAction func neutralCloudButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 2
    setTodayDate()
  }
  
  @IBAction func sunButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 3
    setTodayDate()
  }
  
  private func setTodayDate() {
    DataModel.shared.lastDate = Date()
  }
  
  func checkAllTodayTasksDone() {
    let todayTasks = DataModel.shared.todayTasks
    
    for task in todayTasks  {
      if task.isDone == false {
        return
      }
    }
    
    let alert = UIAlertController(title: "Well Done", message: "Hey, looks like today you were too good! Come tomorrow for more fun.", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  func showBadge(isThereNewTrophy: Bool) {
    isThereNewTrophy ? (tabBarController?.tabBar.items![2].badgeValue = "New") : (tabBarController?.tabBar.items![2].badgeValue = nil)
  }
}

//MARK: - CustomTableViewCellDelegate
extension TaskViewController: CustomTableViewCellDelegate {
  func checkmarkTapped(_ cell: CustomTableViewCell) {
    if let indexPath = taskTableView.indexPath(for: cell) {
      let task = DataModel.shared.todayTasks[indexPath.row]
      task.toogleChecked()
      
      cell.task = task
      cell.configureChechmark()
      
      DataModel.shared.update(task: task)
      
      if DataModel.shared.counterReminderMemory < 3 {
        if task.isDone {
          addMemory()
          DataModel.shared.counterReminderMemory += 1
        }
      } else {
        if task.isDone {
          addImage()
        }
      }
      
      task.isDone ? profile.update(score: 1, task: task) : profile.update(score: -1, task: task)
      
      if profile.isThereATrophy(isLocked: !task.isDone, task: task) {
        showBadge(isThereNewTrophy: task.isDone)
      }
      
    }
  }
}
