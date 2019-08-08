//
//  ProductionCountryModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

class ProductionCountryModelToEntity: Mapper<ProductionCountryModel, ProductionCountryEntity> {
    override func reverseMap(value : ProductionCountryEntity) -> ProductionCountryModel {
        return ProductionCountryModel(iso31661: value.iso31661, name: value.name)
    }
}
