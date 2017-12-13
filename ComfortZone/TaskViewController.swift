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




class TaskViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var angryCloudButton: UIButton!
    
    @IBOutlet weak var sadCloudButton: UIButton!
    
    @IBOutlet weak var sunButton: UIButton!
    @IBOutlet weak var neutralCloudButton: UIButton!
    
    
    func generalButtonFunction(){
        scrollView.scrollToTop()
//        sunButton.isHidden = true
    
    }
    
    override func viewDidLoad() {
        
       
        super.viewDidLoad()
    }
    
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
    
}
