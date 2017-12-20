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
  
  var profile: Profile!
  let todayDate = DataModel.shared.todayDate
  let dueDate = Date()
  

  var arrayElements = DataModel.shared.profile.getTodayTasks()
//
//  let imageTask = ["imageTaskAdrenaline","imageTaskBusiness","imageTaskLifestyle"]
//
//  let labelTask = ["Adrenaline Task", "Business Task", "Lifestyle task"]
//
//  let check = ["checkFalse"]
  
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
    
    cloudAnimation(viewOfTheCloud: firstStaticCloudView , duration: 10 , amount: -100)
    cloudAnimation(viewOfTheCloud: secondStaticCloudView , duration: 15 , amount: 60)
    cloudAnimation(viewOfTheCloud: thirdStaticCloudView , duration: 12 , amount: -50)
    
    taskTableView.delegate = self
    taskTableView.dataSource = self
    
    profile = DataModel.shared.profile
//    DataModel.shared.todayTasks = profile.getTodayTasks()
    print(todayDate)
    print(dueDate)
    
    for i in DataModel.shared.todayTasks {
      print(i.isChecked) }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if todayDate.getDay == dueDate.getDay && todayDate.getMonth == dueDate.getMonth {
      scrollView.contentOffset = CGPoint(x: 0, y: 200)
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
    cell.typeTaskLabel.text = task.type
    cell.taskImageView.image = task.getTypeImage()
    cell.task = task
    cell.configureChechmark()
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
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
    if todayDate.getDay != dueDate.getDay && todayDate.getMonth != dueDate.getMonth {
      DataModel.shared.todayDate = dueDate
      DataModel.shared.todayTasks = profile.getTodayTasks()
    }

  }
}
