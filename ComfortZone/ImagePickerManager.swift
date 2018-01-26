//
//  ImagePickerManager.swift
//  Image
//
//  Created by Diego Caroli on 02/01/2018.
//  Copyright © 2018 Diego Caroli. All rights reserved.
//

import Foundation
import UIKit

typealias ImageHandler = (UIImage) -> Void

class ImagePickerManager: NSObject, UINavigationControllerDelegate {
  
  static let shared = ImagePickerManager()
  
  private var image: UIImage?
  private var imageCompletionHandler: ImageHandler?
  
  var topMostController: UIViewController {
    var topController = UIApplication.shared.keyWindow?.rootViewController
    
    while (topController!.presentedViewController != nil) {
      topController = topController?.presentedViewController
    }
    
    return topController!
  }
  
  func pickPhoto(completionHandler: @escaping ImageHandler) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      showPhotoMenu()
    } else {
      choosePhotoFromLibrary()
    }
    
    imageCompletionHandler = completionHandler
  }
  
  private func showPhotoMenu() {
    let alertController = UIAlertController(title: nil, message: nil,
                                            preferredStyle: .actionSheet)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in self.takePhotoWithCamera() })
    
    alertController.addAction(takePhotoAction)
    
    let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in self.choosePhotoFromLibrary() })
    
    alertController.addAction(chooseFromLibraryAction)
    
    topMostController.present(alertController, animated: true, completion: nil)
  }
  
  private func takePhotoWithCamera() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    topMostController.present(imagePicker, animated: true, completion: nil)
  }
  
  private func choosePhotoFromLibrary() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    topMostController.present(imagePicker, animated: true, completion: nil)
  }
}

//MARK: - UIImagePickerControllerDelegate
extension ImagePickerManager: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    
    image = info[UIImagePickerControllerEditedImage] as? UIImage
    
    DispatchQueue.main.async {
      if let theImage = self.image,
        let completionHandler = self.imageCompletionHandler {
        completionHandler(theImage)
        
        // Breaks reference cycle so this object can deinit.
        self.imageCompletionHandler = nil
      }
    }
    
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
}
