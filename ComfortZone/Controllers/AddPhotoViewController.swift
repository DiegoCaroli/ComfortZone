//
//  AddPhotoViewController.swift
//  ComfortZone
//
//  Created by Diego Caroli on 14/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var skipButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  
  var profileImage: UIImage? {
    didSet {
      profileImageView.image = profileImage
      profileImageView.layer.cornerRadius = profileImageView.layer.frame.size.width / 2
      profileImageView.clipsToBounds = true
      skipButton.isHidden = true
      addButton.isHidden = true
      nextButton.isHidden = false
    }
  }
  var profile: Profile!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func addPhotoButtonPressed(_ sender: Any) {
    pickPhoto()
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

//MARK: - UIImagePickerControllerDelegate
extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func pickPhoto() {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      showPhotoMenu()
    } else {
      choosePhotoFromLibrary()
    }
  }
  
  func showPhotoMenu() {
    let alertController = UIAlertController(title: nil, message: nil,
                                            preferredStyle: .actionSheet)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in self.takePhotoWithCamera() })
    
    alertController.addAction(takePhotoAction)
    
    let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in self.choosePhotoFromLibrary() })
    
    alertController.addAction(chooseFromLibraryAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  func takePhotoWithCamera() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  func choosePhotoFromLibrary() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    
    profileImage = info[UIImagePickerControllerEditedImage] as? UIImage
    
//    if let theImage = image {
//      show(image: theImage)
//    }
    
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}
