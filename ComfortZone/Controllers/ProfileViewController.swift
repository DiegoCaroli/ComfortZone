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
  @IBOutlet weak var photoCollectionView: UICollectionView!
  
  var profile: Profile!
  
    var photoArray = [UIImage(named: "memoryIcon")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      profile = DataModel.shared.profile
      
      fullNameLabel.text = profile.fullName
      if let photoProfile = profile.photoProfile {
        profileImageView.image = UIImage(contentsOfFile: photoProfile.photoURL.path)
      }
      
      profileImageView.layer.cornerRadius = profileImageView.bounds.size.width / 2
      profileImageView.clipsToBounds = true
    }

   override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
    scrollView.contentOffset = CGPoint(x: 0, y: 0)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.memoryIcon.image = photoArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStroboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let photoVC = mainStroboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        photoVC.showPhoto = photoArray[indexPath.row]!
        self.navigationController?.pushViewController(photoVC, animated: true)
    }

}
