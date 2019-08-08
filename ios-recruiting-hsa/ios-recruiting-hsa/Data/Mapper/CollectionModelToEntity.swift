//
//  CollectionModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

class CollectionModelToEntity: Mapper<CollectionModel, CollectionEntity> {
    private let partModelToEntity: Mapper<PartModel, PartEntity>
    
    init(partModelToEntity: Mapper<PartModel, PartEntity>) {
        self.partModelToEntity = partModelToEntity
    }
    
    override func reverseMap(value : CollectionEntity) -> CollectionModel {
        return CollectionModel(id: value.id,
                               name: value.name,
                               overview: value.overview,
                               posterPath: value.posterPath,
                               backdropPath: value.backdropPath,
                               parts: partModelToEntity.reverseMap(values: value.parts)
        )
    }
}
