import Foundation

class MocksUtils {
    class func getDataFromJsonFile(named name: String, subdirectory: String = "Mocks") -> Data? {
        let testBundle = Bundle(for: MocksUtils.self)
        guard let filePath = testBundle.url(forResource: name, withExtension: "json", subdirectory: subdirectory), let data = try? Data(contentsOf: filePath) else { return nil }
        return data
    }
}
