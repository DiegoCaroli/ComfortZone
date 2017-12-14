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
}

class TrophiesViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var trophyCollectionView: UICollectionView!

    var trophyArray: [Trophy] = [Trophy(iconTrophy: #imageLiteral(resourceName: "Bug"), nameTrophy: "Bug Eater", descriptionTrophy: "Eat a bug"), Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Unlock Trophy", descriptionTrophy: "Wake up early. Go for a walk at sunrise and cook yourself a huge breakfast. Just because."), Trophy(iconTrophy: #imageLiteral(resourceName: "ZipLine"), nameTrophy: "Zipper", descriptionTrophy: "Go to zip lining"), Trophy(iconTrophy: #imageLiteral(resourceName: "lockedLeaf"), nameTrophy: "Lock Trophy", descriptionTrophy: "???"), Trophy(iconTrophy: #imageLiteral(resourceName: "lockedLeaf"), nameTrophy: "Lock Trophy", descriptionTrophy: "???"), Trophy(iconTrophy: #imageLiteral(resourceName: "lockedLeaf"), nameTrophy: "Lock Trophy", descriptionTrophy: "???"), Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Unlock Trophy", descriptionTrophy: "Go somewhere you shouldn’t be."), Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Unlock Trophy", descriptionTrophy: "I dont' have a description yet for this kind of trophy"), Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Unlock Trophy", descriptionTrophy: "Go to your favorite book store, and leave notes in your favorites books for future readers."), Trophy(iconTrophy: #imageLiteral(resourceName: "Hug"), nameTrophy: "Hug person", descriptionTrophy: "Give to a stranger an hug"), Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Unlock Trophy", descriptionTrophy: "I dont' have a description yet for this kind of trophy"), Trophy(iconTrophy: #imageLiteral(resourceName: "lockedLeaf"), nameTrophy: "Lock Trophy", descriptionTrophy: "???"), Trophy(iconTrophy: #imageLiteral(resourceName: "lockedLeaf"),nameTrophy: "Lock Trophy", descriptionTrophy: "???"), Trophy(iconTrophy: #imageLiteral(resourceName: "Karaoke"), nameTrophy: "Real singer", descriptionTrophy: "Sing karoke in a bar"), Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Unlock Trophy", descriptionTrophy: "Jump into a lake with your clothes on."), Trophy(iconTrophy: #imageLiteral(resourceName: "Trophie"), nameTrophy: "Unlock Trophy", descriptionTrophy: "Take a new way home from work."), Trophy(iconTrophy: #imageLiteral(resourceName: "lockedLeaf"),nameTrophy: "Lock Trophy", descriptionTrophy: "???")]
    
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
        let alert = UIAlertController(title: trophy.nameTrophy, message: trophy.descriptionTrophy, preferredStyle: .alert)
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
