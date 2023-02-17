import UIKit

protocol LandmarkDataStore {    
    func storeLandmark(landmark: Landmark?)
}

class CostumTableViewCell: UITableViewCell {

    @IBOutlet weak var landmarkCell: UIView!
    @IBOutlet weak var landmarkIcon: UIImageView!
    @IBOutlet weak var landmarkName: UILabel!
    @IBOutlet weak var landmarkAddToFav: UIImageView!
    
    
    var detail: Landmark?
    var delegate: LandmarkDataStore?

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func changeStarStatus(_ sender: Any) {
        
        let status = self.detail?.isFavorite
        
        self.detail?.isFavorite = !status!
        
        if(self.detail?.isFavorite == true) {
            self.landmarkAddToFav.image = UIImage(systemName: "star.fill")
        }   else {
            self.landmarkAddToFav.image = UIImage(systemName: "star")
        }
        
        self.delegate?.storeLandmark(landmark: self.detail)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
