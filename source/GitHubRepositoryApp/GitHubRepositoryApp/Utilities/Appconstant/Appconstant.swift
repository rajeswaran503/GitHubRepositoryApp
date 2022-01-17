//
//  Appconstant.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 18/01/22.
//

import Foundation


struct NetworkConstants {
    static let baseUrl = "https://api.github.com/"
    static let searchIOS = "search/repositories?q=ios"
}

enum APIPath: String {
    case searchios
    
    var url:String {
       
        return NetworkConstants.baseUrl + NetworkConstants.searchIOS
    }
}
