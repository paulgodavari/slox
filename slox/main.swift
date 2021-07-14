// main.swift
// slox
//
// Created by Paul Godavari on 2021-02-09.
// Copyright © 2021 Paul Godavari. All rights reserved.


import Foundation


Logger.log("slox starting")

if CommandLine.arguments.count > 2 {
    Logger.log("Usage: jlox [script]")
} else if CommandLine.arguments.count == 2 {
    Lox.runFile(CommandLine.arguments[1])
} else {
    Lox.runPrompt()
}

Logger.log("slox done")

