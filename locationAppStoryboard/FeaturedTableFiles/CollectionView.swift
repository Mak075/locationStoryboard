//
//  CollectionView.swift
//  locationAppStoryboard
//
//  Created by Mak Mulabegovic on 14. 2. 2023..
//

import UIKit

class CollectionView: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    var landmarks: [Landmark] = []
    
}
