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
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.view.backgroundColor = .clear
    
    if let image = showPhoto {
       photo.image = image
    }
  }
  
  @IBAction func shareButton(_ sender: Any) {
    let activityVC = UIActivityViewController(activityItems: [showPhoto], applicationActivities: [])
    present(activityVC, animated: true, completion: nil)
  }
  
}

//MARK: - ZoomingViewController
extension PhotoViewController: ZoomingViewController {
  func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
    return nil
  }
  
  func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
    return photo
  }
}
