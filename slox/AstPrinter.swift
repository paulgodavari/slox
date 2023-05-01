// AstPrinter.swift
// slox
//
// Created by Paul Godavari on 2023-04-28.
// Copyright © 2023 Paul Godavari. All rights reserved.


import Foundation


class AstPrinter: Visitor {
    typealias ReturnType = String

    func print(expr: Expr) -> String {
        return expr.accept(self)
    }

    func visitExpr(_ expr: Expr) -> String {
        return ""
    }

    func visitBinaryExpr(_ expr: Binary) -> String {
        var ret = "("
        ret.append(expr.oper.lexeme)
        ret.append(" ")
        ret.append(expr.left.accept(self))
        ret.append(" ")
        ret.append(expr.right.accept(self))
        ret.append(")")
        return ret
    }

    func visitGroupingExpr(_ expr: Grouping) -> String {
        var ret = "(group"
        ret.append(" ")
        ret.append(expr.expression.accept(self))
        ret.append(")")
        return ret
    }

    func visitLiteralExpr(_ expr: Literal) -> String {
        if let value = expr.value as? String {
            return value
        }
        if let value = expr.value as? Double {
            return String(value)
        }
        if let value = expr.value as? Int {
            return String(value)
        }
        if let value = expr.value as? Bool {
            return value ? "true" : "false"
        }
        return ""
    }

    func visitUnaryExpr(_ expr: Unary) -> String {
        var ret = "("
        ret.append(expr.oper.lexeme)
        ret.append(" ")
        ret.append(expr.right.accept(self))
        ret.append(")")
        return ret
    }
}
