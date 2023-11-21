//
//  SyntaxHighlightViewModel.swift
//  
//
//  Created by BoiseITGuru on 11/21/23.
//

import Foundation

class SyntaxHighlightViewModel: ObservableObject {
    @Published var highlighter: Highlighter?
    
    func loadHighlighter(string: String, theme: Themes, grammar: GrammarTypes) {
        Task {
            do {
                let downloadedTheme = try await Theme(contentsOf: theme.url)
                let downloadedGrammar = try await Grammar(contentsOf: grammar.url)
                await MainActor.run {
                    self.highlighter = Highlighter(string: string, theme: downloadedTheme, grammar: downloadedGrammar)
                }
            } catch {
                // Handle errors
                print("Error loading syntax highlight: \(error)")
            }
        }
    }
}
