//
//  TableViewController.swift
//  MemeMaker
//
//  Created by dragdimon on 18/12/2019.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeData.allMemes.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)

        let currentMeme = MemeData.allMemes[indexPath.row]
        
        let cellImageView = cell.viewWithTag(1) as! UIImageView
        cellImageView.image = currentMeme.memedImage
        
        let topText = currentMeme.topMemeText
        let bottomText = currentMeme.bottomMemeText
        let labelText = topText + bottomText
        
        let cellLabel = cell.viewWithTag(2) as! UILabel
        cellLabel.text = labelText

        return cell
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tableViewSegueToDetail" {
            let sendingCell = sender as! UITableViewCell
            let sendingCellIndexPath = tableView.indexPath(for: sendingCell)!
            let selectedMeme = sendingCellIndexPath.row
            
            let controller = segue.destination as! DetailViewController
            controller.selectedMeme = MemeData.allMemes[selectedMeme]
        }
    }
    

}
