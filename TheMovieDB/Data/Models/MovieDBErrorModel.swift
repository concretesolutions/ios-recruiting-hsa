import Foundation

struct MovieDBErrorModel: Error, Equatable {
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
