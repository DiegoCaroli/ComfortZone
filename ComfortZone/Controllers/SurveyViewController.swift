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
  
  var counter = 0
  var index = 0
  var score = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    customizeButton(haveDone)
    customizeButton(wantToDo)
    customizeButton(wouldNotDo)
    
    nextQuestion(index: index)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  @IBAction func haveDoneButtonPressed(_ sender: Any) {
    nextQuestion(index: index)
    score += 3
  }
  
  @IBAction func wantToDoButtonPressed(_ sender: Any) {
    nextQuestion(index: index)
    score += 2
  }
  
  @IBAction func wouldNotDoButtonPressed(_ sender: Any) {
    nextQuestion(index: index)
    score += 1
  }
  
  private func customizeButton(_ button: UIButton) {
    button.layer.cornerRadius = 10
//    button.layer.borderColor = UIColor.black.cgColor
//    button.layer.borderWidth = 1.3
    button.backgroundColor = UIColor.white
    button.layer.shadowColor = UIColor.gray.cgColor
    button.layer.shadowOffset = CGSize(width: 2, height: 4)
    button.layer.shadowOpacity = 0.8
  }
  
  private func nextQuestion(index: Int) {
    if index < DataQuestion.shared.questions.count {
      let question = DataQuestion.shared.questions[index]
      titleSurveyLabel.text = question.text
      backgroundSurveyImageView.image = question.backgroundImage
    } else {
      let resultSurveyViewController = UIStoryboard(name: "Survey", bundle: nil).instantiateViewController(withIdentifier: "ResultSurveyViewController") as! ResultSurveyViewController
      present(resultSurveyViewController, animated: true, completion: nil)
      
    }
    self.index += 1
  }
  
}
