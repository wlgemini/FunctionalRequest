//
//  API.swift
//

public protocol API {
    
    /// Parameters
    associatedtype Parameters
    
    /// Result
    associatedtype Result
    
    /// Modifiers
    associatedtype Modifiers: Modifier
    
    /// method
    var method: String { get }
    
    /// path
    var path: String { get }
    
    /// Modifiers
    var modifiers: Self.Modifiers { get }
}


extension API {
    
    /// modify API
    public func modifier<M: Modifier>(_ m: M) -> some API {
        let modifiers = ModifierPair(first: self.modifiers, second: m)
        return _AnyAPI<Parameters, Result, ModifierPair<Modifiers, M>>(self.method, self.path, modifiers)
    }
}


// MARK: - Internal
internal struct _AnyAPI<Parameters, Result, Modifiers>: API {
    
    var method: String
    
    var path: String
    
    var modifiers: Modifiers
    
    init(_ method: String, _ path: String, _ modifiers: Modifiers) {
        self.method = method
        self.path = path
        self.modifiers = modifiers
    }
}
