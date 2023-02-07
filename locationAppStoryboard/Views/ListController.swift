import Foundation
import UIKit

class TableListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var landmarksArray: [Landmark] = []
    var favLandmarksArray: [Landmark] = []
    var dataManager = DataManager()
    
    
    var showsFavorites = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.landmarksArray = dataManager.fetchData()
        
        for landmark in self.landmarksArray {
            if(landmark.isFavorite == true) {
                favLandmarksArray.append(landmark)
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CostumTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
     }
}

extension TableListViewController: UITableViewDataSource, UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(showsFavorites == false) {
            return self.landmarksArray.count
        } else {
            return self.favLandmarksArray.count
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CostumTableViewCell
        
        cell.delegate = self
        
        cell.detail = landmarksArray[indexPath.row]
        
        cell.landmarkName.text = landmarksArray[indexPath.row].name
        
        let imageName = landmarksArray[indexPath.row].name
        let lowerStr = imageName.lowercased()
        let trimmedString = lowerStr.replacingOccurrences(of: " ", with: "")
        
        cell.landmarkIcon.image = UIImage(named: "\(trimmedString)")
        
        cell.landmarkAddToFav.image = landmarksArray[indexPath.row].isFavorite == false ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.detail = landmarksArray[indexPath.row]
        
        vc.onReload = { model in
            self.landmarksArray[indexPath.row] = model
            self.tableView.reloadData()
            print("onreload")
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension TableListViewController: LandmarkDataStore {
    
    func storeLandmark(landmark: Landmark?) {
        if let landmarkModel = landmark {
            if let index = landmarksArray.firstIndex(where: { model in
                return model.id == landmarkModel.id
            }) {
                landmarksArray[index] = landmarkModel
            }
        }
    }
    
}


