//
//  ModifiedAPI+API.swift
//

extension ModifiedAPI where Self: API, Self.A == Self {
    
    public var api: A { self  }
    public var modifier: _EmptyModifier { _EmptyModifier() }
}
