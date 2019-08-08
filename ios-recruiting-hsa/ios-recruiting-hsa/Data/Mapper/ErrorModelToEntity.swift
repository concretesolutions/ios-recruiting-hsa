//
//  ErrorModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

class ErrorModelToEntity: Mapper<ErrorModel, ErrorEntity> {
    override func reverseMap(value: ErrorEntity) -> ErrorModel {
        return ErrorModel(message: value.message)
    }
}
