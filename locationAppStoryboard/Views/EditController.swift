import Foundation
import UIKit

protocol StatusDataStore {
    func storeStatus(status: Bool) // 6. posalje u ekstenziju u profile controller
}

class EditController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    
    var delegate: StatusDataStore?
    
    var profileEdit: Profile?
      
    override func viewDidLoad() { // 4. otvori i usnimi
        super.viewDidLoad()
        usernameLabel.text = profileEdit?.username
        switcher.isOn = profileEdit?.prefersNotifications ?? false
    }

    @IBAction func changeStatus(_ sender: UISwitch) {
        delegate?.storeStatus(status: sender.isOn) //  5. update i posalje u protocol gore
    }
}
