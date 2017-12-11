//
//  SurveyViewController.swift
//  ComfortZone
//
//  Created by Mariapia Pansini on 11/12/17.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    @IBOutlet weak var haveDone: UIButton!
    @IBOutlet weak var wantToDo: UIButton!
    @IBOutlet weak var wouldNotDo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButton(haveDone)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func customizeButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
    }
    
}


