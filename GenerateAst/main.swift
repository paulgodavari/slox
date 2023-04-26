// main.swift
// GenerateAst
//
// Created by Paul Godavari on 2023-04-26.
// Copyright © 2023 Paul Godavari. All rights reserved.


import Foundation
import DebugLog


func defineType(_ baseClassName: String, className: String, fields: String) {
    print("class \(className): \(baseClassName) {")
    let fieldChunks = fields.split(separator: ",")
    
    let classMembers = fieldChunks.map { field in
        let variable = field.trimmingCharacters(in: .whitespaces).split(separator: " ")
        let varType = variable[0].trimmingCharacters(in: .whitespaces)
        let varName = variable[1].trimmingCharacters(in: .whitespaces)
        return (varName, varType)
    }
    
    // Define member variables
    for (varName, varType) in classMembers {
        print("    var \(varName): \(varType)")
    }
    
    print("")
    
    // Constructor
    let params = classMembers.map { (name, type) in
        "\(name): \(type)"
    }
    let paramList = params.joined(separator: ", ")
    print("    init(\(paramList)) {")
    for (varName, _) in classMembers {
        print("        self.\(varName) = \(varName)")
    }
    print("    }")

    print("}")
}


func defineAst(_ baseClass: String, types: [String]) {
    print("import Foundation")
    print("")
    for type in types {
        let chunks = type.split(separator: ":")
        let className = chunks[0].trimmingCharacters(in: .whitespaces)
        let fields = chunks[1].trimmingCharacters(in: .whitespaces)
        defineType(baseClass, className: className, fields: fields)
        print("")
    }
}


Logger.log("GenerateAst starting")

if CommandLine.arguments.count == 2 {
    defineAst("Expr", types: [
        "Binard   : Int32 left, String oper, Int32 right",
        "Binary   : Expr left, Token oper, Expr right",
        "Grouping : Expr expression",
        "Literal  : Object value",
        "Unary    : Token oper, Expr right"
    ])
} else {
    Logger.log("Usage: GenerateAst [output_file_name]")
}

Logger.log("GenerateAst done")

