//
//  SignUpViewController.swift
//  ComfortZone
//
//  Created by Diego Caroli on 13/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
  
  @IBOutlet weak var firstNameTextField: UITextField! {
    didSet {
      firstNameTextField.delegate = self
      firstNameTextField.returnKeyType = .next
    }
  }
  
  @IBOutlet weak var lastNameTextField: UITextField! {
    didSet {
      lastNameTextField.delegate = self
      lastNameTextField.returnKeyType = .next
    }
  }
  
  @IBOutlet weak var emailTextField: UITextField! {
    didSet {
      emailTextField.delegate = self
    }
  }
  
  var profile: Profile!
  
  @IBOutlet weak var signupButton: UIButton!
  @IBOutlet weak var scrollView: UIScrollView!
  
  var isFirstNameActive = false
  var isLastNameActive = false
  var isEmailActive = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    profile = DataModel.shared.profile
    
    firstNameTextField.becomeFirstResponder()
    
    scrollView.isScrollEnabled = false
    scrollView.contentInsetAdjustmentBehavior = .never
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
    view.addGestureRecognizer(tapGesture)
    view.isUserInteractionEnabled = true
    
    navigationController?.isNavigationBarHidden = true
  }
  
  @IBAction func signupButtonPressed(_ sender: Any) {
    guard let firstName = firstNameTextField.text,
      let lastName = lastNameTextField.text,
      let email = emailTextField.text else {
        return
    }
    
    profile.firstName = firstName
    profile.lastName = lastName
    profile.email = email
    
    performSegue(withIdentifier: "AddPhoto", sender: profile)
  }
  
  @objc func viewTapped(sender: UITapGestureRecognizer) {
    firstNameTextField.resignFirstResponder()
    lastNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddPhoto" {
      let addPhotoViewController = segue.destination as! AddPhotoViewController
      addPhotoViewController.profile = profile
    }
  }
  
}

extension SignUpViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText = textField.text!
    let stringRange = Range(range, in:oldText)!
    let newText = oldText.replacingCharacters(in: stringRange,
                                              with: string)
    
    if newText.isEmpty {
      if textField == firstNameTextField {
        isFirstNameActive = false
      } else if textField == lastNameTextField {
        isLastNameActive = false
      } else {
        isEmailActive = false
      }
    } else {
      if textField == firstNameTextField {
        isFirstNameActive = true
      } else if textField == lastNameTextField {
        isLastNameActive = true
      } else {
        isEmailActive = true
      }
    }
    
    signupButton.isEnabled = isFirstNameActive && isLastNameActive && isEmailActive ? true : false
    
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case firstNameTextField:
      lastNameTextField.becomeFirstResponder()
    case lastNameTextField:
      emailTextField.becomeFirstResponder()
    default:
      emailTextField.resignFirstResponder()
    }
    
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == emailTextField {
      scrollView.setContentOffset(CGPoint(x: 0, y: 205), animated: true)
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == emailTextField {
      scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
  }
  
}
