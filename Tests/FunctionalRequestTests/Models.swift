//
//  Models.swift
//  FunctionalRequestTests
//
//  Created by wangluguang on 2021/3/2.
//

import Foundation


struct Echo: Codable, Equatable {
    let foo: String
    let bar: String
    let baz: String
}

enum Models {

    static let echo = Echo(foo: "x", bar: "y", baz: "z")
    
    static let echoJSON = ["foo": "x", "bar": "y", "baz": "z"]
}
