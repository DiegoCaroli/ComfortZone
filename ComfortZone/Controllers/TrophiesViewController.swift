//
//  TrophiesViewController.swift
//  ComfortZone
//
//  Created by Ibrahim Al Hazwani on 13/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class TrophiesViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var trophyCollectionView: UICollectionView!
  
  var trophyArray: [Trophy] = [Trophy(iconName: "Bug", name: "Bug eater", description: "Eat a bug", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Lock Trophy", description: "Wake up early. Go for a walk at sunrise and cook yourself a huge breakfast. Just because.", isLocked: true),
                               Trophy(iconName: "ZipLine" , name: "Human zipper", description: "Go to zip lining", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Dirty dancer", description: "Drive around, crank your favorite songs and have a dance off at stoplights to make strangers laugh.", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Ready for the future", description: "Create your cv", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Give me my dessert", description: "Go to a restaurant, order and eat dessert first.", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Adventure", description: "Go somewhere you shouldn’t be.", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Midnight picnic", description: "Have a midnight picnic.", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Give some post-it", description: "Go to your favorite book store, and leave notes in your favorites books for future readers.", isLocked: true),
                               Trophy(iconName: "Hug", name: "Free Hugs", description: "Give to a stranger an hug", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Business man", description: "Invest 10€ and to gain 11€.", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Into the wild", description: "Travel alone.", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Fancy lunch", description: "Go to lunch by yourself.", isLocked: true),
                               Trophy(iconName: "Karaoke", name: "True singer", description: "Sing karoke in a bar", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Wild swimmer", description: "Jump into a lake or something with water with your clothes on.", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Explorer", description: "Take a new way home from work.", isLocked: true),
                               Trophy(iconName: "Trophie", name: "Learn from your mistakes", description: "Ask for constructive criticism at work.", isLocked: true)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return trophyArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrophyCollectionViewCell
    let trophy = trophyArray[indexPath.row]
    
    if !trophy.isLocked {
      cell.imageTrophy.image = UIImage(named: trophy.iconName)
    } else {
      cell.imageTrophy.image = #imageLiteral(resourceName: "lockedLeaf")
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let trophy = trophyArray[indexPath.row]
    let alert = UIAlertController(title: trophy.isLocked ? "Locked Trophy" : trophy.name, message: trophy.isLocked ? "???" : trophy.description, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}
