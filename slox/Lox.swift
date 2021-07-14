// Lox.swift
// slox
//
// Created by Paul Godavari on 2021-07-14.
// Copyright © 2021 Paul Godavari. All rights reserved.


import Foundation


class Lox {
    
    static var hadError = false
    
    static func runFile(_ fileName: String) {
        Logger.log()
        if let contents = FileManager.default.contents(atPath: fileName) {
            let source = String(decoding: contents, as: UTF8.self)
            run(source)
            if hadError {
                fatalError()
            }
        }
    }

    static func runPrompt() {
        Logger.log()
        var done = false
        while !done {
            print(">", terminator: " ")
            if let source = readLine(), !source.isEmpty {
                run(source)
                hadError = false
                continue
            }
            done = true
        }
    }

    static func run(_ source: String) {
        Logger.log()
        print("***\n\(source)\n***\n")
    }

    static func error(line: Int, message: String) {
        report(line: line, location: "", message: message)
    }
    
    static func report(line: Int, location: String, message: String) {
        print("[line \(line)] Error \(location): \(message)")
        hadError = true
    }
    
}
