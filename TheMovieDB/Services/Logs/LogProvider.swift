import Foundation
import os.log

class LogProvider {
    static let shared = LogProvider()
    private let subsystem = "bastianx6.TheMovieDB"
    private let category = "TheMovieDB"

    private init() {}

//    func logNonFatal(error: Error) {
//        Crashlytics.sharedInstance().recordError(error)
//    }

    func log(message: StaticString, type: OSLogType, logCategory: String? = nil, args: CVarArg...) {
        let bundleId = Bundle.main.bundleIdentifier ?? subsystem
        let category = logCategory ?? self.category
        let osLog = OSLog(subsystem: bundleId, category: category)
        os_log(message, log: osLog, type: type, args)
    }
}
