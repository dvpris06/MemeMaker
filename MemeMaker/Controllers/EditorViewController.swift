//
//  EditorViewController.swift
//  MemeMaker
//
//  Created by dragdimon on 18/12/2019.
//

import UIKit

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        setCommonFontStyle(topTextField)
        setCommonFontStyle(bottomTextField)
    }
    
    //MARK: imagePicker Methods
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
                
        switch sender {
        case cameraButton:
            imagePicker.sourceType = .camera
        case albumButton:
            imagePicker.sourceType = .photoLibrary
        default:
            print("Unknown type")
        }
                
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        memeImageView.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        memeImageView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Utility Methods
    
    func setCommonFontStyle(_ textField: UITextField) {
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)!,
            NSAttributedString.Key.strokeWidth: -3.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.adjustsFontSizeToFitWidth = true
        
        if textField.isEqual(topTextField) {
            textField.text = "TOP"
        } else {
            textField.text = "BOTTOM"
        }
    }


}

