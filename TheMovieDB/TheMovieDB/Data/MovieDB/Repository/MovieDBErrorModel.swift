import Foundation

struct MovieDBErrorModel: Error {
    let statusMessage: String
    let statusCode: Int

    init(entity: MovieDBErrorEntity) {
        statusCode = entity.statusCode
        statusMessage = entity.statusMessage
    }

    var localizedDescription: String {
        return statusMessage
    }
}
