// Parser.swift
// slox
//
// Created by Paul Godavari on 2023-04-28.
// Copyright © 2023 Paul Godavari. All rights reserved.


import Foundation


class Parser {
    enum ParseError: Error {
        case parse(String)
    }

    var tokens: [Token]
    var current: Int = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    func parse() -> Expr? {
        do {
            return try expression()
        } catch {
            return nil
        }
    }
    
    func expression() throws -> Expr {
        return try equality()
    }
    
    func equality() throws -> Expr {
        var expr = try comparison()
        while (match(.BANG_EQUAL, .EQUAL_EQUAL)) {
            let oper = previous()
            let right = try comparison()
            expr = Binary(left: expr, oper: oper, right: right)
        }
        return expr
    }
    
    func comparison() throws -> Expr {
        var expr = try term()
        while ((match(.GREATER, .GREATER_EQUAL, .LESS, .LESS_EQUAL))) {
            let oper = previous()
            let right = try term()
            expr = Binary(left: expr, oper: oper, right: right)
        }
        return expr
    }
    
    func term() throws -> Expr {
        var expr = try factor()
        while (match(.MINUS, .PLUS)) {
            let oper = previous()
            let right = try factor()
            expr = Binary(left: expr, oper: oper, right: right)
        }
        return expr
    }
    
    func factor() throws -> Expr {
        var expr = try unary()
        while (match(.SLASH, .STAR)) {
            let oper = previous()
            let right = try unary()
            expr = Binary(left: expr, oper: oper, right: right)
        }
        return expr
    }
    
    func unary() throws -> Expr {
        if (match(.BANG, .MINUS)) {
            let oper = previous()
            let right = try unary()
            return Unary(oper: oper, right: right)
        }
        return try primary()
    }
    
    func primary() throws -> Expr {
        if (match(.FALSE)) {
            return Literal(value: false)
        }
        if (match(.TRUE)) {
            return Literal(value: true)
        }
        if (match(.NIL)) {
            return Literal(value: nil)
        }
        if (match(.NUMBER, .STRING)) {
            return Literal(value: previous().literal)
        }
        if (match(.LEFT_PAREN)) {
            let expr = try expression()
            _ = try consume(.RIGHT_PAREN, message: "Expect ')' after expression.")
            return Grouping(expression: expr)
        }
        
        throw error(token: peek(), message: "Expect expression")
    }
    
    func consume(_ type: TokenType, message: String) throws -> Token {
        if (check(type)) {
            return advance()
        }
        throw error(token: peek(), message: message)
    }
        
    func match(_ types: TokenType...) -> Bool {
        for tokenType in types {
            if (check(tokenType)) {
                _ = advance()
                return true
            }
        }
        return false
    }
    
    func check(_ type: TokenType) -> Bool {
        if (isAtEnd()) {
            return false
        }
        return peek().type == type
    }
    
    func advance() -> Token {
        if (!isAtEnd()) {
            current += 1
        }
        return previous()
    }
    
    func isAtEnd() -> Bool {
        return peek().type == .EOF
    }
    
    func peek() -> Token {
        return tokens[current]
    }
    
    func previous() -> Token {
        return tokens[current - 1]
    }
    
    func error(token: Token, message: String) -> ParseError {
        Lox.error(token: token, message: message)
        return .parse("err")
    }
    
    func synchronize() {
        _ = advance()
        
        while !isAtEnd() {
            if previous().type == .SEMICOLON {
                return
            }
            
            switch peek().type {
                case .CLASS: fallthrough
                case .FUN: fallthrough
                case .VAR: fallthrough
                case .FOR: fallthrough
                case .IF: fallthrough
                case .WHILE: fallthrough
                case .PRINT: fallthrough
                case .RETURN:
                    return
                default:
                    break;
            }
            
            _ = advance()
        }
    }
}
