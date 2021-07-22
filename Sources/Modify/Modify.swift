//
//  Modify.swift
//


/// Modify
public protocol Modify {

    func modify(context: Context)
}


/// Context
public typealias Context = Store._Context
