//
//  Meme.swift
//  MemeMaker
//
//  Created by dragdimon on 18/12/2019.
//

import UIKit

struct Meme {
    var topMemeText: String
    var bottomMemeText: String
    
    var originalImage: UIImage
    var memedImage: UIImage
}

struct MemeData {
    static var allMemes = [Meme]()
}
