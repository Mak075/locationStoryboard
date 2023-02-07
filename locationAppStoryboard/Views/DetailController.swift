import UIKit
import MapKit

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var detail: Landmark?
    var dataManagerOfCells = CostumTableViewCell()
    
    private let manager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var locationState: UILabel!
    @IBOutlet weak var aboutLocation: UILabel!
    @IBOutlet weak var aboutDescription: UILabel!
    @IBOutlet weak var favoriteStar: UIImageView!
    
    var onReload: ((_ model: Landmark) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapLocationUpdate(latitude: detail?.locationCoordinate.latitude ?? 0, longitude: detail?.locationCoordinate.longitude ?? 0, title: detail!.name)
        
        if let name = detail?.name {
            self.imageView.image = setImage(imageName: name)
            self.imageView.layer.cornerRadius = 50
        }

        self.titleName.text = detail?.name
        self.location.text = detail?.park
        self.locationState.text = detail?.state
        self.aboutLocation.text = "About \(detail?.name ?? "")"

        self.aboutDescription.text = detail?.description
        self.aboutDescription.numberOfLines = 0
        self.aboutDescription.setContentCompressionResistancePriority(.required, for: .vertical)

        self.favoriteStar.image = detail?.isFavorite == true ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")


    }
    
    
    @IBAction func addToFav(_ sender: Any) {
        
        if let isFavorite = detail?.isFavorite {
            detail?.isFavorite = !isFavorite
            favoriteStar.image = !isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        }
        onReload?(detail!)
    }
    
    

    func mapLocationUpdate(latitude: Double, longitude: Double, title: String) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.centerMapOnLocation(location: location, title: title)
    }

    func centerMapOnLocation(location: CLLocationCoordinate2D, title: String) {
        let coordinateRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(coordinateRegion, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        self.mapView.addAnnotation(annotation)
    }
    
    
    func setImage(imageName: String) -> UIImage? {
        let lowerStr = imageName.lowercased()
        let trimmedString = lowerStr.replacingOccurrences(of: " ", with: "")
        return UIImage(named: "\(trimmedString)")
    }
}

//extension DetailViewController: LandmarkDataStore {
//
//    func storeLandmark(_ dataManager: CostumTableViewCell, landmark: Landmark) {
//        DispatchQueue.main.async {
//
//
//            print(landmark)
//            self.detail? = landmark
//
//
//        }
//    }
//
//}
