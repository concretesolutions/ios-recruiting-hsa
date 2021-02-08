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
        
        //Si el tipo de datos es generos. Se obtendra los nombres de los generos
        
        case .genres:
            
            //Obtencion de generos
            
            worker.fetchGenres { [weak self] (result) in
                switch result {
                
                //En caso de existo mapear las categorias
                
                case .success(let categories):
                    let content = categories.compactMap({ $0.name })
                    self?.presenter?.fetchContentSuccessfull(content)
                    break
            
                //En caso de fallar. Ir a callback de fallo
                
                case .failure(let error):
                    self?.presenter?.failure(error)
                    break
                }
            }
            break
        
        //En caso de que sean años obtener los años de peliculas
        
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
