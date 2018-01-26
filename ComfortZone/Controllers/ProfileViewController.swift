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

  @IBOutlet weak var imageProfileLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var fullNameLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var progressLayoutContraint: NSLayoutConstraint!
  @IBOutlet weak var humorLayoutConstaint: NSLayoutConstraint!
  @IBOutlet weak var memoriesLayoutConstaint: NSLayoutConstraint!
  @IBOutlet weak var collectionViewLayoutConstraints: NSLayoutConstraint!
  @IBOutlet weak var memoryLabel: UILabel!
  
  var profile: Profile!
  var profileImage: UIImage? {
    didSet {
      profileImageView.image = profileImage
    }
  }
  var memories: [UIImage]! {
    didSet {
      if memories.isEmpty {
        memoryLabel.isHidden = true
        scrollView.isScrollEnabled = false
      } else {
        memoryLabel.isHidden = false
        scrollView.isScrollEnabled = true
      }
    }
  }
  var selectedIndexPath: IndexPath!

  override func viewDidLoad() {
    super.viewDidLoad()
    memories = []
    
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    profile = DataModel.shared.profile
    fullNameLabel.text = profile.fullName
    if let photoProfile = profile.photoProfile {
      profileImageView.image = UIImage(contentsOfFile: photoProfile.photoURL.path)
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
    profileImageView.addGestureRecognizer(tapGesture)
    profileImageView.isUserInteractionEnabled = true
    profileImageView.layer.cornerRadius = profileImageView.bounds.size.width / 2
    profileImageView.clipsToBounds = true
    
    humorProgressImageView.image = setHappiness()
    configureProgressBars()
    
    if UIScreen.main.bounds.height == 736 {
      imageProfileLayoutConstraint.constant = 38
      fullNameLayoutConstraint.constant = 12
      progressLayoutContraint.constant = 27
      humorLayoutConstaint.constant = 27
      memoriesLayoutConstaint.constant = 28
      collectionViewLayoutConstraints.constant = 38
      let layout = photoCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
      layout.minimumLineSpacing = 20
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
     memories = []
    for i in DataModel.shared.profile.memories {
      if let memoryPhoto = UIImage(contentsOfFile: i.photoURL.path) {
        self.memories.append(memoryPhoto)
      }
    }
    
    photoCollectionView.reloadData()
    humorProgressImageView.image = setHappiness()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.isNavigationBarHidden = true

    configureProgressBars()
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
  
  private func configureProgressBars() {
    configureProgressBar(score: profile.adrenalineScore, typeImageView: adrenalineProgressImageView, imageType: "Adrenaline")
    configureProgressBar(score: profile.businessScore, typeImageView: businessProgressImageView, imageType: "Business")
    configureProgressBar(score: profile.lifestyleScore, typeImageView: lifestyleProgressImageView, imageType: "Lifestyle")
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
    cell.memoryIcon.image = memories[indexPath.row]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let mainStroboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
    let photoVC = mainStroboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
    photoVC.showPhoto = memories[indexPath.row]
    selectedIndexPath = indexPath
    
    navigationController?.pushViewController(photoVC, animated: true)
  }
  
  @objc func handleTap(sender: UITapGestureRecognizer) {
    ImagePickerManager.shared.pickPhoto { image in
      self.profileImage = image
      self.profile.photoProfile?.remove()
      self.profile.photoProfile = Photo(photoID: DataModel.shared.nextPhotoID())
      if let theImage = self.profile.photoProfile {
        theImage.save(image: image)
      }
    }
  }
}

//MARK: - ZoomingViewController
extension ProfileViewController : ZoomingViewController {
  func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
    return nil
  }
  
  func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
    if let indexPath = selectedIndexPath {
      let cell = photoCollectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
      return cell.memoryIcon
    } else {
      return nil
    }
  }
}
