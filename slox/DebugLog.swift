// DebugLog.swift
// slox
//
// Created by Paul Godavari on 2018-03-15.
// Copyright © 2018 Paul Godavari. All rights reserved.


import Foundation


class Logger {

    static var dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    private class func shortName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }

    // Unused.
    private class func pName(filePath: String) -> String {
        let shortFile = (filePath as NSString).lastPathComponent
        let shortFile2 = (shortFile as NSString).deletingPathExtension
        return shortFile2
    }
    
    class func log(_ message: String = "", fileName: String = #file, line: Int = #line, funcName: String = #function) {
    #if DEBUG
        print("\(Date().toString()): \(shortName(filePath: fileName)) \(funcName):\(line) \(message)")
    #endif
    }
}


extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
