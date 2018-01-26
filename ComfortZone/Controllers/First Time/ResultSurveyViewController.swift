//
//  ResultSurveyViewController.swift
//  ComfortZone
//
//  Created by Diego Caroli on 13/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class ResultSurveyViewController: UIViewController {
  
  var profile: Profile!
  
  @IBOutlet weak var descriptionResultImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    descriptionResultImageView.image = profile.getComics()
  }
  
  @IBAction func nextButtonPressed(_ sender: UIButton) {
    UserDefaults.standard.set(false, forKey: "FirstTime")
    DataModel.shared.generateNewTodayTasks()
    
    let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
    present(tabBarController, animated: true, completion: nil)
  }
  
}

