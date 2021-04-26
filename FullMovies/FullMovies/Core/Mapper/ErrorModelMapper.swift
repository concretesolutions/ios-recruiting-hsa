class ErrorModelMapper: Mapper<ErrorModel, NetworkError> {
    override func reverseMap(value: NetworkError) -> ErrorModel {
        return ErrorModel(
            statusMessage: value.message,
            statusCode: value.status ?? 500
        )
    }
}
