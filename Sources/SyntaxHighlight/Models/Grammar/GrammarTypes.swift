//
//  GrammarTypes.swift
//
//
//  Created by BoiseITGuru on 11/21/23.
//

import Foundation

public enum GrammarTypes {
    case cadence
    case custom(String)
    
    public var url: String {
        switch self {
        case .cadence:
            return "https://raw.githubusercontent.com/Forge4Flow/FlowComponents/main/Sources/FlowComponents/Resources/cadence.tmGrammar.json"
        case .custom(let customUrl):
            return customUrl
        }
    }
}
