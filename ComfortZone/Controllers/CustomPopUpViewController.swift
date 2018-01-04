//
//  CustomPopUpViewController.swift
//  ComfortZone
//
//  Created by Nicola Centonze on 18/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class CustomPopUpViewController: UIViewController {
  
  @IBOutlet weak var exitButtonPopUp: UIButton!
  @IBOutlet weak var typeTaskLabel: UILabel!
  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var popUpView: UIView!
  @IBOutlet weak var taskLabelPopUp: UILabel!
  
  var task: Task!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    modalPresentationStyle = .custom
    transitioningDelegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //      Pop Up Style
    popUpView.layer.cornerRadius = 20
    popUpView.layer.shadowColor = UIColor.black.cgColor
    popUpView.layer.shadowRadius = 5.0
    popUpView.layer.shadowOpacity = 0.3
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
    view.addGestureRecognizer(tapGesture)
    
    imgView.image = task.getTypeImage()
    taskLabelPopUp.text = task.name
    typeTaskLabel.text = task.titleTypeTask
  }
  
  @objc func viewTapped(sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func exitButtonPopUpPressed(_ sender: Any) {
    dismiss(animated: true)
  }
  
}

//MARK: - UIViewControllerTransitioningDelegate
extension CustomPopUpViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PopupPresentAnimationController()
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PopupDismissAnimationController()
  }
}
