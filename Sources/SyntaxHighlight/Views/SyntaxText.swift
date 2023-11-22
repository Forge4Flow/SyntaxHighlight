//
//  SyntaxText.swift
//
//
//  Created by BoiseITGuru on 11/21/23.
//

import SwiftUI

public struct SyntaxText: View {
    private var code: String
    private var theme: Themes
    private var grammar: GrammarTypes
    @State private var highlighter: Highlighter?

    public init(code: String, theme: Themes, grammar: GrammarTypes) {
        self.code = code
        self.theme = theme
        self.grammar = grammar
    }

    public var body: some View {
        ViewThatFits {
            verticalView
            ScrollView(.horizontal) {
                verticalView
            }
        }
        .onAppear {
            loadHighlighter()
        }
    }
    
    private var verticalView: some View {
        ViewThatFits {
            codeGroup
            ScrollView(.vertical) {
                codeGroup
            }
        }
    }
    
    private var codeGroup: some View {
        Group {
            if let highlighter = highlighter {
                Text(from: highlighter)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(1)
                    .background(highlighter.theme.backgroundColor.opacity(0.8))
            } else {
                Text(code)
            }
        }
    }

    private func loadHighlighter() {
        Task {
            do {
                let downloadedTheme = try await Theme(contentsOf: theme.url)
                let downloadedGrammar = try await Grammar(url: grammar.url)

                self.highlighter = Highlighter(string: code, theme: downloadedTheme, grammar: downloadedGrammar)
            } catch {
                // Handle errors
                print("Error loading syntax highlighter: \(error)")
            }
        }
    }
}
