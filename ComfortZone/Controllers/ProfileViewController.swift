//
//  ProfileViewController.swift
//  ComfortZone
//
//  Created by Mariapia Pansini on 14/12/17.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var businessProgressImageView: UIImageView!
  @IBOutlet weak var adrenalineProgressImageView: UIImageView!
  @IBOutlet weak var lifestyleProgressImageView: UIImageView!
  @IBOutlet weak var humorProgressImageView: UIImageView!
  @IBOutlet weak var photoCollectionView: UICollectionView!

  var profile: Profile!
  
  var memories: [UIImage] = [] {
    didSet {
  photoCollectionView.reloadData()
    }
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      profile = DataModel.shared.profile
      
      fullNameLabel.text = profile.fullName
      if let photoProfile = profile.photoProfile {
        profileImageView.image = UIImage(contentsOfFile: photoProfile.photoURL.path)
      }
      
      profileImageView.layer.cornerRadius = profileImageView.bounds.size.width / 2
      profileImageView.clipsToBounds = true
      
      humorProgressImageView.image = setHappiness()
      
      configureProgressBar(score: profile.adrenalineScore, typeImageView: adrenalineProgressImageView, imageType: "Adrenaline")
      configureProgressBar(score: profile.businessScore, typeImageView: businessProgressImageView, imageType: "Business")
      configureProgressBar(score: profile.lifestyleScore, typeImageView: lifestyleProgressImageView, imageType: "Lifestyle")
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    memories = []
    

    
    for i in DataModel.shared.profile.memories {
      if let memoryPhoto = UIImage(contentsOfFile: i.photoURL.path) {
        self.memories.append(memoryPhoto)
      }
    }
    
    humorProgressImageView.image = setHappiness()
//    configureProgressBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
    scrollView.contentOffset = CGPoint(x: 0, y: 0)
  }
  
  private func configureProgressBar(score: Int, typeImageView: UIImageView, imageType: String) {
    switch score {
    case 0...3:
      typeImageView.image = UIImage(named: "levelZero\(imageType)")
    case 4...6:
      typeImageView.image = UIImage(named: "levelOne\(imageType)")
    case 7...8:
      typeImageView.image = UIImage(named: "levelTwo\(imageType)")
    default:
      typeImageView.image = UIImage(named: "levelThree\(imageType)")
    }
  }
  
  func setHappiness() -> UIImage {
    switch profile.happiness {
    case 0:
      return #imageLiteral(resourceName: "cloudsEmotionSadTwo")
    case 1:
      return #imageLiteral(resourceName: "cloudsEmotionSadOne")
    case 2:
      return #imageLiteral(resourceName: "cloudsEmotionHappyOne")
    case 3:
      return #imageLiteral(resourceName: "cloudsEmotionHappyTwo")
    default:
      return #imageLiteral(resourceName: "cloudsEmotionNeutral")
    }
    
  }
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
    print(memories[indexPath.row])
    cell.memoryIcon.image = memories[indexPath.row]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let mainStroboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
    let photoVC = mainStroboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
    photoVC.showPhoto = memories[indexPath.row]
    self.navigationController?.pushViewController(photoVC, animated: true)
  }

}
