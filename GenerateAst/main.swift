// main.swift
// GenerateAst
//
// Created by Paul Godavari on 2023-04-26.
// Copyright © 2023 Paul Godavari. All rights reserved.
//
// A program to generate the Expr classes that will be used in our AST.


import Foundation
import DebugLog


struct Class {
    typealias MemberType = (memberName: String, memberType: String)
    var base: String
    var name: String
    var members: [MemberType]
}


func defineVisitor(visitorName: String, baseClassName: String, classes: [Class]) {
    print("protocol \(visitorName) {")
    print("    associatedtype ReturnType")
    print("    func visit\(baseClassName)(_ expr: \(baseClassName)) -> ReturnType")
    for classSpec in classes {
        print("    func visit\(classSpec.name)\(classSpec.base)(_ expr: \(classSpec.name)) -> ReturnType")
    }
    print("}")
}


func defineBaseClass(name: String) {
    print("class \(name) {")

    // Acceptor for the visitor pattern.
    print("    func accept<V>(_ visitor: V) -> V.ReturnType where V: Visitor {")
    print("        return visitor.visit\(name)(self)")
    print("    }")

    print("}")
}


func getClassFields(_ typeSpec: String, baseName: String) -> Class {
    let chunks = typeSpec.split(separator: ":")
    let className = chunks[0].trimmingCharacters(in: .whitespaces)
    let fields = chunks[1].trimmingCharacters(in: .whitespaces)
    let fieldChunks = fields.split(separator: ",")
    let classMembers = fieldChunks.map { field in
        let variable = field.trimmingCharacters(in: .whitespaces).split(separator: " ")
        let varType = variable[0].trimmingCharacters(in: .whitespaces)
        let varName = variable[1].trimmingCharacters(in: .whitespaces)
        return Class.MemberType(memberName: varName, memberType: varType)
    }
    return Class(base: baseName, name: className, members: classMembers)
}


func defineClass(_ classSpec: Class, protocolSpec: String) {
    print("class \(classSpec.name): \(classSpec.base) {")
    
    // Define member variables
    for (memberName, memberType) in classSpec.members {
        print("    var \(memberName): \(memberType)")
    }
    
    print("")
    
    // Constructor
    let params = classSpec.members.map { (memberName, memberType) in
        "\(memberName): \(memberType)"
    }
    let paramList = params.joined(separator: ", ")
    print("    init(\(paramList)) {")
    for (memberName, _) in classSpec.members {
        print("        self.\(memberName) = \(memberName)")
    }
    print("    }")

    print("")
    
    // Acceptor for the visitor pattern.
    print("    override func accept<V>(_ visitor: V) -> V.ReturnType where V: Visitor {")
    print("        return visitor.visit\(classSpec.name)\(classSpec.base)(self)")
    print("    }")
    print("}")
}


func defineAst(_ baseClassName: String, types: [String]) {
    print("import Foundation")
    print("")
    var classes = [Class]()
    for type in types {
        let classSpec = getClassFields(type, baseName: baseClassName)
        classes.append(classSpec)
    }
    
    defineVisitor(visitorName: "Visitor", baseClassName: baseClassName, classes: classes)
    
    print("")
    print("")

    defineBaseClass(name: baseClassName)

    print("")
    print("")

    for classSpec in classes {
        defineClass(classSpec, protocolSpec: "Acceptor")
        print("")
        print("")
    }
}


Logger.log("GenerateAst starting")

// testVisitor()

if CommandLine.arguments.count == 2 {
    defineAst("Expr", types: [
        "Binary   : Expr left, Token oper, Expr right",
        "Grouping : Expr expression",
        "Literal  : Any value",
        "Unary    : Token oper, Expr right"
    ])
} else {
    Logger.log("Usage: GenerateAst [output_file_name]")
}

Logger.log("GenerateAst done")

