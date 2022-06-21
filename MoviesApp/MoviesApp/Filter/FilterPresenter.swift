//
//  FilterPresenter.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 20/06/22.
//

import Foundation
import UIKit

protocol FilterPresenterDelegate: AnyObject{
    func presenteOptionsFilter(options:[Option])
}

typealias PresenterFilterDelegate = FilterPresenterDelegate & UIViewController

//MARK: -
class FilterPresenter{
    weak var delegate: PresenterFilterDelegate?
    let options:[Option] = [
        Option(option:TypeFilter.date,  result:""),
        Option(option:TypeFilter.genres,result:"")
                           ]
    
    public func setViewDelegate(delegate: PresenterFilterDelegate){
        self.delegate = delegate
    }
    
    func getOptions(){
        self.delegate?.presenteOptionsFilter(options: self.options)
    }
    
}
