import Foundation
import UIKit

class FeaturedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var landmarksArray: [Landmark] = []
    var dataManager = DataManager()
    
    var titlesForSections: [String] = ["Mountains", "Lakes", "Rivers"]
    
    var dataSourceArray: [[Landmark]] = [[], [], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.landmarksArray = dataManager.fetchData()
        
        for landmark in landmarksArray {
            
            if(landmark.category == "Mountains") {
                self.dataSourceArray[0].append(landmark)
            }
            
            if(landmark.category == "Lakes") {
                self.dataSourceArray[1].append(landmark)
            }
            
            if(landmark.category == "Rivers") {
                self.dataSourceArray[2].append(landmark)
            }
        }
    }

    @IBAction func profileButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titlesForSections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.landmarksArray = dataSourceArray[indexPath.section]
        cell.collectionView.tag = indexPath.section
        return cell
    }
}





