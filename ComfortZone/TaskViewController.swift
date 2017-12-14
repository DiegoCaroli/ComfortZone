//
//  TaskViewController.swift
//  ComfortZone
//
//  Created by Gaetano Acunzo on 11/12/17.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

//EXTENSION TO GO IN THE BOTTOM OF THE SCROLL VIEW

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: 200)
        setContentOffset(desiredOffset, animated: true)
    }
}

    //  TASK VIEW CONTROLLER MAIN SECTION

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var angryCloudButton: UIButton!
    
    @IBOutlet weak var sadCloudButton: UIButton!
    
    @IBOutlet weak var sunButton: UIButton!
    @IBOutlet weak var neutralCloudButton: UIButton!
    
    @IBOutlet weak var thirdStaticCloudView: UIImageView!
    @IBOutlet weak var secondStaticCloudView: UIImageView!
    @IBOutlet weak var firstStaticCloudView: UIImageView!
    
    let imageTask = ["imageTaskAdrenaline","imageTaskBusiness","imageTaskLifestyle"]
    
    let labelTask = ["Adrenaline Task", "Business Task", "Lifestyle task"]
    
    func generalButtonFunction(){
        
        scrollView.scrollToTop()
        sunButton.isHidden = true
        sadCloudButton.isHidden = true
        angryCloudButton.isHidden = true
        neutralCloudButton.isHidden = true
    
    }
    
    
    
   
    
    override func viewDidLoad() {
        
        
        
        cloudAnimation(viewOfTheCloud: firstStaticCloudView , duration: 10 , amount: -300)
        cloudAnimation(viewOfTheCloud: secondStaticCloudView , duration: 9 , amount: 150)
        cloudAnimation(viewOfTheCloud: thirdStaticCloudView , duration: 7 , amount: -100)
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
       
        super.viewDidLoad()
    }
    
    
    
    func cloudAnimation(viewOfTheCloud: UIView , duration: Double , amount: CGFloat){
        UIView.animate(withDuration: duration, delay: 0.25, options: [.autoreverse, .repeat], animations: {
            viewOfTheCloud.frame.origin.x -= amount
        })
    
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return imageTask.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
//        let cell = taskTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.typeTaskLabel.text = imageTask[indexPath.row]
        cell.taskLabel.text = labelTask[indexPath.row]
        cell.taskImageView.image = UIImage(named: imageTask[indexPath.row])
        
        return cell
        
    }
    
    
    //  BUTTON SECTION - SCROLL DOWN AND HIDE THE BUTTON
    
    @IBAction func angryCloudButtonPressed(_ sender: Any) {
        generalButtonFunction()
    }
    
    @IBAction func sadCloudButtonPressed(_ sender: Any) {
        generalButtonFunction()
    }
    
    @IBAction func neutralCloudButtonPressed(_ sender: Any) {
        generalButtonFunction()
    }
    
    @IBAction func sunButtonPressed(_ sender: Any) {
        generalButtonFunction()
    }
    
    //  SECTION
    
}
