//
//  CollectionViewController.swift
//  MemeMaker
//
//  Created by dragdimon on 19/12/2019.
//

import UIKit

private let reuseIdentifier = "collectionCell"

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeData.allMemes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        let cellImageView = cell.viewWithTag(1) as! UIImageView
        cellImageView.image = MemeData.allMemes[indexPath.row].memedImage
        
        let cellLabel = cell.viewWithTag(2) as! UILabel
        
        let topLabel = MemeData.allMemes[indexPath.row].topMemeText
        let bottomLabel = MemeData.allMemes[indexPath.row].bottomMemeText
        cellLabel.text = topLabel + bottomLabel
    
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionViewSegueToDetail" {
            let sendingCell = sender as! UICollectionViewCell
            let sendingCellIndexPath = collectionView!.indexPath(for: sendingCell)!
            let selectedMeme = sendingCellIndexPath.row
            
            let controller = segue.destination as! DetailViewController
            controller.selectedMeme = MemeData.allMemes[selectedMeme]
        }
    }

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/2 - 7, height: collectionWidth/2 - 7)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}
