//
//  GenreModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

class GenreModelToEntity: Mapper<GenreModel, GenreEntity> {
    override func reverseMap(value : GenreEntity) -> GenreModel {
        return GenreModel(id: value.id, name: value.name)
    }
}
