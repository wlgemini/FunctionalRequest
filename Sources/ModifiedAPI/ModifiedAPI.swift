//
//  ModifiedAPI.swift
//


public protocol ModifiedAPI {
    associatedtype A: API
    associatedtype M: Modifier
    
    var api: A { get }
    var modifier: M { get }
}


extension ModifiedAPI {
    
    public func modifier<N: Modifier>(_ n: N) -> _ModifiedAPI<A, _ModifierPair<M, N>> {
        _ModifiedAPI(self.api, _ModifierPair(self.modifier, n))
    }
}


// MARK: - Internal
public struct _ModifiedAPI<A: API, M: Modifier>: ModifiedAPI {
    public let api: A
    public let modifier: M
    
    // MARK: Internal
    internal init(_ api: A, _ modifier: M) {
        self.api = api
        self.modifier = modifier
    }
}

public struct _ModifierPair<First: Modifier, Second: Modifier>: Modifier {
    
    public func apply<A: API>(to context: Context<A>) {
        self.first.apply(to: context)
        self.second.apply(to: context)
    }
    
    // MARK: Internal
    let first: First
    let second: Second
    
    internal init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
}
