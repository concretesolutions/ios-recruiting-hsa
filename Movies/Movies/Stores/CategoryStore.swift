//
//  CategoryStore.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

//MARK: - Category Store Definition

protocol CategoryStoreProtocol: class {
    
    // Fetch categories
    
    func fetchCategories(completion: @escaping FetchCategoriesCompletion)
}


//MARK: - Typealias

typealias FetchCategoriesCompletion = (FetchCategoriesResult) -> Void

//MARK: - Use cases

enum FetchCategoriesResult {
    case success(_ categories: [Category])
    case failure(_ error: Error)
}
