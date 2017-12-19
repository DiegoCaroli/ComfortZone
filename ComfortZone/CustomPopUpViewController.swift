//
//  CustomPopUpViewController.swift
//  ComfortZone
//
//  Created by Nicola Centonze on 18/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class CustomPopUpViewController: UIViewController {

    var todayTask: String = ""
    var typeTask: String = ""
    var imgTask: String = ""
    
    @IBOutlet weak var exitButtonPopUp: UIButton!
    @IBOutlet weak var typeTaskLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var taskLabelPopUp: UILabel!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
//      Pop Up Style
        popUpView.layer.cornerRadius = 20
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowRadius = 5.0
        popUpView.layer.shadowOpacity = 0.3
        
        imgView.image = UIImage(named: imgTask)
        taskLabelPopUp.text = todayTask
        typeTaskLabel.text = typeTask
        
        
        
    }

    @IBAction func exitButtonPopUpPressed(_ sender: Any) {

        dismiss(animated: true)
        
    }
    
}
