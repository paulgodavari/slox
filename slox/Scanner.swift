// Scanner.swift
// slox
//
// Created by Paul Godavari on 2021-02-10.
// Copyright © 2021 Paul Godavari. All rights reserved.


import Foundation


class Scanner {
 
    var source: String
    var tokens = [Token]()
    var start: String.Index
    var current: String.Index
    var line: Int = 1
    
    init(source: String) {
        self.source = source
        self.start = source.startIndex
        self.current = start
    }
    
    func scanTokens() -> [Token] {
        while !isAtEnd() {
            start = current
            scanToken()
        }
        
        tokens.append(Token(type: .EOF, lexeme: "", literal: nil, line: line))
        return tokens
    }
    
    func isAtEnd() -> Bool {
        return current == source.endIndex
    }
    
    func scanToken() {
        let c = advance()
        
        switch c {
            case "(": addToken(type: .LEFT_PAREN)
            case ")": addToken(type: .RIGHT_PAREN)
            case "{": addToken(type: .LEFT_BRACE)
            case "}": addToken(type: .RIGHT_BRACE)
            case ",": addToken(type: .COMMA)
            case ".": addToken(type: .DOT)
            case "-": addToken(type: .MINUS)
            case "+": addToken(type: .PLUS)
            case ";": addToken(type: .SEMICOLON)
            case "*": addToken(type: .STAR)
            case "!": addToken(type: (match("=") ? .BANG_EQUAL : .BANG))
            case "=": addToken(type: (match("=") ? .EQUAL_EQUAL : .EQUAL))
            case "<": addToken(type: (match("=") ? .LESS_EQUAL : .LESS))
            case ">": addToken(type: (match("=") ? .GREATER_EQUAL : .GREATER))
            case "/":
                if match("/") {
                    // Consume and ignore comment lines.
                    while peek() != "\n" && !isAtEnd() {
                        _ = advance()
                    }
                } else {
                    addToken(type: .SLASH)
                }
            // Ignore whitespace characters, but count line numbers.
            case " ": break
            case "\r": break
            case "\t": break
            case "\n": line += 1
                
            case "\"": string()
            default: Lox.error(line: line, message: "Unexpected character.")
        }
    }
    
    func advance() -> Character {
        let prev = current
        current = source.index(after: current)
        let char = source[prev]
        return char
    }
    
    func peek() -> Character {
        if isAtEnd() {
            return "\0"
        }
        return source[current]
    }
    
    func addToken(type: TokenType) {
        addToken(type: type, literal: nil)
    }
    
    func addToken(type: TokenType, literal: Any?) {
        let text = String(source[start..<current])
        tokens.append(Token(type: type, lexeme: text, literal: literal, line: line))
    }
    
    func match(_ expected: Character) -> Bool {
        if isAtEnd() {
            return false
        }
        if source[current] != expected {
            return false
        }
        current = source.index(after: current)
        return true
    }
    
    func string() {
        while peek() != "\"" && !isAtEnd() {
            if peek() == "\n" {
                line += 1
            }
            _ = advance()
        }
        
        if isAtEnd() {
            Lox.error(line: line, message: "Unterminated string")
            return
        }
        
        // Closing quote (")
        _ = advance()
        
        let substringRange = source.index(after: start)...source.index(before: current)
        let value = String(source[substringRange])
        addToken(type: .STRING, literal: value)
    }
    
}
