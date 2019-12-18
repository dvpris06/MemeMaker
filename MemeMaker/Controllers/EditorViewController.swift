//
//  EditorViewController.swift
//  MemeMaker
//
//  Created by dragdimon on 18/12/2019.
//

import UIKit

class EditorViewController: UIViewController {

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
        // Do any additional setup after loading the view.
    }


}

