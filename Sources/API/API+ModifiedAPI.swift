//
//  API+ModifiedAPI.swift
//

extension API where Self: ModifiedAPI, Self == Self.A {
    
    /// api: compute value not take memory
    public var api: Self { self }
    
    /// modifier: compute value not take memory
    public var modifier: some Modifier {
        _ModifierPair(MethodModifier(method: self.method), _PathModifier(path: self.path))
    }
}
