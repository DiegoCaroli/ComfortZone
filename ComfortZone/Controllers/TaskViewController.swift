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
    let desiredOffset = CGPoint(x: 0, y: 200)
    setContentOffset(desiredOffset, animated: true)
  }
}

// MAIN

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomTableViewCellDelegate {
  
  // Interface Builder
  
  @IBOutlet weak var adventureLabel: UILabel!
  @IBOutlet weak var taskTableView: UITableView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var angryCloudButton: UIButton!
  @IBOutlet weak var sadCloudButton: UIButton!
  @IBOutlet weak var sunButton: UIButton!
  @IBOutlet weak var neutralCloudButton: UIButton!
  @IBOutlet weak var thirdStaticCloudView: UIImageView!
  @IBOutlet weak var secondStaticCloudView: UIImageView!
  @IBOutlet weak var firstStaticCloudView: UIImageView!
  @IBOutlet weak var backgroundImage: UIImageView!
  
  var profile: Profile!
  var memoryImage: UIImage?
  lazy var notificationCenter: NotificationCenter = {
    return NotificationCenter.default
  }()
  var notificationObserver: NSObjectProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    taskTableView.delegate = self
    taskTableView.dataSource = self
    profile = DataModel.shared.profile
    notificationObserver = notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
      self.updateUI()
    }
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
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal, title: "Add Photo", handler: { (action, view, completionHandler) in
      self.pickPhoto()
      completionHandler(true)
    })
    
    action.image = UIImage(named: "cameraSwipe")
    action.backgroundColor = UIColor(red:0.82, green:0.48, blue:0.28, alpha:1.00)
    let configuration = UISwipeActionsConfiguration(actions: [action])
    return configuration
  }
  
  func imageTapped(_ cell: CustomTableViewCell) {
    if let indexPath = taskTableView.indexPath(for: cell) {
      let task = DataModel.shared.todayTasks[indexPath.row]
      task.toogleChecked()
      
      cell.task = task
      cell.configureChechmark()
      
      DataModel.shared.update(task: task)
      
      task.isDone ? profile.update(score: 1, task: task) : profile.update(score: -1, task: task)
      
      if profile.isThereATrophy(isLocked: !task.isDone, task: task) {
        showBadge(isThereNewTrophy: task.isDone)
      }
      checkAllTodayTasksDone()
    }
  }
  
  private func updateUI() {
    DispatchQueue.main.async { () -> Void in
      if !DataModel.shared.isTheSameDay {
        DataModel.shared.generateNewTodayTasks()
        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.configureAdventureLabel(text: "Hello my adventure friend!")
        self.taskTableView.reloadData()
      } else {
        self.scrollView.contentOffset = CGPoint(x: 0, y: 200)
        self.configureAdventureLabel(text: "Welcome back my adventure friend!")
        self.adventureLabel.frame = CGRect(x: 8, y: 264, width: self.view.bounds.width - 16, height: 74.0)
      }
    }
  }
  
  private func configureAdventureLabel(text: String) {
    adventureLabel.text = text
     adventureLabel.textAlignment = .center
    if text == "Hello my adventure friend!" {
      self.adventureLabel.font = self.adventureLabel.font.withSize(24.0)
      self.adventureLabel.numberOfLines = 1
      adventureLabel.frame = CGRect(x: 8, y: 75, width: self.view.bounds.width - 16, height: 33.0)
    } else {
      self.adventureLabel.font = self.adventureLabel.font.withSize(27.0)
      self.adventureLabel.numberOfLines = 0
      adventureLabel.frame = CGRect(x: 8, y: 264, width: self.view.bounds.width - 16, height: 74.0)
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

//MARK: - UIImagePickerControllerDelegate
extension TaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func pickPhoto() {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      showPhotoMenu()
    } else {
      choosePhotoFromLibrary()
    }
  }
  
  func showPhotoMenu() {
    let alertController = UIAlertController(title: nil, message: nil,
                                            preferredStyle: .actionSheet)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in self.takePhotoWithCamera() })
    
    alertController.addAction(takePhotoAction)
    
    let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in self.choosePhotoFromLibrary() })
    
    alertController.addAction(chooseFromLibraryAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  func takePhotoWithCamera() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  func choosePhotoFromLibrary() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    
    memoryImage = info[UIImagePickerControllerEditedImage] as? UIImage
    
    if let image = memoryImage {
      let photoMemory = Photo(photoID: DataModel.shared.nextPhotoID())
      photoMemory.save(image: image)
      DataModel.shared.profile.memories.append(photoMemory)
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}
