//
//  DetailViewController.swift
//  MemeMaker
//
//  Created by dragdimon on 19/12/2019.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: Outlets and Properties
    @IBOutlet weak var imageView: UIImageView!
    var selectedMeme: Meme!
    
    //MARK: UIView lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = selectedMeme.memedImage
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegueToEditorVC" {
            let vc = segue.destination as! EditorViewController
            vc.defaultTopText = selectedMeme.topMemeText
            vc.defaultBottomText = selectedMeme.bottomMemeText
            vc.selectedImage = selectedMeme.originalImage
        }
    }
}
