// Token.swift
// slox
//
// Created by Paul Godavari on 2021-02-10.
// Copyright © 2021 Paul Godavari. All rights reserved.


import Foundation


class Token {
    var type: TokenType
    var lexeme: String
    var literal: Any?
    var line: Int
    
    init(type: TokenType, lexeme: String, literal: Any?, line: Int) {
        self.type = type
        self.lexeme = lexeme
        self.literal = literal
        self.line = line
    }
    
    func toString() -> String {
        return "\(type) \(lexeme) \(literal ?? "")"
    }
}
