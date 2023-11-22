//
//  Themes.swift
//
//
//  Created by BoiseITGuru on 11/21/23.
//

import Foundation

public enum Themes {
    case eMacsStrict
    case putty
    case solarizedDark
    case custom(String)
    
    public var url: URL? {
        switch self {
        case .eMacsStrict:
            return URL(string: "https://raw.githubusercontent.com/Forge4Flow/TextMate-Themes/master/Emacs%20Strict.tmTheme")
        case .putty:
            return URL(string: "https://raw.githubusercontent.com/Forge4Flow/TextMate-Themes/master/Putty.tmTheme")
        case .solarizedDark:
            return URL(string: "https://raw.githubusercontent.com/Forge4Flow/TextMate-Themes/master/Solarized%20(dark).tmTheme")
        case .custom(let customUrl):
            return URL(string: customUrl)
        }
    }
}
