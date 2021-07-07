//
//  Modifier.swift
//

/// API Modifier
public protocol Modifier {

    /// apply to context
    func apply(to context: ModifierContext)
}
