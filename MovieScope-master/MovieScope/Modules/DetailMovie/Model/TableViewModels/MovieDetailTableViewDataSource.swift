//
//  MovieDetailTableViewDataSource.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

//Se crea un protocolo aparte para que el viewmodel no haga import a uikit.
protocol MovieDetailTableViewDataSource: UITableViewDataSource{}
