//
//  ErrorViewToModel.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

class ErrorViewToModel: Mapper<ErrorView, ErrorModel> {
    override func reverseMap(value: ErrorModel) -> ErrorView {
        return ErrorView(statusMessage: value.statusMessage, statusCode: value.statusCode)
    }
}
