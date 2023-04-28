// main.swift
// slox
//
// Created by Paul Godavari on 2021-02-09.
// Copyright © 2021 Paul Godavari. All rights reserved.


import Foundation
import DebugLog


//func addThings(_ p: Int...) -> Int {
//    var sum = 0
//    for i in p {
//        sum += i
//        print("i=\(i), sum=\(sum)")
//    }
//    return sum
//}
//print("sum: \(addThings(1, 2, 3, 4, 5, 6))")
//print("sum: \(addThings(10, 20, 30, 40, 50))")


Logger.log("slox starting")

if CommandLine.arguments.count > 2 {
    Logger.log("Usage: jlox [script]")
} else if CommandLine.arguments.count == 2 {
    Lox.runFile(CommandLine.arguments[1])
} else {
    Lox.runPrompt()
}

Logger.log("slox done")

