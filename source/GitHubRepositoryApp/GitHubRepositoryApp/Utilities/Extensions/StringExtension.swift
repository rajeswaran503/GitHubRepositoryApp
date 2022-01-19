//
//  StringExtension.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 20/01/22.
//

import UIKit

extension String {
    func parseStringByColon() -> NSMutableAttributedString {
        let splitString = self.split(separator: ":").map({String($0)})
        return NSMutableAttributedString().bold(splitString.first?.appending(":") ?? "").normal(splitString.last ?? "-")
    }
}


extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "AvenirNext-SemiBold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
