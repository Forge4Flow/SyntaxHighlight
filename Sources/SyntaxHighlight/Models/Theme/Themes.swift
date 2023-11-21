//
//  Themes.swift
//
//
//  Created by BoiseITGuru on 11/21/23.
//

import Foundation

public enum Themes {
    case eMacsStrict
    case custom(String)
    
    public var url: String {
        switch self {
        case .eMacsStrict:
            return "https://raw.githubusercontent.com/Forge4Flow/TextMate-Themes/master/Emacs%20Strict.tmTheme"
        case .custom(let customUrl):
            return customUrl
        }
    }
}
