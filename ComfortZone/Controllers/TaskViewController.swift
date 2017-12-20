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

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
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
  @IBOutlet weak var welcomeBackLabel: UILabel!
  
  var profile: Profile!
  let todayDate = DataModel.shared.todayDate
  let dueDate = Date()
  
  var memoryImage: UIImage?
  
  var newTrophy = DataModel.shared.isNewTrophyDiscored {
    didSet {
      if newTrophy == true {
        tabBarController?.tabBar.items![2].badgeValue = "New"
      }
    }
  }
  
  func generalButtonFunction(){
    
    scrollView.scrollToTop()
    labelAnimation(label: adventureLabel, duration: 0.5, amount: -210)
    //        sunButton.isHidden = true
    //        sadCloudButton.isHidden = true
    //        angryCloudButton.isHidden = true
    //        neutralCloudButton.isHidden = true
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    newTrophy = DataModel.shared.isNewTrophyDiscored
    taskTableView.delegate = self
    taskTableView.dataSource = self
    profile = DataModel.shared.profile
    setTodayDate()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    cloudAnimation(viewOfTheCloud: firstStaticCloudView , duration: 10 , amount: -100)
    cloudAnimation(viewOfTheCloud: secondStaticCloudView , duration: 15 , amount: 60)
    cloudAnimation(viewOfTheCloud: thirdStaticCloudView , duration: 12 , amount: -50)
    
    
    if todayDate.getDay == dueDate.getDay && todayDate.getMonth == dueDate.getMonth {
      scrollView.contentOffset = CGPoint(x: 0, y: 200)
      welcomeBackLabel.isHidden = false
    } else {
      
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
//    cell.configureChechmark()
    
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
//    setTodayDate()
  }
  
  @IBAction func sadCloudButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 1
//    setTodayDate()
  }
  
  @IBAction func neutralCloudButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 2
//    setTodayDate()
  }
  
  @IBAction func sunButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 3
//    setTodayDate()
  }
  
  private func setTodayDate() {
    if todayDate.getDay != dueDate.getDay || todayDate.getMonth != dueDate.getMonth {
      DataModel.shared.todayDate = dueDate
      DataModel.shared.todayTasks = profile.getTodayTasks()
  
    }
  }
  
  private func updateTask(task: Task) {
    let profile = DataModel.shared.profile
    
    if let i = DataModel.shared.todayTasks.index(where: {$0.id == task.id}) {
      var tasks = DataModel.shared.todayTasks
      tasks[i] = task
      DataModel.shared.todayTasks = tasks
    }
    
    if let i = profile.tasks.index(where: {$0.id == task.id}) {
      profile.tasks[i] = task
    }
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

