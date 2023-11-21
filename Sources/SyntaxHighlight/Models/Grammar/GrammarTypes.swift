//
//  GrammarTypes.swift
//
//
//  Created by BoiseITGuru on 11/21/23.
//

import Foundation

public enum GrammarTypes {
    case cadence
    case javascript
    case swift
    
    case custom(String)
    
    public var url: URL? {
            switch self {
            case .cadence:
                return Bundle.module.url(forResource: "cadence.tmGrammar", withExtension: "json")
            case .javascript:
                return URL(string: "https://raw.githubusercontent.com/microsoft/vscode/main/extensions/javascript/syntaxes/JavaScript.tmLanguage.json")
            case .swift:
                return URL(string: "https://raw.githubusercontent.com/jtbandes/swift-tmlanguage/main/Swift.tmLanguage.json")
            case .custom(let customUrl):
                return URL(string: customUrl)
            }
        }
}
