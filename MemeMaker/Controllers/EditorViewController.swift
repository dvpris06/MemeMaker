//
//  EditorViewController.swift
//  MemeMaker
//
//  Created by dragdimon on 18/12/2019.
//

import UIKit

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: Outlets and properties
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    var memedImage: UIImage!
    
    //MARK: UIView lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        topTextField.delegate = self
        bottomTextField.delegate = self
    
        setCommonFontStyle(topTextField)
        setCommonFontStyle(bottomTextField)
        
        subscribeToKeyboardNotifications()
    }
    
    //MARK: Actions
    
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
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        memedImage = generateMemedImage()
        
        if let image = memeImageView.image {
            let meme = Meme(topMemeText: topTextField.text!,
                            bottomMemeText: bottomTextField.text!,
                            originalImage: image,
                            memedImage: memedImage)
            MemeData.allMemes.append(meme)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: imagePicker Methods

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        memeImageView.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        memeImageView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Keyboard Methods
    
    func subscribeToKeyboardNotifications() {
        
        // watch for the keyboard to show
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(EditorViewController.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        // watch for the keyboard to hide
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(EditorViewController.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        // no longer need to watch for keyboard to show
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        
        // no longer need to watch for keyboard to hide
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func dismissKeyboard(_ textField: UITextField) {
        
        // dismiss the keyboard
        textField.endEditing(true)
        textField.resignFirstResponder()
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
    
    func generateMemedImage() -> UIImage {
        navBar.isHidden = true
        toolBar.isHidden = true
        
        // Render view to an image, using a context
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
          
        navBar.isHidden = false
        toolBar.isHidden = false
    
        return memedImage
      }
      
    //MARK: TextFieldDelegate Methods
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           dismissKeyboard(textField)
           return true
       }
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField.text! == "TOP" || textField.text! == "BOTTOM" {
               textField.text = ""
           }
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           if textField.text!.isEmpty {
               if textField.isEqual(topTextField){
                   textField.text = "TOP"
               } else {
                   textField.text = "BOTTOM"
               }
           }
       }
       
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           
           let currentText = textField.text! as NSString
           let capitalizedText = currentText.replacingCharacters(in: range, with: string.uppercased())
           
           textField.text = capitalizedText
           
           return false
       }


}

