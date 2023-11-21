//
//  Grammar.swift
//  SyntaxHighlight
//
//  Created by BoiseITGuru on 11/21/23.
//

import Foundation
import TMSyntax

public typealias Grammar = TMSyntax.Grammar

public extension TMSyntax.Grammar {
    convenience init(contentsOf urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        if url.isFileURL {
            // Handling local file URL
            let data = try Data(contentsOf: url)
            try self.init(data: data, path: url)
        } else {
            // Handling remote URL
            let (data, _) = try await URLSession.withCache.data(from: url)
            try self.init(data: data)
        }
    }
}

