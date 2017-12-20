//
//  PhotoViewController.swift
//  ComfortZone
//
//  Created by Mariapia Pansini on 15/12/17.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
  
  @IBOutlet weak var photo: UIImageView!
  var showPhoto: UIImage!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.isNavigationBarHidden = false
    if let image = showPhoto {
       photo.image = image
    }
  }
  
  @IBAction func shareButton(_ sender: Any) {
    let activityVC = UIActivityViewController(activityItems: [showPhoto], applicationActivities: [])
    present(activityVC, animated: true, completion: nil)
  }
  
  
}
