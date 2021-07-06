//
//  Modifier.swift
//

public protocol Modifier {

    /// apply to context
    func apply<A: API>(to context: ModifierContext<A>)
}
