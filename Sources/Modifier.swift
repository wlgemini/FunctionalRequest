//
//  Modifier.swift
//


/// Modifier
public protocol Modifier {

    func apply(to context: Context)
}


/// Context
public typealias Context = Store.ModifierContext
