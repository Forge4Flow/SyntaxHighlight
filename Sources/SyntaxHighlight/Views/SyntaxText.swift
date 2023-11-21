//
//  SyntaxText.swift
//
//
//  Created by BoiseITGuru on 11/21/23.
//

import SwiftUI

public struct SyntaxText: View {
    @StateObject private var viewModel = SyntaxHighlightViewModel()
    @State private var code: String
    @State private var theme: Themes
    @State private var grammar: GrammarTypes

    public init(code: String, theme: Themes, grammar: GrammarTypes) {
        self.code = code
        self.theme = theme
        self.grammar = grammar
    }
    
    public var body: some View {
        Group {
            if let highlighter = viewModel.highlighter {
                Text(from: highlighter)
            } else {
                Text(code)
            }
        }
        .onAppear {
            viewModel.loadHighlighter(string: code, theme: theme, grammar: grammar)
        }
    }
}
