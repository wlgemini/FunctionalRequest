//
//  Modifier.swift
//


public protocol Modifier {

    func apply<A: API>(to context: ModifierContext<A>)
}


// MARK: - Internal
public struct _EmptyModifier: Modifier {
    
    public func apply<A: API>(to context: ModifierContext<A>) { }
    
    // MARK: Internal
    internal init() { }
}
