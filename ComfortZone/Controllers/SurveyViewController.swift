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
    
    titleSurveyLabel.text = QuestionStore.questions[0].text
    backgroundSurveyImageView.image = QuestionStore.questions[0].backgroundImage
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowResult" {
      let resultSurveyViewController = segue.destination as! ResultSurveyViewController
      resultSurveyViewController.profile = profile
    }
  }
  
  @IBAction func haveDoneButtonPressed(_ sender: Any) {
    calculateInitialProgress(points: 3)
    nextQuestion()
    profile.totalScore += 3

  }
  
  @IBAction func wantToDoButtonPressed(_ sender: Any) {
    calculateInitialProgress(points: 2)
    nextQuestion()
    profile.totalScore += 2
  }
  
  @IBAction func wouldNotDoButtonPressed(_ sender: Any) {
    calculateInitialProgress(points: 1)
    nextQuestion()
    profile.totalScore += 1
  }
  
  private func customizeButton(_ button: UIButton) {
    button.layer.cornerRadius = 10
    button.backgroundColor = UIColor.white
    button.layer.shadowColor = UIColor.gray.cgColor
    button.layer.shadowOffset = CGSize(width: 2, height: 4)
    button.layer.shadowOpacity = 0.8
  }
  
  private func nextQuestion() {
    self.index += 1
    if index < QuestionStore.questions.count {
      let question = QuestionStore.questions[index]
      titleSurveyLabel.text = question.text
      backgroundSurveyImageView.image = question.backgroundImage
      animate(question: titleSurveyLabel)
    } else {
      performSegue(withIdentifier: "ShowResult", sender: profile)
    }
  }
  
  private func calculateInitialProgress(points: Int) {
    switch index {
    case 0...2:
      DataModel.shared.profile.adrenalineScore += points
    case 3...5:
      DataModel.shared.profile.businessScore += points
    case 6...8:
      DataModel.shared.profile.lifestyleScore += points
    default:
      break
    }
  }
  
  private func animate(question: UILabel) {
    UIView.animate(withDuration: 0.5) {
      question.center.x = self.view.bounds.width
    }
  }
  
}
