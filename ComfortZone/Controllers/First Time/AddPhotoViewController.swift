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
    ImagePickerManager.shared.pickPhoto { image in
      self.profileImage = image
      self.profile.photoProfile = Photo(photoID: DataModel.shared.nextPhotoID())
      if let photoProfile = self.profile.photoProfile {
        photoProfile.save(image: image)
      }
    }
  }
  
  @IBAction func skipButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: "TakeSurvey", sender: profile)
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "TakeSurvey" {
      let surveyViewController = segue.destination as! SurveyViewController
      surveyViewController.profile = profile
    }
  }
  
}
