import Foundation

protocol DataManagerDelegate {
    func storeLocations(_ dataManager: DataManager, landmarks: [Landmark])
    func didFailWithError(error: Error)
}

struct DataManager {
    
    var delegate: DataManagerDelegate?
    
    
    func fetchData() -> [Landmark] {
        
        let data: Data
        guard let file = Bundle.main.url(forResource: "landmarkData", withExtension: "json")
        else {
            fatalError("Couldn't find file")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load file from main bundle:\n\(error)")
        }
        
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Landmark].self, from: data)
        } catch {
            fatalError("Couldn't parse data as: \(error)")
        }
    }
    
}





