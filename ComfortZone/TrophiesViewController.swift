//
//  TrophiesViewController.swift
//  ComfortZone
//
//  Created by Ibrahim Al Hazwani on 13/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

struct Trophy {
    let iconTrophy: UIImage
    var nameTrophy: String
    let descriptionTrophy: String
    var isLocked: Bool
}

class TrophiesViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var trophyCollectionView: UICollectionView!

    var trophyArray: [Trophy] = [Trophy(iconTrophy: #imageLiteral(resourceName: "Bug"), nameTrophy: "Bug eater", descriptionTrophy: "Eat a bug", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Lock Trophy", descriptionTrophy: "Wake up early. Go for a walk at sunrise and cook yourself a huge breakfast. Just because.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "ZipLine") , nameTrophy: "Human zipper", descriptionTrophy: "Go to zip lining", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Dirty dancer", descriptionTrophy: "Drive around, crank your favorite songs and have a dance off at stoplights to make strangers laugh.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Ready for the future", descriptionTrophy: "Create your cv", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Give me my dessert", descriptionTrophy: "Go to a restaurant, order and eat dessert first.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Adventure", descriptionTrophy: "Go somewhere you shouldn’t be.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Midnight picnic", descriptionTrophy: "Have a midnight picnic.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Give some post-it", descriptionTrophy: "Go to your favorite book store, and leave notes in your favorites books for future readers.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Hug"), nameTrophy: "Free Hugs", descriptionTrophy: "Give to a stranger an hug", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Business man", descriptionTrophy: "Invest 10€ and to gain 11€.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Into the wild", descriptionTrophy: "Travel alone.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Fancy lunch", descriptionTrophy: "Go to lunch by yourself.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Karaoke"), nameTrophy: "True singer", descriptionTrophy: "Sing karoke in a bar", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Wild swimmer", descriptionTrophy: "Jump into a lake or something with water with your clothes on.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Explorer", descriptionTrophy: "Take a new way home from work.", isLocked: true),
                                 Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Learn from your mistakes", descriptionTrophy: "Ask for constructive criticism at work.", isLocked: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trophyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrophyCollectionViewCell
        let trophy = trophyArray[indexPath.row]
        
        cell.imageTrophy.image = trophy.iconTrophy
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let trophy = trophyArray[indexPath.row]
        let alert = UIAlertController(title: trophy.isLocked ? "Locked Trophie" : trophy.nameTrophy, message: trophy.isLocked ? "???" : trophy.descriptionTrophy, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
