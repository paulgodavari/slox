// Expression.swift
// slox
//
// Created by Paul Godavari on 2021-07-21.
// Copyright © 2021 Paul Godavari. All rights reserved.


import Foundation


class Expression {
}


class BinaryExpression: Expression {
    
    var left: Expression
    var oper: Token
    var right: Expression
    
    init(_ left: Expression, _ oper: Token, _ right: Expression) {
        self.left = left
        self.oper = oper
        self.right = right
    }

}
