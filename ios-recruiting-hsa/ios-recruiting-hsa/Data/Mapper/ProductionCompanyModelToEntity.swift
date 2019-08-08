//
//  ProductionCompanyModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

class ProductionCompanyModelToEntity: Mapper<ProductionCompanyModel, ProductionCompanyEntity> {
    override func reverseMap(value : ProductionCompanyEntity) -> ProductionCompanyModel {
        return ProductionCompanyModel(id: value.id,
                                      logoPath: value.logoPath,
                                      name: value.name,
                                      originCountry: value.originCountry
        )
    }
}
