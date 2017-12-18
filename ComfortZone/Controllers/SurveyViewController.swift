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
  @IBOutlet weak var titleSurveyLabel: UILabel!
  @IBOutlet weak var backgroundSurveyImageView: UIImageView!
  
  var profile: Profile!
  var index = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    customizeButton(haveDone)
    customizeButton(wantToDo)
    customizeButton(wouldNotDo)
    
    nextQuestion(index: index)
  }
  
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowResult" {
      let resultSurveyViewController = segue.destination as! ResultSurveyViewController
      resultSurveyViewController.profile = sender as! Profile
    }
  }
  
  @IBAction func haveDoneButtonPressed(_ sender: Any) {
    nextQuestion(index: index)
    profile.totalScore += 3
  }
  
  @IBAction func wantToDoButtonPressed(_ sender: Any) {
    nextQuestion(index: index)
    profile.totalScore += 2
  }
  
  @IBAction func wouldNotDoButtonPressed(_ sender: Any) {
    nextQuestion(index: index)
    profile.totalScore += 1
  }
  
  private func customizeButton(_ button: UIButton) {
    button.layer.cornerRadius = 10
    button.backgroundColor = UIColor.white
    button.layer.shadowColor = UIColor.gray.cgColor
    button.layer.shadowOffset = CGSize(width: 2, height: 4)
    button.layer.shadowOpacity = 0.8
  }
  
  private func nextQuestion(index: Int) {
    if index < QuestionStore.shared.questions.count {
      let question = QuestionStore.shared.questions[index]
      titleSurveyLabel.text = question.text
      backgroundSurveyImageView.image = question.backgroundImage
    } else {
      performSegue(withIdentifier: "ShowResult", sender: profile)
      
    }
    self.index += 1
  }
  
}
