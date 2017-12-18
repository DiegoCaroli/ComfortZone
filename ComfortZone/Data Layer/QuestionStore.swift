//
//  QuestionStore.swift
//  ComfortZone
//
//  Created by Diego Caroli on 12/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import Foundation

final class QuestionStore {
  static var questions: [Question] = [
    Question(text: "done bungee jumping", backgroundImage: #imageLiteral(resourceName: "BungeeJumping")),
    Question(text: "done climbing mountain", backgroundImage: #imageLiteral(resourceName: "ClimbingMountain")),
    Question(text: "done paintballing", backgroundImage: #imageLiteral(resourceName: "Paintballing")),
    Question(text: "done public speaking", backgroundImage: #imageLiteral(resourceName: "PublicSpeakingView")),
    Question(text: "started your own business", backgroundImage: #imageLiteral(resourceName: "OwnBusinesView")),
    Question(text: "worked in a different Country", backgroundImage: #imageLiteral(resourceName: "JobContryView")),
    Question(text: "travelled alone", backgroundImage: #imageLiteral(resourceName: "FirstStep")),
    Question(text: "quitted a job", backgroundImage: #imageLiteral(resourceName: "SecondStep")),
    Question(text: "became comfortable with dating", backgroundImage: #imageLiteral(resourceName: "ThirdStep"))
  ]
}
