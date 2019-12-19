//
//  DetailViewController.swift
//  MemeMaker
//
//  Created by dragdimon on 19/12/2019.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var selectedMeme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = selectedMeme.memedImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegueToEditorVC" {
            let vc = segue.destination as! EditorViewController
            vc.defaultTopText = selectedMeme.topMemeText
            vc.defaultBottomText = selectedMeme.bottomMemeText
            vc.selectedImage = selectedMeme.originalImage
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
