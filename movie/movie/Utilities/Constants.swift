//
//  Constants.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 23/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation


typealias CompletionHandler = (_ Success: Bool, _ errorMessage :String?) -> ()

// URL Constants
let BASE_URL = "https://api.themoviedb.org/3/movie/popular?api_key=d27ffb8c19b10c648282cde73175e74a&language=en-US&page=1"

let BASE_URL_SEARCH = "https://api.themoviedb.org/3/search/multi?api_key=d27ffb8c19b10c648282cde73175e74a&language=en-US&query="
let REST_URL_SEARCH = "&page=1&include_adult=false"

let URL_VEHIClES = "\(BASE_URL)Vehicles?Page=1"
let URL_MAKE = "\(BASE_URL)Make"
let URL_MODEL = "\(BASE_URL)Model?MakeID=1"
let URL_VERSION = "\(BASE_URL)Version?ModelID=1"
let URL_IMG = "https://image.tmdb.org/t/p/w500"

//Segues
let TO_VIDEO = "toVideo"
let TO_SELECTED_VIDEO = "toSelectedVideo"

// User Defaults
let TOKEN_KEY = "token"
let TITLE = "title"
let POSTER_PATH = "poster_path"
let RELEASE_DATE = "release_date"
let GENRE_IDS = "genre_ids"
let OVERVIEW = "overview"
let USER_NAME = "userName"
let IMG = "Img"


// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json"
]
