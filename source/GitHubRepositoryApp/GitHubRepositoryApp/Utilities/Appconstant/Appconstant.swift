//
//  Appconstant.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 18/01/22.
//

import Foundation


struct NetworkConstants {
    static let baseUrl = "https://api.github.com/"
    static let searchIOS = "search/repositories"
}

enum APIPath: String {
    case searchios
    
    var url:String {
        return NetworkConstants.baseUrl + NetworkConstants.searchIOS
    }
}


struct StringConstants {
    static let AuthorName = "Author: "
    static let Language = "Language: "
    static let RepositoryName = "Project: "
    static let HomeTitle = "Repositories"
    static let NetworkConnectionError = "Please check your internet connection."
}
