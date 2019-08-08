//
//  SpokenLanguageModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

class SpokenLanguageModelToEntity: Mapper<SpokenLanguageModel, SpokenLanguageEntity> {
    override func reverseMap(value : SpokenLanguageEntity) -> SpokenLanguageModel {
        return SpokenLanguageModel(iso6391: value.iso6391, name: value.name)
    }
}
