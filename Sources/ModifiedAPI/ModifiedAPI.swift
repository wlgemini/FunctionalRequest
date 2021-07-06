//
//  ModifiedAPI.swift
//

public protocol ModifiedAPI {
    
    /// A: API
    associatedtype A: API
    
    /// M: Modifier
    associatedtype M: Modifier
    
    /// api
    var api: A { get }
    
    /// modifier
    var modifier: M { get }
}


extension ModifiedAPI {
    
    /// modify ModifiedAPI
    public func modifier<N: Modifier>(_ n: N) -> some ModifiedAPI {
        _ModifiedAPI(self.api, _ModifierPair(self.modifier, n))
    }
}


// MARK: - Internal
public struct _ModifiedAPI<A: API, M: Modifier>: ModifiedAPI {
    
    /// api
    public let api: A
    
    /// modifier
    public let modifier: M
    
    // MARK: Internal
    internal init(_ api: A, _ modifier: M) {
        self.api = api
        self.modifier = modifier
    }
}

public struct _ModifierPair<First: Modifier, Second: Modifier>: Modifier {
    
    /// apply to context
    public func apply<A: API>(to context: ModifierContext<A>) {
        self.first.apply(to: context)
        self.second.apply(to: context)
    }
    
    // MARK: Internal
    /// first
    internal let first: First
    
    /// second
    internal let second: Second
    
    /// init
    internal init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
}
