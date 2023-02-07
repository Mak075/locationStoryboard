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
        
//        print(self.detail?.name, self.detail?.isFavorite)

        var status = self.detail?.isFavorite
//        print("details was status",status)
        
        self.detail?.isFavorite = !status!
//        print("after is now button",self.detail?.isFavorite)
        
        if(self.detail?.isFavorite == true) {
            self.landmarkAddToFav.image = UIImage(systemName: "star.fill")
        }   else {
            self.landmarkAddToFav.image = UIImage(systemName: "star")
        }
        
//        print(self.detail?.name, self.detail?.isFavorite)
        self.delegate?.storeLandmark(landmark: self.detail)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
