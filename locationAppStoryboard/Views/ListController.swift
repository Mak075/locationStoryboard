import Foundation
import UIKit

class TableListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var favoritesOnlyBg: UIView!
    
    @IBOutlet weak var switcher: UISwitch!
    
    var landmarksArray: [Landmark] = []
    
    var dataManager = DataManager()
    
    private var isFavoriteList: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesOnlyBg.clipsToBounds = true
        favoritesOnlyBg.layer.cornerRadius = 20
        favoritesOnlyBg.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        self.landmarksArray = dataManager.fetchData()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Landmarks"
        navigationItem.backBarButtonItem = backItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CostumTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
     }
    
    
    
    func getLandmarksArr(_ isFavorite: Bool) -> [Landmark] {
        if isFavorite {
            return landmarksArray.filter {
                return $0.isFavorite
            }
        }
        return landmarksArray
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        isFavoriteList = sender.isOn
    }
}

extension TableListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getLandmarksArr(isFavoriteList).count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CostumTableViewCell
        
        cell.delegate = self
        
        cell.detail = getLandmarksArr(isFavoriteList)[indexPath.row]
        
        cell.landmarkName.text =  getLandmarksArr(isFavoriteList)[indexPath.row].name
        
        let imageName = getLandmarksArr(isFavoriteList)[indexPath.row].name
        let lowerStr = imageName.lowercased()
        let trimmedString = lowerStr.replacingOccurrences(of: " ", with: "")
        
        cell.landmarkIcon.image = UIImage(named: "\(trimmedString)")
        
        cell.landmarkAddToFav.image = getLandmarksArr(isFavoriteList)[indexPath.row].isFavorite == false ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.detail = getLandmarksArr(isFavoriteList)[indexPath.row]

        vc.onReload = { [weak self] model in
            if let index = self?.landmarksArray.firstIndex(where: { myModel in
                return myModel.id == model.id
            }) {
                self?.landmarksArray[index] = model
            }
            self?.tableView.reloadData()
        }
        
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension TableListViewController: LandmarkDataStore {
    
    func storeLandmark(landmark: Landmark?) {
        if let landmarkModel = landmark {
            if let index = landmarksArray.firstIndex(where: { model in
                return model.id == landmarkModel.id
            }) {
                landmarksArray[index] = landmarkModel
                self.tableView.reloadData()
            }
        }
    }
    
}




