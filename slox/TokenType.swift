// TokenType.swift
// slox
//
// Created by Paul Godavari on 2021-02-10.
// Copyright © 2021 Paul Godavari. All rights reserved.


import Foundation


enum TokenType {
    // Single character tokens:
    case LEFT_PAREN
    case RIGHT_PAREN
    case LEFT_BRACE
    case RIGHT_BRACE
    case COMMA
    case DOT
    case MINUS
    case PLUS
    case SEMICOLON
    case SLASH
    case STAR
    
    // One or two character tokens:
    case BANG
    case BANG_EQUAL
    case EQUAL
    case EQUAL_EQUAL
    case GREATER
    case GREATER_EQUAL
    case LESS
    case LESS_EQUAL
    
    // Literals:
    case IDENTIFIER
    case STRING
    case NUMBER
    
    // Keywords:
    case AND
    case CLASS
    case ELSE
    case FALSE
    case FUN
    case FOR
    case IF
    case NIL
    case OR
    case PRINT
    case RETURN
    case SUPER
    case THIS
    case TRUE
    case VAR
    case WHILE
    
    case EOF
}
