// AstTest.swift
// AstTest
//
// Created by Paul Godavari on 2023-04-27.
// Copyright © 2023 Paul Godavari. All rights reserved.


import XCTest


final class AstTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSimpleAst() throws {
        let expr: Expr = Binary(left: Unary(oper: Token(type: .MINUS, lexeme: "-", literal: nil, line: 3),
                                            right: Literal(value: 123)),
                                oper: Token(type: .STAR, lexeme: "*", literal: nil, line: 1),
                                right: Grouping(expression: Literal(value: 45.67)))
        let ast = AstPrinter()
        let s = ast.print(expr: expr)
        XCTAssert(s == "(* (- 123) (group 45.67))")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
