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
    var showPhoto = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationController?.isNavigationBarHidden = false
        self.photo.image = self.showPhoto
        photo.image = showPhoto
    }

}
