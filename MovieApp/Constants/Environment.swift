//
//  Environment.swift
//  MovieApp
//
//  Created by Emad Habib on 24/03/2023.
//  Copyright © 2018 Emad Habib. All rights reserved.
//

import Foundation

enum Server {
    case developement
    case staging
    case production
}

class Environment {
    
    static let server:Server = .developement
    
    // To print the log set true.
    static let debug:Bool = true
    
    class func APIBasePath() -> String {
        switch self.server {
        case .developement:
            return "https://api.themoviedb.org/"
        case .staging:
            return "https://api.themoviedb.org/"
        case .production:
            return "https://api.themoviedb.org/"
        }
    }
    
    class func APIVersionPath() -> String {
        switch self.server {
        case .developement:
            return "3/"
        case .staging:
            return "3/"
        case .production:
            return "3/"
        }
    }
    
    class func MOVIEDB_APIKEY() -> String {
        switch self.server {
        case .developement:
            return "c9856d0cb57c3f14bf75bdc6c063b8f3"
        case .staging:
            return "c9856d0cb57c3f14bf75bdc6c063b8f3"
        case .production:
            return "c9856d0cb57c3f14bf75bdc6c063b8f3"
        }
    }
}
