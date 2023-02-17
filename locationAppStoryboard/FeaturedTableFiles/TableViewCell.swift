//
//  TableViewCell.swift
//  locationAppStoryboard
//
//  Created by Mak Mulabegovic on 14. 2. 2023..
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var landmarksArray: [Landmark] = []
    var dataManager = DataManager()


    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


extension TableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return landmarksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionView
        
        let item = landmarksArray[indexPath.row]
        
        cell.imageView.image = item.image
        cell.imageName.text = item.name
        return cell
    }
}
