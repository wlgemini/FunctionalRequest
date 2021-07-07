//
//  ModifierPair.swift
//

public struct ModifierPair<First: Modifier, Second: Modifier>: Modifier {
    
    /// apply to context
    public func apply(to context: ModifierContext) {
        self.first.apply(to: context)
        self.second.apply(to: context)
    }
    
    /// first
    public let first: First
    
    /// second
    public let second: Second
    
    /// init
    public init(first: First, second: Second) {
        self.first = first
        self.second = second
    }
}

