import Foundation
import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var notificationLabel: UILabel!
        
    @IBOutlet weak var goalDateLabel: UILabel!
    
    var profile = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userLabel.text = profile.username
        self.notificationLabel.text = "Notifications: \(profile.prefersNotifications ? "On" : "Off")"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM-dd-YYYY"
        let date = Date()
        goalDateLabel.text = "Goal Date: \(dateFormatterGet.string(from: date))"
     }
    
    
    @IBAction func editButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditController") as! EditController
        
        vc.profileEdit = self.profile // 1. usnimis podatke
        vc.delegate = self // 2. sync podatke u 2 viewa
        
        self.present(vc , animated: true) // 3. ode u edit
    }
}

extension ProfileController: StatusDataStore { // 7. update podatke iz edit
    
    func storeStatus(status: Bool) {
        profile.prefersNotifications = status
        notificationLabel.text = "Notifications: \(status ? "On" : "Off")"
    }
}

