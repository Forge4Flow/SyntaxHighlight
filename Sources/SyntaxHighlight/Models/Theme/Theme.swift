//
//  Theme.swift
//  SyntaxHighlight
//
//  Created by Makoto Aoyama on 2020/09/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

public struct Theme {
    public enum Error : LocalizedError {
        case decodeError

        public var errorDescription: String? {
            switch self {
            case .decodeError: return "decode error"
            }
        }
    }

    public var UUID: String
    public var name: String
    public var backgroundColor: SwiftUI.Color
    public var scopeStyles: [Style]

    public init(dictionary: [String: Any]) throws {
        guard let UUID = dictionary["uuid"] as? String,
            let name = dictionary["name"] as? String,
            let rawSettings = dictionary["settings"] as? [[String: AnyObject]]
            else { throw Error.decodeError }
        self.UUID = UUID
        self.name = name
        self.backgroundColor = .clear
        var scopeStyles: [Style] = []
        for raw in rawSettings {
            if let scopeStyle = Style(from: raw) {
                scopeStyles.append(scopeStyle)
            }

            // Check for a settings dictionary within each raw setting
            if let settingsDict = raw["settings"] as? [String: AnyObject] {
                // Check if this settings dictionary contains a background key
                if let bgColor = settingsDict["background"] as? String {
                    self.backgroundColor = SwiftUI.Color(Color(hex: bgColor)) ?? .clear // Store the background color
                }
            }
        }
        self.scopeStyles = scopeStyles
    }
    
    public init(contentsOf urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        try await self.init(contentsOf: url)
    }

    public init(contentsOf url: URL?) async throws {
        guard let url = url else {
            throw URLError(.badURL)
        }
        
        if url.isFileURL {
            // Handling local file URL
            guard let plist = NSDictionary(contentsOf: url) as? [String: AnyObject] else {
                throw Error.decodeError
            }
            try self.init(dictionary: plist)
        } else {
            // Handling remote URL
            let (data, _) = try await URLSession.withCache.data(from: url)
            guard let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: AnyObject] else {
                throw Error.decodeError
            }
            try self.init(dictionary: plist)
        }
    }

    func selectScopeStyle(for scopeName: ScopeName) -> Style? {
        for theScopeName in scopeName.componentsScopeNames() {
            for scopeStyle in scopeStyles {
                if scopeStyle.scope.contains(theScopeName) {
                    return scopeStyle
                }
            }
        }
        return nil
    }
}

public struct Color {
    public var hex: String
}

public enum Font {
    case italic, bold, underline
}

public struct Style {
    var scope: [ScopeName]
    public var foreground: Color?
    public var background: Color?
    public var fontStyle: Set<Font>

    public init?(from dictionary: [String: AnyObject]) {
        guard let scope = dictionary["scope"] as? String else { return nil }
        guard let settings = dictionary["settings"] as? [String: AnyObject] else { return nil }

        self.scope = scope.components(separatedBy: ",").map { ScopeName(string: $0.trimmingCharacters(in: .whitespaces)) }
        if let value = settings["foreground"] as? String {
            foreground = Color(hex: value)
        }
        if let value = settings["background"] as? String {
            background = Color(hex: value)
        }
        fontStyle = []
        if let value = settings["fontStyle"] as? String {
            if value.contains("italic") {
                fontStyle.insert(.italic)
            }
            if value.contains("bold") {
                fontStyle.insert(.bold)
            }
            if value.contains("underline") {
                fontStyle.insert(.underline)
            }
        }
    }
}

struct ScopeName: Equatable {
    var string: String
    var components: [String] {
        string.components(separatedBy: ".")
    }

    static func == (lhs: ScopeName, rhs: ScopeName) -> Bool {
        return lhs.string == rhs.string
    }

    func componentsScopeNames() -> [ScopeName] {
        var names: [ScopeName] = []
        var c = components
        for _ in components {
            names.append(ScopeName(string: c.joined(separator: ".")))
            c = c.dropLast()
        }
        return names
    }
}
