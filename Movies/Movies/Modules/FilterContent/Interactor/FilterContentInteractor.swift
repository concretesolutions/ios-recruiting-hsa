//
//  FilterContentInteractor.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class FilterContentInteractor: PresenterToInteractorFilterContentProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("filter content interactor dealloc")
    }
    
    //MARK: - Variables
    
    weak var presenter: InteractorToPresenterFilterContentProtocol?
    fileprivate var worker: FilterContentWorker = FilterContentWorker(repo: CategoriesAPIRepository(), repo: MoviesCoreDataRepository())
    
    
    //MARK: - Fetch Content
    
    func fetchContent(_ type: FilterContent) {
        switch type {
        case .genres:
            worker.fetchGenres { [weak self] (result) in
                switch result {
                case .success(let categories):
                    let content = categories.compactMap({ $0.name })
                    self?.presenter?.fetchContentSuccessfull(content)
                    break
                case .failure(let error):
                    self?.presenter?.failure(error)
                    break
                }
            }
            break
        case .years:
            worker.fetchYears { [weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.presenter?.failure(error)
                    break
                case .success(let years):
                    self?.presenter?.fetchContentSuccessfull(years)
                    break
                }
            }
            break
        }
    }
}
