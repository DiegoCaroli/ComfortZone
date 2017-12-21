//
//  TrophiesViewController.swift
//  ComfortZone
//
//  Created by Ibrahim Al Hazwani on 13/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class TrophiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var trophyCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    trophyCollectionView.reloadData()
    trophyCollectionView.contentOffset = CGPoint(x: 0, y: 0)
    
    tabBarController?.tabBar.items![2].badgeValue = nil
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return DataModel.shared.profile.trophies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrophyCollectionViewCell
    let trophy = DataModel.shared.profile.trophies[indexPath.row]
    
    if !trophy.isLocked {
      cell.imageTrophy.image = UIImage(named: trophy.iconName)
    } else {
      cell.imageTrophy.image = #imageLiteral(resourceName: "lockedLeaf")
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let trophy = DataModel.shared.profile.trophies[indexPath.row]
    let alert = UIAlertController(title: trophy.isLocked ? "Locked Trophy" : trophy.name, message: trophy.isLocked ? "???" : trophy.description, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}
