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
  
  var profile: Profile!
  var arrayElements: [String] = []
  
  let imageTask = ["imageTaskAdrenaline","imageTaskBusiness","imageTaskLifestyle"]
  
  let labelTask = ["Adrenaline Task", "Business Task", "Lifestyle task"]
  
  let check = ["checkFalse"]
  
  func generalButtonFunction(){
    
    scrollView.scrollToTop()
    labelAnimation(label: adventureLabel, duration: 0.5, amount: -210)
    //        sunButton.isHidden = true
    //        sadCloudButton.isHidden = true
    //        angryCloudButton.isHidden = true
    //        neutralCloudButton.isHidden = true
    
  }
  
  override func viewDidLoad() {
    
    cloudAnimation(viewOfTheCloud: firstStaticCloudView , duration: 10 , amount: -100)
    cloudAnimation(viewOfTheCloud: secondStaticCloudView , duration: 15 , amount: 60)
    cloudAnimation(viewOfTheCloud: thirdStaticCloudView , duration: 12 , amount: -50)
    
    
    taskTableView.delegate = self
    taskTableView.dataSource = self
    
    super.viewDidLoad()
    
    arrayElements = getElements()
    
    profile = DataModel.shared.profile
  }
  
  // SEGUE - In order to allow each UIView to comunicate and pass data
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toCustomPopUpViewController" {
      let customPopUpView = segue.destination as! CustomPopUpViewController
      
      if let indexPath = taskTableView.indexPath(for: sender as! UITableViewCell){
        
        customPopUpView.todayTask = arrayElements[indexPath.row]
        customPopUpView.typeTask = labelTask[indexPath.row]
        customPopUpView.imgTask = imageTask[indexPath.row]
        
      }
    }
  }
  
  //    GET ELEMENTS - This function allows to get data from the plist file that cointains all tasks
  //                   divided by topics: "Adrenaline", "Business", "Lyfestyle"
  
  func getElements() -> [String] {
    
    var array: [String] = []
    
    if let path = Bundle.main.path(forResource: "Tasks", ofType: "plist") {
      if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
        
        var adrenalineDict = dict["Adrenaline"] as! [String]
        var businessDict = dict["Business"] as! [String]
        var lifestyleDict = dict["Lifestyle"] as! [String]
        
        let adrenalineRandomElement = adrenalineDict[Int(arc4random_uniform(UInt32(adrenalineDict.count)))]
        let businessRandomElement = businessDict[Int(arc4random_uniform(UInt32(businessDict.count)))]
        let lifestyleRandomElement = lifestyleDict[Int(arc4random_uniform(UInt32(lifestyleDict.count)))]
        
        //          In order to have an array with the random tasks choosen for each session
        
        array = [adrenalineRandomElement, businessRandomElement, lifestyleRandomElement]
        
        
      }
    }
    return array
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
  
  //  TABLE VIEW -  UITableViewDelegate, UITableViewDataSource - Delegation in order to use
  //                this particular function to customize our tableView
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return imageTask.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = taskTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
    
    cell.checkButton.layer.cornerRadius = 50
    cell.checkButton.setBackgroundImage(#imageLiteral(resourceName: "checkFalse"), for: .normal)
    cell.taskLabel.text = arrayElements[indexPath.row]
    cell.typeTaskLabel.text = labelTask[indexPath.row]
    cell.taskImageView.image = UIImage(named: imageTask[indexPath.row])
    
    return cell
  }
  
  //  CLOUD BUTTONS - For each button there are some methods defined in the previous part of the code.
  //                  generalFunction includes the function to scrollDown into the scrollView and the
  //                  function to animate "Hello my adventure friend!" after the scrooling of the sV.
  
  @IBAction func angryCloudButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 0
  }
  
  @IBAction func sadCloudButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 1
  }
  
  @IBAction func neutralCloudButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 2
  }
  
  @IBAction func sunButtonPressed(_ sender: Any) {
    generalButtonFunction()
    profile.happiness = 3
  }
  
}
