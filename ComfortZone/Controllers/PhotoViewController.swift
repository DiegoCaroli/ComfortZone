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
  var cellFrame: CGRect!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    modalPresentationStyle = .custom
    transitioningDelegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let image = showPhoto {
       photo.image = image
    }
  }
  @IBAction func backButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func shareButton(_ sender: Any) {
    let activityVC = UIActivityViewController(activityItems: [showPhoto], applicationActivities: [])
    present(activityVC, animated: true, completion: nil)
  }
  
}

// MARK: - UIViewControllerTransitioningDelegate

extension PhotoViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let a = PhotoPresentAnimationController()
    a.originalFrame = cellFrame
    return a
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PhotoDismissAnimationController()
  }
}

// MARK: UINavigationBarDelegate
extension PhotoViewController: UINavigationBarDelegate {
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
}

