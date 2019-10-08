//
//  MovieDetailFeaturesDataSource.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailFeaturesDataSource: NSObject, MovieDetailTableViewDataSource{
    
    let featuresList: [MovieDetailFeatureModel]
    
    required init(movie: MovieDetailModel) {
        self.featuresList = MovieDetailFeaturesDataSource.getFeatureList(forMovie: movie)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailFeatureTableViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? MovieDetailFeatureTableViewCell{
            
            let currentFeat = featuresList[indexPath.row]
            cell.updateInfo(item: currentFeat)
            
        }
        
        return cell
    }
    
    
    class func getFeatureList(forMovie: MovieDetailModel)->[MovieDetailFeatureModel]{
     
        var featuresArray:[MovieDetailFeatureModel] = []
        
        let synopsis = MovieDetailFeatureModel.init(title: "Overview", info: forMovie.overview)
        featuresArray.append(synopsis)
        
        if forMovie.voteAverage > 0.0{
            let voteAvgInfo = "\(forMovie.voteAverage)/10"
            let voteAvg = MovieDetailFeatureModel.init(title: "Vote average", info: voteAvgInfo)
            featuresArray.append(voteAvg)
        }
        
        if forMovie.originalTitle != forMovie.title{
            let originalTitle = MovieDetailFeatureModel.init(title: "Original Title", info: forMovie.originalTitle)
            featuresArray.append(originalTitle)
        }
        
        let status = MovieDetailFeatureModel.init(title: "Status", info: forMovie.status)
        featuresArray.append(status)
        
        let release = MovieDetailFeatureModel.init(title: "Release date", info: forMovie.releaseDate)
        featuresArray.append(release)
        
        if forMovie.budget != 0, let budgetValue = CurrencyHelper.getCurrencyValue(forInt: forMovie.budget) {
            let budget = MovieDetailFeatureModel.init(title: "Budget", info: budgetValue)
            featuresArray.append(budget)
        }
        
        if forMovie.revenue != 0, let revenueValue = CurrencyHelper.getCurrencyValue(forInt: forMovie.revenue){
            let revenue = MovieDetailFeatureModel.init(title: "Revenue", info: revenueValue)
            featuresArray.append(revenue)
        }
        
        if forMovie.runtime > 0, let runtimeValue = TimeHelper.getFormattedTime(fromMinutes: forMovie.runtime){
            let runtime = MovieDetailFeatureModel.init(title: "Runtime", info: runtimeValue)
            featuresArray.append(runtime)
        }
        return featuresArray
    }
    
}
