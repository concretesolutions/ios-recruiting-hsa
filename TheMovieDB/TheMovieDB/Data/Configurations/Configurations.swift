import Foundation

enum ConfigurationsKeys: String {
    case movieDbApiKey = "MOVIEDB_APIKEY"
    case movieDbApiEndpoint = "MOVIEDB_ENDPOINT"
    case movieDbImgEndpoint = "MOVIEDB_IMG_ENDPOINT"
}

protocol ConfigurationsProtocol {
    func string(for key: ConfigurationsKeys) -> String?
}

class Configurations: ConfigurationsProtocol {
    static let shared = Configurations()
    private var properties: [String: Any]

    init?() {
        guard let path = Bundle.main.path(forResource: "Configurations", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let propertyAny = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil),
            let propertyDict = propertyAny as? [String: Any] else {
            return nil
        }
        properties = propertyDict
    }

    func string(for key: ConfigurationsKeys) -> String? {
        return properties[key.rawValue] as? String
    }
}
