//
//  AddPhotoViewController.swift
//  ComfortZone
//
//  Created by Diego Caroli on 14/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
  
  var profile: Profile!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    print(profile)
    print(profile.fullName)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func addPhotoButtonPressed(_ sender: Any) {
  }
  
  @IBAction func skipButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: "TakeSurvey", sender: profile)
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "TakeSurvey" {
      let surveyViewController = segue.destination as! SurveyViewController
      surveyViewController.profile = sender as! Profile
    }
  }
  
}
